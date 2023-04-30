import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/popular_route_controller.dart';

class PopularRouteView extends GetView<PopularRouteController> {
  const PopularRouteView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('PopularRouteView'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'PopularRouteView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
