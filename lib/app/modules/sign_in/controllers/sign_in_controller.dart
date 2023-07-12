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
      if (e.code == 'user-not-found') {
        isLoading(false);
        return {
          "error": true,
          "message": "Email tidak terdaftar",
        };
      } else if (e.code == 'wrong-password') {
        isLoading(false);
        return {
          "error": true,
          "message": "Email atau Password Salah",
        };
      } else if (e.code == 'too-many-requests') {
        isLoading(false);
        return {
          "error": true,
          "message": "Akun Anda telah diblokir. Silakan coba lagi nanti.",
        };
      }
    } catch (e) {
      isLoading(false);
      return {
        "error": true,
        "message": "$e",
      };
    }
    return {
      "error": false,
      "message": "",
    };
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
