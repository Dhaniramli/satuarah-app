import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SignInController extends GetxController {
  RxBool isLoading = false.obs;
  RxBool isHidden = true.obs;

  late TextEditingController email;
  late TextEditingController password;

  FirebaseAuth auth = FirebaseAuth.instance;

  Future<Map<String, dynamic>> signIn(String email, String password) async {
    try {
      await auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return {
        "error": false,
        "message": "Berhasil Login",
      };
    } on FirebaseAuthException catch (e) {
      return {
        "error": true,
        "message": "${e.message}",
      };
    } catch (e) {
      return {
        "error": true,
        "message": "Tidak Dapat Login",
      };
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
