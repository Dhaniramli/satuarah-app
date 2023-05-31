import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/register_driver_controller.dart';

class RegisterDriverView extends GetView<RegisterDriverController> {
  const RegisterDriverView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('RegisterDriverView'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'RegisterDriverView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
