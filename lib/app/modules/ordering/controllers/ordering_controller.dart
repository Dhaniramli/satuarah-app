import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class OrderingController extends GetxController {
  FirebaseAuth auth = FirebaseAuth.instance;
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  RxBool isLoading = false.obs;

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
