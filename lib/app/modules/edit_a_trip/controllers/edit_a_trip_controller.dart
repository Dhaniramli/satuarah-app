import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../theme.dart';

class EditATripController extends GetxController {
  FirebaseAuth auth = FirebaseAuth.instance;
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  RxBool isLoading = false.obs;

  late TextEditingController tripDate;
  late TextEditingController tripTime;
  late TextEditingController tripPrice;
  late TextEditingController otherInformation;
  late TextEditingController fullName;
  late TextEditingController email;
  late TextEditingController idDriver;
  late TextEditingController nomorPlat;
  late TextEditingController merekKendaraan;
  late String chair;
  late String cityStart;
  late String cityFinish;

  doEditATrip(String idTrip) async {
    try {
      if (tripDate.text.isNotEmpty &&
          tripTime.text.isNotEmpty &&
          tripPrice.text.isNotEmpty &&
          fullName.text.isNotEmpty &&
          idDriver.text.isNotEmpty &&
          nomorPlat.text.isNotEmpty &&
          merekKendaraan.text.isNotEmpty &&
          chair.isNotEmpty &&
          cityStart.isNotEmpty &&
          cityFinish.isNotEmpty) {
        await firestore.collection("trip").doc(idTrip).update({
          "trip_date": tripDate.text,
          "trip_time": tripTime.text,
          "trip_price": tripPrice.text,
          "other_information": otherInformation.text,
          "full_name": fullName.text,
          "id_driver": idDriver.text,
          "nomor_plat": nomorPlat.text,
          "merek_kendaraan": merekKendaraan.text,
          "chair": chair,
          "city_start": cityStart,
          "city_finish": cityFinish,
          "id_trip": idTrip,
        });
        Get.snackbar(
          "Berhasil",
          "Berhasil di perbaharui",
          duration: const Duration(seconds: 2),
          snackStyle: SnackStyle.FLOATING,
          backgroundColor: primaryColor,
          colorText: Colors.white,
          borderRadius: 10,
        );
      } else {
        // print("salah");
        Get.snackbar(
          "Kesalahan Sistem",
          "Lengkapi data",
          duration: const Duration(seconds: 2),
          snackStyle: SnackStyle.FLOATING,
          backgroundColor: primaryColor,
          colorText: Colors.white,
          borderRadius: 10,
        );
      }
    } on Exception {
      // print(err);
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
    tripDate = TextEditingController();
    tripTime = TextEditingController();
    tripPrice = TextEditingController();
    otherInformation = TextEditingController();
    fullName = TextEditingController();
    email = TextEditingController();
    idDriver = TextEditingController();
    nomorPlat = TextEditingController();
    merekKendaraan = TextEditingController();
    chair = "";
    cityStart = "";
    cityFinish = "";
    super.onInit();
  }

  @override
  void onClose() {
    tripDate.dispose();
    tripTime.dispose();
    tripPrice.dispose();
    otherInformation.dispose();
    fullName.dispose();
    email.dispose();
    idDriver.dispose();
    nomorPlat.dispose();
    merekKendaraan.dispose();
    super.onClose();
  }
}
