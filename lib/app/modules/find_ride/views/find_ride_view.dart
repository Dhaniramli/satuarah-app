import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/find_ride_controller.dart';

class FindRideView extends GetView<FindRideController> {
  const FindRideView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('FindRideView'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'FindRideView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
