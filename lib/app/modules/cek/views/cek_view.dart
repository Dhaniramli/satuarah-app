import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:text_scroll/text_scroll.dart';

import '../../../../theme.dart';
import '../../../data/models/trip_model.dart';
import '../../../routes/app_pages.dart';
import '../controllers/cek_controller.dart';
import 'widgets/card_full.dart';

class CekView extends GetView<CekController> {
  final String? cityStart;
  final String? cityFinish;

  const CekView(this.cityStart, this.cityFinish, {super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(CekController());

    return Scaffold(
      appBar: AppBar(
        title: TextScroll(
          '$cityStart - $cityFinish',
          mode: TextScrollMode.endless,
          velocity: const Velocity(pixelsPerSecond: Offset(50, 0)),
          style: textWhiteStyle.copyWith(
            fontSize: 15,
            fontWeight: semiBold,
          ),
        ),
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
        stream: controller.streamtrip(cityStart!, cityFinish!),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          if (snapshot.data!.docs.isEmpty) {
            return Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    "assets/nothing.png",
                    width: 50.0,
                    height: 90.0,
                    fit: BoxFit.fill,
                  ),
                  const SizedBox(height: 10),
                  Text(
                    "Tidak ada tebengan",
                    style: textGrayStyle.copyWith(fontWeight: semiBold),
                  ),
                ],
              ),
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
                latitudeStartC: double.parse(trip.latitudeStart),
                latitudeFinishC: double.parse(trip.latitudeFinish),
                longitudeStartC: double.parse(trip.longitudeStart),
                longitudeFinishC: double.parse(trip.longitudeFinish),
                localityStartC: trip.localityStart,
                localityFinishC: trip.localityFinish,
                subAdministrativeAreaStartC: trip.subAdministrativeAreaStart,
                subAdministrativeAreaFinishC: trip.subAdministrativeAreaFinish,
                subLocalityStartC: trip.subLocalityStart,
                subLocalityFinishC: trip.subLocalityFinish,
                thoroughfareStartC: trip.thoroughfareStart,
                thoroughfareFinishC: trip.thoroughfareFinish,
                fullNameC: trip.fullName,
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
