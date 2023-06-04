import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../theme.dart';

class RegisterDriverController extends GetxController {
  FirebaseAuth auth = FirebaseAuth.instance;
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  RxBool isLoading = false.obs;

  late TextEditingController nomorKtp;
  late TextEditingController nomorSim;
  late TextEditingController nomorPlat;
  late TextEditingController merekKendaraan;

  doRegisterDriver() async {
    try {
      if (nomorKtp.text.isNotEmpty &&
          nomorSim.text.isNotEmpty &&
          nomorPlat.text.isNotEmpty &&
          merekKendaraan.text.isNotEmpty) {
        await firestore.collection("users").doc(auth.currentUser!.uid).update({
          "nomor_ktp": nomorKtp.text,
          "nomor_sim": nomorSim.text,
          "nomor_plat": nomorPlat.text,
          "merek_kendaraan": merekKendaraan.text,
          "user_as": "driver",
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
        nomorKtp.clear();
        nomorSim.clear();
        nomorPlat.clear();
        merekKendaraan.clear();
        Get.back();
      } else {
        print("pass salah");
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
    nomorKtp = TextEditingController();
    nomorSim = TextEditingController();
    nomorPlat = TextEditingController();
    merekKendaraan = TextEditingController();
    super.onInit();
  }

  @override
  void onClose() {
    nomorKtp.dispose();
    nomorSim.dispose();
    nomorPlat.dispose();
    merekKendaraan.dispose();
    super.onClose();
  }
}
