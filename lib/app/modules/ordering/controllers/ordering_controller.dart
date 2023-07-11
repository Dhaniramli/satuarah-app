import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../../theme.dart';
import '../../../data/models/trip_model.dart';

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
  String? chatRoomIdC;
  int totalUnread = 0;
  DateTime now = DateTime.now();

  Stream<QuerySnapshot<Map<String, dynamic>>> streamPenumpang(
      String tripId) async* {
    yield* firestore
        .collection('trip')
        .doc(tripId)
        .collection("ride")
        .snapshots();
  }

  Future<void> deleteTrip(String tripId, String userId, dynamic trip,
      Map<String, dynamic>? userMap) async {
    try {
      CollectionReference tripRef = _firestore.collection("trip");
      String date = DateTime.now().toIso8601String();

      CollectionReference chats = _firestore.collection("chats");
      CollectionReference users = _firestore.collection("users");
      final TripModel tripC = trip;

      await tripRef.doc(tripId).collection("request").doc(userId).delete();

      await tripRef.doc(tripId).update({
        "request_field": FieldValue.arrayRemove([userId]),
      });

      final doChats =
          await users.doc(_auth.currentUser!.uid).collection("chats").get();
      final checkConnection = await users
          .doc(_auth.currentUser!.uid)
          .collection("chats")
          .where("connection", isEqualTo: userMap!["id_user"])
          .get();

      // PESAN LOGIC
      await chats.doc(checkConnection.docs[0].id).collection("chats").add({
        "pengirim": _auth.currentUser!.uid,
        "penerima": userMap["id_user"],
        "msg":
            "Maaf, kita tidak jadi berangkat bareng, \n->Berangkat dari ${tripC.thoroughfareStart}, ${tripC.subLocalityStart}, ${tripC.localityStart}, ${tripC.subAdministrativeAreaStart}, \n->Berhenti di ${tripC.thoroughfareFinish}, ${tripC.subLocalityFinish}, ${tripC.localityFinish}, ${tripC.subAdministrativeAreaFinish}, \n->${tripC.tripDate} ${tripC.tripTime}",
        "time": Timestamp.now(),
        "isRead": false,
        "jm": DateFormat.jm().format(DateTime.parse(date)),
        "groupTime": DateFormat.yMMMMd('en_US').format(DateTime.parse(date)),
      });

      await users
          .doc(_auth.currentUser!.uid)
          .collection("chats")
          .doc(checkConnection.docs[0].id)
          .update({
        "lastTime": date,
      });

      final checkChatsFriend = await users
          .doc(userMap["id_user"])
          .collection("chats")
          .doc(checkConnection.docs[0].id)
          .get();

      if (checkChatsFriend.exists) {
        // exist on friend DB
        // first cek total unread

        final checkTotalUnread = await chats
            .doc(checkConnection.docs[0].id)
            .collection("chats")
            .where("isRead", isEqualTo: false)
            .where("pengirim", isEqualTo: _auth.currentUser!.uid)
            .get();

        // total unread for friend
        totalUnread = checkTotalUnread.docs.length;

        await users
            .doc(userMap["id_user"])
            .collection("chats")
            .doc(checkConnection.docs[0].id)
            .update({
          "lastTime": date,
          "total_unread": totalUnread,
        });
      } else {
        // not exist on friend DB
        await users
            .doc(userMap["id_user"])
            .collection("chats")
            .doc(checkConnection.docs[0].id)
            .set({
          "connection": _auth.currentUser!.uid,
          "chat_id": checkConnection.docs[0].id,
          "total_unread": 1,
          "lastTime": date,
        });
      }

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
      // print("Error deleting trip: $e");
      Get.snackbar(
        "Terjadi Kesalahan",
        "Error $e",
        duration: const Duration(seconds: 2),
        snackStyle: SnackStyle.FLOATING,
        backgroundColor: white,
        colorText: primaryColor,
        borderRadius: 10,
      );

      // Tambahkan penanganan kesalahan sesuai kebutuhan Anda.
    }
  }

  Future<void> deleteRides(String tripId) async {
    try {
      CollectionReference tripRef = _firestore.collection("trip");
      await tripRef.doc(tripId).update({
        "rides": FieldValue.arrayRemove([_auth.currentUser!.uid]),
      });

      await tripRef
          .doc(tripId)
          .collection("ride")
          .doc(_auth.currentUser!.uid)
          .delete();

      Get.snackbar(
        "Berhasil membatalkan",
        "",
        duration: const Duration(seconds: 2),
        snackStyle: SnackStyle.FLOATING,
        backgroundColor: white,
        colorText: primaryColor,
        borderRadius: 10,
      );
    } catch (e) {
      // print("Error deleting trip: $e");
      Get.snackbar(
        "Terjadi Kesalahan",
        "Error $e",
        duration: const Duration(seconds: 2),
        snackStyle: SnackStyle.FLOATING,
        backgroundColor: white,
        colorText: primaryColor,
        borderRadius: 10,
      );

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

  void addNewRide(Map<String, dynamic>? userMap, String tripId, String userId,
      dynamic trip) async {
    String date = DateTime.now().toIso8601String();
    CollectionReference tripRef = _firestore.collection("trip");
    CollectionReference chats = _firestore.collection("chats");
    CollectionReference users = _firestore.collection("users");
    final TripModel tripC = trip;

   await users.doc(_auth.currentUser!.uid).collection("chats").get();
    final checkConnection = await users
        .doc(_auth.currentUser!.uid)
        .collection("chats")
        .where("connection", isEqualTo: userMap!["id_user"])
        .get();

    final requestMe = await tripRef
        .doc(tripId)
        .collection("request")
        .doc(_auth.currentUser!.uid)
        .get();

    // REQUEST
    if (requestMe != true) {
      await tripRef.doc(tripId).collection("request").doc(userId).delete();

      await tripRef.doc(tripId).collection("ride").doc(userMap["id_user"]).set(
        {
          "full_name": userMap["full_name"],
          "photo": userMap["photo"],
          "id_user": userMap["id_user"],
        },
      );
      await tripRef.doc(tripId).update({
        "request_field": FieldValue.arrayRemove([userId]),
      });

      await tripRef.doc(tripId).update({
        "rides": FieldValue.arrayUnion([userId]),
      });

      // PESAN LOGIC
      await chats.doc(checkConnection.docs[0].id).collection("chats").add({
        "pengirim": _auth.currentUser!.uid,
        "penerima": userMap["id_user"],
        "msg":
            "Ayo, kita berangkat bareng, \n->Berangkat dari ${tripC.thoroughfareStart}, ${tripC.subLocalityStart}, ${tripC.localityStart}, ${tripC.subAdministrativeAreaStart}, \n->Berhenti di ${tripC.thoroughfareFinish}, ${tripC.subLocalityFinish}, ${tripC.localityFinish}, ${tripC.subAdministrativeAreaFinish}, \n->${tripC.tripDate} ${tripC.tripTime}",
        "time": Timestamp.now(),
        "isRead": false,
        "jm": DateFormat.jm().format(DateTime.parse(date)),
        "groupTime": DateFormat.yMMMMd('en_US').format(DateTime.parse(date)),
      });

      await users
          .doc(_auth.currentUser!.uid)
          .collection("chats")
          .doc(checkConnection.docs[0].id)
          .update({
        "lastTime": date,
      });

      final checkChatsFriend = await users
          .doc(userMap["id_user"])
          .collection("chats")
          .doc(checkConnection.docs[0].id)
          .get();

      if (checkChatsFriend.exists) {
        // exist on friend DB
        // first cek total unread

        final checkTotalUnread = await chats
            .doc(checkConnection.docs[0].id)
            .collection("chats")
            .where("isRead", isEqualTo: false)
            .where("pengirim", isEqualTo: _auth.currentUser!.uid)
            .get();

        // total unread for friend
        totalUnread = checkTotalUnread.docs.length;

        await users
            .doc(userMap["id_user"])
            .collection("chats")
            .doc(checkConnection.docs[0].id)
            .update({
          "lastTime": date,
          "total_unread": totalUnread,
        });
      } else {
        // not exist on friend DB
        await users
            .doc(userMap["id_user"])
            .collection("chats")
            .doc(checkConnection.docs[0].id)
            .set({
          "connection": _auth.currentUser!.uid,
          "chat_id": checkConnection.docs[0].id,
          "total_unread": 1,
          "lastTime": date,
        });
      }

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
      if (requestMe != null) {
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
        await tripRef.doc(tripId).update({
          "request_field": FieldValue.arrayUnion([_auth.currentUser!.uid]),
        });

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

      // PESAN LOGIC
      await chats.doc(chat_id).collection("chats").add({
        "pengirim": _auth.currentUser!.uid,
        "penerima": tripC.idDriver,
        "msg":
            "Saya ingin ikut perjalanan anda,\n->Berangkat dari ${tripC.thoroughfareStart}, ${tripC.subLocalityStart}, ${tripC.localityStart}, ${tripC.subAdministrativeAreaStart}, \n->Berhenti di ${tripC.thoroughfareFinish}, ${tripC.subLocalityFinish}, ${tripC.localityFinish}, ${tripC.subAdministrativeAreaFinish}, \n->${tripC.tripDate} ${tripC.tripTime}",
        "time": Timestamp.now(),
        "isRead": false,
        "jm": DateFormat.jm().format(DateTime.parse(date)),
        "groupTime": DateFormat.yMMMMd('en_US').format(DateTime.parse(date)),
      });

      await users
          .doc(_auth.currentUser!.uid)
          .collection("chats")
          .doc(chat_id)
          .update({
        "lastTime": date,
      });

      final checkChatsFriend = await users
          .doc(tripC.idDriver)
          .collection("chats")
          .doc(chat_id)
          .get();

      if (checkChatsFriend.exists) {
        // exist on friend DB
        // first cek total unread

        final checkTotalUnread = await chats
            .doc(chat_id)
            .collection("chats")
            .where("isRead", isEqualTo: false)
            .where("pengirim", isEqualTo: _auth.currentUser!.uid)
            .get();

        // total unread for friend
        totalUnread = checkTotalUnread.docs.length;

        await users
            .doc(tripC.idDriver)
            .collection("chats")
            .doc(chat_id)
            .update({
          "lastTime": date,
          "total_unread": totalUnread,
        });
      } else {
        // not exist on friend DB
        await users.doc(tripC.idDriver).collection("chats").doc(chat_id).set({
          "connection": _auth.currentUser!.uid,
          "chat_id": chat_id,
          "total_unread": 1,
          "lastTime": date,
        });
      }
    } on Exception catch (err) {
      Get.snackbar("Terjadi kesalahan", "$err");
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

  // @override
  // void onInit() {
  //   super.onInit();
  // }

  // @override
  // void onClose() {
  //   super.onClose();
  // }
}
