import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          SizedBox(
            width: 50,
            height: 50,
            child: IconButton(
              onPressed: () {
                controller.doLogout();
              },
              icon: const Icon(
                Icons.add,
                size: 24.0,
              ),
            ),
          )
        ],
      ),
    );
  }
}
