import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../../../theme.dart';
import '../controllers/search_ride_controller.dart';

class SearchRideView extends GetView<SearchRideController> {
  const SearchRideView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(''),
        centerTitle: true,
        leading: IconButton(
          onPressed: () => Get.back(),
          icon: const Icon(
            Icons.arrow_back_ios,
            color: white,
          ),
        ),
      ),
      body: const Center(
        child: Text(
          'SearchRideView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
