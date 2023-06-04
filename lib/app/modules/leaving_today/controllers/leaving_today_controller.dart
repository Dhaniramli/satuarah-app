import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class LeavingTodayController extends GetxController {
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  Stream<QuerySnapshot<Map<String, dynamic>>> streamtrip() async* {
    yield* firestore.collection('trip').snapshots();
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
