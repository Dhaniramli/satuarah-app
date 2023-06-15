import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:satuarah/app/routes/app_pages.dart';

import '../../../../theme.dart';

class SignUpController extends GetxController {
  FirebaseAuth auth = FirebaseAuth.instance;
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  late TextEditingController fullName;
  late TextEditingController email;
  late TextEditingController phoneNumber;
  late TextEditingController password;
  late TextEditingController passwordConfirmation;

  RxBool isLoading = false.obs;
  RxBool isHiddenOne = true.obs;
  RxBool isHiddenTwo = true.obs;

  doSignUp() async {
    try {
      if (fullName.text.isNotEmpty &&
          email.text.isNotEmpty &&
          phoneNumber.text.isNotEmpty &&
          password.text.isNotEmpty &&
          passwordConfirmation.text.isNotEmpty) {
        if (password.text == passwordConfirmation.text) {
          final userAuth = await auth.createUserWithEmailAndPassword(
            email: email.text,
            password: password.text,
          );

          String idUser = userAuth.user!.uid;

          await firestore.collection("users").doc(idUser).set({
            "full_name": fullName.text,
            "email": email.text,
            "phone_number": phoneNumber.text,
            "user_as": "costumer",
            "id_user": idUser,
            "createAt": DateTime.now().toIso8601String(),
            "status":false,
          });

          Get.snackbar(
            "Berhasil",
            "Data anda berhasil di rekam",
            duration: const Duration(seconds: 2),
            snackStyle: SnackStyle.FLOATING,
            backgroundColor: primaryColor,
            colorText: Colors.white,
            borderRadius: 10,
          );
          fullName.clear();
          email.clear();
          phoneNumber.clear();
          password.clear();
          passwordConfirmation.clear();
          Get.toNamed(Routes.mainNavigation);
        } else {
          print("pass salah");
        }
      } else {
        Get.snackbar(
          "Terjadi Kesalahan",
          "Semua data harus terisi",
          duration: const Duration(seconds: 2),
          snackStyle: SnackStyle.FLOATING,
          backgroundColor: primaryColor,
          colorText: Colors.white,
          borderRadius: 10,
        );
      }
    } on Exception catch (err) {
      print(err);
      Get.snackbar(
        "Kesalahan Sistem",
        "Tidak dapat melakukan pendaftaran",
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
    fullName = TextEditingController();
    email = TextEditingController();
    phoneNumber = TextEditingController();
    password = TextEditingController();
    passwordConfirmation = TextEditingController();
    super.onInit();
  }

  @override
  void onClose() {
    fullName.dispose();
    email.dispose();
    phoneNumber.dispose();
    password.dispose();
    passwordConfirmation.dispose();
    super.onClose();
  }
}
