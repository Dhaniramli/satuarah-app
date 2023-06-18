import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:get/get_connect/http/src/request/request.dart';
import 'package:satuarah/app/data/models/user_model.dart';

import '../../../../theme.dart';
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

  Future<void> deleteTrip(String tripId, String userId) async {
    try {
      CollectionReference tripRef = _firestore.collection("trip");

      await tripRef.doc(tripId).collection("request").doc(userId).delete();

       Get.snackbar(
        "Berhasil",
        "Permintaan anda tolak",
        duration: const Duration(seconds: 2),
        snackStyle: SnackStyle.FLOATING,
        backgroundColor: white,
        colorText: primaryColor,
        borderRadius: 10,
      );
    } catch (e) {
      print("Error deleting trip: $e");
      // Tambahkan penanganan kesalahan sesuai kebutuhan Anda.
    }
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> streamtrip(String tripId) async* {
    yield* firestore
        .collection('trip')
        .doc(tripId)
        .collection("request")
        .snapshots();
  }

  void addNewRide(Map<String, dynamic>? userMap, String tripId) async {
    CollectionReference tripRef = _firestore.collection("trip");

    final requestMe = await tripRef
        .doc(tripId)
        .collection("request")
        .doc(_auth.currentUser!.uid)
        .get();

    // REQUEST
    if (requestMe != true) {
      await tripRef
          .doc(tripId)
          .collection("ride")
          .doc(_auth.currentUser!.uid)
          .set(
        {
          "full_name": userMap!["full_name"],
          "photo": userMap["photo"],
          "id_user": userMap["id_user"],
        },
      );
      Get.snackbar(
        "Berhasil",
        "",
        duration: const Duration(seconds: 2),
        snackStyle: SnackStyle.FLOATING,
        backgroundColor: white,
        colorText: primaryColor,
        borderRadius: 10,
      );
    }
  }

  // LOGIC CHAT
  void addNewConnection(
      dynamic trip, Map<String, dynamic>? userMap, String tripId) async {
    try {
      String date = DateTime.now().toIso8601String();
      CollectionReference chats = _firestore.collection("chats");
      CollectionReference users = _firestore.collection("users");
      CollectionReference tripRef = _firestore.collection("trip");
      final TripModel tripC = trip;

      final doChats =
          await users.doc(_auth.currentUser!.uid).collection("chats").get();
      final docRef = await users.doc(_auth.currentUser!.uid).get();

      final requestMe = await tripRef
          .doc(tripId)
          .collection("request")
          .doc(_auth.currentUser!.uid)
          .get();

      // REQUEST
      if (requestMe != true) {
        await tripRef
            .doc(tripId)
            .collection("request")
            .doc(_auth.currentUser!.uid)
            .set(
          {
            "full_name": docRef["full_name"] ?? "",
            "photo": docRef["photo"] ?? "",
            "id_user": _auth.currentUser!.uid,
          },
        );
        Get.snackbar(
          "Berhasil",
          "Menunggu di setujui oleh driver",
          duration: const Duration(seconds: 2),
          snackStyle: SnackStyle.FLOATING,
          backgroundColor: white,
          colorText: primaryColor,
          borderRadius: 10,
        );
      } else {
        Get.snackbar(
          "Menunggu di setujui oleh driver",
          "",
          duration: const Duration(seconds: 2),
          snackStyle: SnackStyle.FLOATING,
          backgroundColor: white,
          colorText: primaryColor,
          borderRadius: 10,
        );
      }

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

      // Get.to(
      //   () => ChatRoomView(
      //     userMap: userMap,
      //     chatRoomid: chat_id,
      //     friendEmail: tripC.idDriver,
      //   ),
      // );
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
