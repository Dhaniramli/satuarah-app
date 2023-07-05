import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../../../theme.dart';
import '../../../data/models/trip_model.dart';
import '../../../routes/app_pages.dart';
import '../controllers/leaving_today_controller.dart';
import 'widgets/card_full.dart';

class LeavingTodayView extends GetView<LeavingTodayController> {
  const LeavingTodayView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(LeavingTodayController());

    return Scaffold(
      appBar: AppBar(
        title: const Text('Semua Tebengan'),
        centerTitle: true,
        leading: IconButton(
          onPressed: () => Get.back(),
          icon: const Icon(
            Icons.arrow_back_ios,
            color: white,
          ),
        ),
      ),
      body: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
        stream: controller.streamtrip(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
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
                photoC: trip.photo,
                onPressed: () {
                  Get.toNamed(Routes.ORDERING, arguments: trip);
                },
              );
            },
          );
        },
      ),
    );
  }
}
