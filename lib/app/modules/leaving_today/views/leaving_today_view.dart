import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/leaving_today_controller.dart';

class LeavingTodayView extends GetView<LeavingTodayController> {
  const LeavingTodayView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('LeavingTodayView'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'LeavingTodayView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
