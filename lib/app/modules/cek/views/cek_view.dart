import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../../../theme.dart';
import '../controllers/cek_controller.dart';
import 'widgets/card_full.dart';

class CekView extends GetView<CekController> {
  CekView({Key? key}) : super(key: key);

  final List<Widget> myCek = List.generate(
    20,
    (index) => const CardFull(),
  ).reversed.toList();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Makassar - Bone'),
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
        itemCount: myCek.length,
        itemBuilder: (context, index) => myCek[index],
      ),
    );
  }
}
