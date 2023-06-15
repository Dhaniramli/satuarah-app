import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

import '../../../data/models/trip_model.dart';
import '../../chat_room/views/chat_room_view.dart';

class OrderingController extends GetxController {
  FirebaseAuth auth = FirebaseAuth.instance;
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  RxBool isLoading = false.obs;

  bool flagNewConnection = false;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  Map<String, dynamic>? userMap;
  late String roomId;
  var chat_id;
  // LOGIC CHAT
  void addNewConnection(dynamic trip, Map<String, dynamic>? userMap) async {
    try {
      String date = DateTime.now().toIso8601String();
      CollectionReference chats = _firestore.collection("chats");
      CollectionReference users = _firestore.collection("users");
      final TripModel tripC = trip;

      final doChats =
          await users.doc(_auth.currentUser!.uid).collection("chats").get();

      if (doChats.docs.isNotEmpty) {
        final checkConnection = await users
            .doc(_auth.currentUser!.uid)
            .collection("chats")
            .where("connection", isEqualTo: tripC.idDriver)
            .get();

        if (checkConnection.docs.isNotEmpty) {
          flagNewConnection = false;

          //chat_id from chats collection
          chat_id = checkConnection.docs[0].id;
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
              tripC.idDriver,
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
          "connection": tripC.idDriver,
          "chat_id": newChatDoc,
          "total_unread": 0,
          "lastTime": date,
        });

        chat_id = newChatDoc.id;
      }

      // Get.toNamed(Routes.CHAT_ROOM, arguments: trip);

      Get.to(
        () => ChatRoomView(
          userMap: userMap,
          chatRoomid: chat_id,
          friendEmail: tripC.idDriver,
        ),
      );
    } on Exception catch (err) {
      print(err);
    }
  }
  // AKHIR LOGIC CHAT

  doDelete(String idTrip) async {
    await firestore.collection("trip").doc(idTrip).delete();
    Get.back();
    Get.back();
  }

  doUpdateSatu(String idTrip) async {
    await firestore.collection("trip").doc(idTrip).update({
      "trip_status": "Dalam Perjalanan",
    });
  }

  doUpdateDua(String idTrip) async {
    await firestore.collection("trip").doc(idTrip).update({
      "trip_status": "Selesai",
    });
  }

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onClose() {
    super.onClose();
  }
}
