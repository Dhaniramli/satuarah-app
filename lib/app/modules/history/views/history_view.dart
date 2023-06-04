import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:satuarah/app/modules/order_detail/views/order_detail_view.dart';

import '../../../../theme.dart';
import '../controllers/history_controller.dart';

// ignore_for_file: camel_case_types, prefer_typing_uninitialized_variables

import 'package:flutter/material.dart';

class HistoryView extends StatefulWidget {
  const HistoryView({Key? key}) : super(key: key);

  @override
  State<HistoryView> createState() => _HistoryViewState();
}

class _HistoryViewState extends State<HistoryView>
    with SingleTickerProviderStateMixin {
  late TabController tabController;

  @override
  void initState() {
    tabController = new TabController(length: 2, vsync: this);
    super.initState();
  }

  @override
  void dispose() {
    tabController.dispose();
    super.dispose();
  }

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
    Widget tabRiwayat() {
      return ListView.builder(
        itemCount: myHistorys.length,
        itemBuilder: (context, index) => myHistorys[index],
      );
    }

    Widget tabJadwal() {
      return Container(
        margin: const EdgeInsets.symmetric(horizontal: 15),
        child: ListView(
          children: [],
        ),
      );
    }

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60),
        child: AppBar(
          backgroundColor: white,
          bottom: TabBar(
            controller: tabController,
            indicatorColor: primaryColor,
            labelColor: primaryColor,
            unselectedLabelColor: black,
            indicator: BoxDecoration(
                color: white,
                border:
                    Border(bottom: BorderSide(color: primaryColor, width: 3))),
            labelStyle:
                textPrimaryStyle.copyWith(fontSize: 16, fontWeight: semiBold),
            tabs: <Widget>[
              Tab(
                text: 'Jadwal',
              ),
              Tab(
                text: 'Riwayat',
              ),
            ],
          ),
        ),
      ),
      body: TabBarView(
        controller: tabController,
        children: <Widget>[
          tabJadwal(),
          tabRiwayat(),
        ],
      ),
    );
  }
}
