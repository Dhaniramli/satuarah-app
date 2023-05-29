import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../theme.dart';
import '../controllers/find_ride_controller.dart';
import 'widgets/card_full.dart';

class FindRideView extends GetView<FindRideController> {
  FindRideView({Key? key}) : super(key: key);

  final List<Widget> myFindRides = List.generate(
    20,
    (index) => const CardFull(),
  ).reversed.toList();

  @override
  Widget build(BuildContext context) {
     return Scaffold(
      appBar: AppBar(
        title: const Text('Cari Tebengan'),
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
        itemCount: myFindRides.length,
        itemBuilder: (context, index) => myFindRides[index],
      ),
    );
  }
}
