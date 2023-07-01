import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

import '../../../routes/app_pages.dart';

class ProfileController extends GetxController {
  RxBool statusSwitch1 = false.obs;
  RxBool statusSwitch2 = false.obs;

  FirebaseFirestore firestore = FirebaseFirestore.instance;
  FirebaseAuth auth = FirebaseAuth.instance;

  doLogout() async {
    try {
      final userRef = firestore.collection("users").doc(auth.currentUser?.uid);
      userRef.update({
        'status': false,
      });
      await auth.signOut();
      Get.offAllNamed(Routes.signIn);
    } on Exception catch (err) {
      print(err);
    }
  }

  DocumentReference get userCollection {
    return FirebaseFirestore.instance
        .collection("users")
        .doc(auth.currentUser?.uid);
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
