import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SearchRideController extends GetxController {
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  late TextEditingController inputan;

  RxBool isLoading = false.obs;

  @override
  void onInit() {
    inputan = TextEditingController();

    super.onInit();
  }

  @override
  void onClose() {
    inputan.dispose();
    super.onClose();
  }
}
