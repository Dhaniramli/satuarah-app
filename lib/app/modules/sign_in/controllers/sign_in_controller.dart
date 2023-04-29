import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../theme.dart';
import '../../../routes/app_pages.dart';

class SignInController extends GetxController {
  RxBool isLoading = false.obs;

  late TextEditingController email;
  late TextEditingController password;

  FirebaseAuth auth = FirebaseAuth.instance;

  doLogin() async {
    try {
      if (email.text.isNotEmpty && password.text.isNotEmpty) {
        await auth.signInWithEmailAndPassword(
          email: email.text,
          password: password.text,
        );
        isLoading.isFalse;
        Get.toNamed(Routes.home);
      } else {
        Get.snackbar(
          "Terjadi Kesalahan",
          "email dan password tidak boleh kososng",
          duration: const Duration(seconds: 2),
          snackStyle: SnackStyle.FLOATING,
          backgroundColor: primaryColor,
          colorText: Colors.white,
          borderRadius: 10,
        );
      }
    } on Exception catch (err) {
      Get.snackbar(
        "Terjadi Kesalahan",
        "Tidak dapat masuk",
        duration: const Duration(seconds: 2),
        snackStyle: SnackStyle.FLOATING,
        backgroundColor: primaryColor,
        colorText: Colors.white,
        borderRadius: 10,
      );
    }
  }

  @override
  void onInit() {
    email = TextEditingController();
    password = TextEditingController();
    super.onInit();
  }

  @override
  void onClose() {
    email.dispose();
    password.dispose();
    super.onClose();
  }
}
