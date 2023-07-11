import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

import '../../../../theme.dart';
import '../../chat_room/views/chat_room_view.dart';

class ChatController extends GetxController {
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  FirebaseAuth auth = FirebaseAuth.instance;
  String uidC = FirebaseAuth.instance.currentUser!.uid;

  bool flagNewConnection = false;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  Map<String, dynamic>? userMap;
  late String roomId;
  String chatId = '';
  // LOGIC CHAT
  void addNewConnection(String uidUser, Map<String, dynamic> userMap) async {
    try {
      String date = DateTime.now().toIso8601String();
      CollectionReference chats = _firestore.collection("chats");
      CollectionReference users = _firestore.collection("users");
      // final TripModel tripC = trip;

      final doChats =
          await users.doc(_auth.currentUser!.uid).collection("chats").get();

      if (doChats.docs.isNotEmpty) {
        final checkConnection = await users
            .doc(_auth.currentUser!.uid)
            .collection("chats")
            .where("connection", isEqualTo: uidUser)
            .get();

        if (checkConnection.docs.isNotEmpty) {
          flagNewConnection = false;

          //chatId from chats collection
          chatId = checkConnection.docs[0].id;
        } else {
          flagNewConnection = true;
          // belum pernah chat dengan driver
        }
      } else {
        flagNewConnection = true;
      }

      if (flagNewConnection == true) {
        final newChatDoc = await chats.add(
          {
            "connections": [
              _auth.currentUser!.uid,
              uidUser,
            ],
            "lastTime": date,
          },
        );
        // ignore: await_only_futures
        await chats.doc(newChatDoc.id).collection("chats");

        await users
            .doc(_auth.currentUser!.uid)
            .collection("chats")
            .doc(newChatDoc.id)
            .set({
          "connection": uidUser,
          "chatId": newChatDoc,
          "total_unread": 0,
          "lastTime": date,
        });

        chatId = newChatDoc.id;
      }

      // Get.toNamed(Routes.CHAT_ROOM, arguments: trip);
      final updateStatusChat = await chats
          .doc(chatId)
          .collection("chats")
          .where("isRead", isEqualTo: false)
          .where("penerima", isEqualTo: uidUser)
          .get();

      updateStatusChat.docs.forEach((element) async {
        await chats
            .doc(chatId)
            .collection("chats")
            .doc(element.id)
            .update({"isRead": true});
      });

      await users.doc(uidUser).collection("chats").doc(chatId).update({
        "total_unread": 0,
      });

      Get.to(
        () => ChatRoomView(
          userMap: userMap,
          chatRoomid: chatId,
          friendEmail: uidUser,
        ),
      );
    } on Exception catch (err) {
      // print(err);
      Get.snackbar(
        "Terjadi kesalahan",
        "$err",
        duration: const Duration(seconds: 2),
        snackStyle: SnackStyle.FLOATING,
        backgroundColor: primaryColor,
        colorText: white,
        borderRadius: 10,
      );
    }
  }
  // AKHIR LOGIC CHAT

  Stream<QuerySnapshot<Map<String, dynamic>>> chatStream(String email) {
    return firestore
        .collection("users")
        .doc(email)
        .collection("chats")
        .orderBy("lastTime", descending: true)
        .snapshots();
  }

  Stream<DocumentSnapshot<Map<String, dynamic>>> friendStream(String email) {
    return firestore.collection("users").doc(email).snapshots();
  }

  selectChat(String chatId, String email, Map<String, dynamic>? userMap,
      String friendEmail) async {
    CollectionReference chats = firestore.collection("chats");
    CollectionReference users = firestore.collection("users");

    Get.to(() => ChatRoomView(
          userMap: userMap,
          chatRoomid: chatId,
          friendEmail: friendEmail,
        ));

    final updateStatusChat = await chats
        .doc(chatId)
        .collection("chats")
        .where("isRead", isEqualTo: false)
        .where("penerima", isEqualTo: auth.currentUser!.uid)
        .get();

    updateStatusChat.docs.forEach((element) async {
      await chats
          .doc(chatId)
          .collection("chats")
          .doc(element.id)
          .update({"isRead": true});
    });

    await users
        .doc(auth.currentUser!.uid)
        .collection("chats")
        .doc(chatId)
        .update({
      "total_unread": 0,
    });
  }

  // @override
  // void onInit() {
  //   super.onInit();
  // }

  // @override
  // void onReady() {
  //   super.onReady();
  // }

  // @override
  // void onClose() {
  //   super.onClose();
  // }
}
