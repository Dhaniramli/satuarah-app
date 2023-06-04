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
  late String chair;
  late String cityStart;
  late String cityFinish;

  doMakeATrip() async {
    try {
      if (tripDate.text.isNotEmpty &&
          tripTime.text.isNotEmpty &&
          tripPrice.text.isNotEmpty &&
          chair.isNotEmpty &&
          cityStart.isNotEmpty &&
          cityFinish.isNotEmpty) {
        await firestore.collection("trip").add({
          "trip_date": tripDate.text,
          "trip_time": tripTime.text,
          "trip_price": tripPrice.text,
          "other_information": otherInformation.text,
          "chair": chair,
          "city_start": cityStart,
          "city_finish": cityFinish,
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
        tripDate.clear();
        tripTime.clear();
        tripPrice.clear();
        otherInformation.clear();
        chair = "";
        cityStart = "";
        cityFinish = "";
        Get.back();
      } else {
        print("salah");
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
    tripDate = TextEditingController();
    tripTime = TextEditingController();
    tripPrice = TextEditingController();
    otherInformation = TextEditingController();
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
    super.onClose();
  }
}
