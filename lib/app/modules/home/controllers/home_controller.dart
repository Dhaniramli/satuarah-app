import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:satuarah/app/routes/app_pages.dart';

class HomeController extends GetxController {
  FirebaseAuth auth = FirebaseAuth.instance;
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  doLogout() async {
    await auth.signOut();
    Get.toNamed(Routes.signIn);
  }

  DocumentReference get userCollection {
    return FirebaseFirestore.instance
        .collection("users")
        .doc(auth.currentUser!.uid);
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> streamtrip() async* {
    yield* firestore.collection('trip').snapshots();
  }

  final count = 0.obs;
  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  void increment() => count.value++;
}
