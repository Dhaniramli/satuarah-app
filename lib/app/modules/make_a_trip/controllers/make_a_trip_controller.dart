import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MakeATripController extends GetxController {
  late TextEditingController tripDate;
  late TextEditingController tripTime;
  late String chair;
  late String cityStart;
  late String cityFinish;

  @override
  void onInit() {
    tripDate = TextEditingController();
    tripTime = TextEditingController();
    chair = "";
    cityStart = "";
    cityFinish = "";
    super.onInit();
  }

  @override
  void onClose() {
    tripDate.dispose();
    tripTime.dispose();
    super.onClose();
  }
}
