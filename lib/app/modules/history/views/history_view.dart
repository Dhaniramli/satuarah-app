import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../theme.dart';
import '../../../data/models/trip_model.dart';
import '../../../routes/app_pages.dart';
import '../../order_detail/views/order_detail_view.dart';
import '../controllers/history_controller.dart';
import 'widgets/card_full.dart';

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
    tabController = TabController(length: 2, vsync: this);
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
    final controller = Get.put(HistoryController());

    Widget tabRiwayat() {
      return StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
        stream: controller.firestore
            .collection('trip')
            .where("id_driver", isEqualTo: controller.auth.currentUser!.uid)
            .where("trip_status", isEqualTo: "Selesai")
            .snapshots(),
        // stream: controller.streamHistory(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          if (snapshot.data!.docs.isEmpty) {
            return const Center(
              child: Text("Tidak Ada Data"),
            );
          }

          List<TripModel> allTrip = [];

          for (var element in snapshot.data!.docs) {
            allTrip.add(TripModel.fromJson(element.data()));
          }
          return ListView.builder(
            itemCount: allTrip.length,
            itemBuilder: (context, index) {
              TripModel trip = allTrip[index];
              return CardFull(
                fullNameC: trip.fullName,
                startC: trip.cityStart,
                finishC: trip.cityFinish,
                dateC: trip.tripDate,
                timeC: trip.tripTime,
                priceC: trip.tripPrice,
                onPressed: () {
                  Get.toNamed(Routes.ORDERING, arguments: trip);
                },
              );
            },
          );
        },
      );
    }

    Widget tabJadwal() {
      return StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
        stream: controller.firestore
            .collection('trip')
            .where("id_driver", isEqualTo: controller.auth.currentUser!.uid)
            .where('trip_status',
                whereIn: ['Menunggu', 'Dalam Perjalanan']).snapshots(),
        // stream: controller.streamHistory(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(
              child: Text("Tidak Ada"),
            );
          }

          if (snapshot.data!.docs.isEmpty) {
            return const Center(
              child: Text("Tidak Ada Data"),
            );
          }

          List<TripModel> allTrip = [];

          for (var element in snapshot.data!.docs) {
            allTrip.add(TripModel.fromJson(element.data()));
          }
          return ListView.builder(
            itemCount: allTrip.length,
            itemBuilder: (context, index) {
              TripModel trip = allTrip[index];
              return CardFull(
                fullNameC: trip.fullName,
                startC: trip.cityStart,
                finishC: trip.cityFinish,
                dateC: trip.tripDate,
                timeC: trip.tripTime,
                priceC: trip.tripPrice,
                onPressed: () {
                  Get.toNamed(Routes.ORDERING, arguments: trip);
                },
              );
            },
          );
        },
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
