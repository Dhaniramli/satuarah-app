import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../../../theme.dart';
import '../controllers/leaving_today_controller.dart';
import 'widgets/card_full.dart';

class LeavingTodayView extends GetView<LeavingTodayController> {
  LeavingTodayView({Key? key}) : super(key: key);

  final List<Widget> myLeavings = List.generate(
    20,
    (index) => const CardFull(),
  ).reversed.toList();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Berangkat Hari Ini'),
        centerTitle: true,
        leading: IconButton(
          onPressed: () => Get.back(),
          icon: const Icon(
            Icons.arrow_back_ios,
            color: white,
          ),
        ),
      ),
      body: ListView.builder(
        itemCount: myLeavings.length,
        itemBuilder: (context, index) => myLeavings[index],
      ),
    );
  }
}
