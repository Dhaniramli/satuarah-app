import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../theme.dart';

class MakeATripController extends GetxController {
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
  late String photo;
  late String chair;
  late String cityStart;
  late String cityFinish;

  doMakeATrip() async {
    try {
      if (tripDate.text.isNotEmpty &&
          tripTime.text.isNotEmpty &&
          tripPrice.text.isNotEmpty &&
          fullName.text.isNotEmpty &&
          email.text.isNotEmpty &&
          idDriver.text.isNotEmpty &&
          nomorPlat.text.isNotEmpty &&
          merekKendaraan.text.isNotEmpty &&
          chair.isNotEmpty &&
          cityStart.isNotEmpty &&
          cityFinish.isNotEmpty) {
        var docRef = await firestore.collection("trip").add({
          "trip_date": tripDate.text,
          "trip_time": tripTime.text,
          "trip_price": tripPrice.text,
          "other_information": otherInformation.text,
          "full_name": fullName.text,
          "email_driver": email.text,
          "id_driver": idDriver.text,
          "rides": [
            idDriver.text,
          ],
          "request_field": [],
          "nomor_plat": nomorPlat.text,
          "merek_kendaraan": merekKendaraan.text,
          "chair": chair,
          "city_start": cityStart,
          "city_finish": cityFinish,
          "photo": photo,
          "trip_status": "Menunggu",
        });

        firestore.collection("trip").doc(docRef.id).update({
          "id_trip": docRef.id,
        });

        tripDate.clear();
        tripTime.clear();
        tripPrice.clear();
        otherInformation.clear();
        chair = "";
        cityStart = "";
        cityFinish = "";
        Get.back();
        Get.back();
      } else {
        // Get.snackbar("Terjadi kesalahan", "Lengkapi semua");
      }
    } on Exception {
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
    photo = "";
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
