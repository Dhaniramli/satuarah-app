import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class LeavingTodayController extends GetxController {
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  Stream<QuerySnapshot<Map<String, dynamic>>> streamtrip() async* {
    yield* firestore.collection('trip').where("trip_status",
        whereIn: ['Menunggu', 'Dalam Perjalanan']).snapshots();
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
