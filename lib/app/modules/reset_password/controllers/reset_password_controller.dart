import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../theme.dart';

class ResetPasswordController extends GetxController {
  late TextEditingController email;
  var isAuth = false.obs;
  RxBool isLoading = false.obs;
  late String typeC;

  Future<void> send() async {
    if (email.text.isNotEmpty) {
      try {
        isLoading(true);
        await FirebaseAuth.instance.sendPasswordResetEmail(email: email.text);
        email.clear();
        Get.snackbar(
          "Berhasil",
          "Silahkan periksa email anda",
          duration: const Duration(seconds: 2),
          snackStyle: SnackStyle.FLOATING,
          backgroundColor: primaryColor,
          colorText: Colors.white,
          borderRadius: 10,
        );
        isLoading(false);
      } on Exception {
        Get.snackbar(
          "Terjadi Kesalahaan",
          "Email tidak terdaftar",
          duration: const Duration(seconds: 2),
          snackStyle: SnackStyle.FLOATING,
          backgroundColor: primaryColor,
          colorText: Colors.white,
          borderRadius: 10,
        );
      }
      isLoading(false);
    }
  }

  @override
  void onInit() {
    email = TextEditingController();
    super.onInit();
  }

  @override
  void onClose() {
    email.dispose();
    super.onClose();
  }
}
