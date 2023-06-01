import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:satuarah/app/modules/order_detail/views/order_detail_view.dart';

import '../../../../theme.dart';
import '../controllers/history_controller.dart';

class HistoryView extends GetView<HistoryController> {
  HistoryView({Key? key}) : super(key: key);

  final List<Widget> myHistorys = List.generate(
    20,
    (index) => Container(
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: grayDuaColor,
          ),
        ),
      ),
      child: ListTile(
        onTap: () {
          Get.to(() => OrderDetailView());
        },
        leading: CircleAvatar(
          radius: 30,
          child: Image.asset(
            "assets/profile.png",
            fit: BoxFit.cover,
          ),
        ),
        title: Text(
          "Orang ke ${index + 1}",
          style: textBigBlackStyle.copyWith(fontSize: 19, fontWeight: semiBold),
        ),
        subtitle: Text(
          "Telah sampai ${index + 1}",
          style: textBigBlackStyle.copyWith(fontSize: 15, fontWeight: regular),
        ),
      ),
    ),
  ).reversed.toList();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: white,
      appBar: AppBar(
        title: const Text('Riwayat'),
        centerTitle: true,
      ),
      body: ListView.builder(
        itemCount: myHistorys.length,
        itemBuilder: (context, index) => myHistorys[index],
      ),
    );
  }
}
