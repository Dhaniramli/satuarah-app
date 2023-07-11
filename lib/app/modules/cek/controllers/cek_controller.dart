import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class CekController extends GetxController {
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  Stream<QuerySnapshot<Map<String, dynamic>>> streamtrip(
      String cityStart, String cityfinish) async* {
    yield* firestore
        .collection('trip')
        .where("subAdministrativeArea_start", isEqualTo: cityStart)
        .where("subAdministrativeArea_finish", isEqualTo: cityfinish)
        .where("trip_status",
            whereIn: ['Menunggu', 'Dalam Perjalanan']).snapshots();
  }
  // final count = 0.obs;
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

  // void increment() => count.value++;
}
