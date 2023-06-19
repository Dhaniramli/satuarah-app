import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../theme.dart';
import '../../../data/models/trip_model.dart';
import '../../../routes/app_pages.dart';
import '../controllers/search_ride_controller.dart';
import 'widgets/card_full.dart';

class SearchRideView extends GetView<SearchRideController> {
  @override
  Widget build(BuildContext context) {
    final controller = Get.put(SearchRideController());

    // Setelah widget terbangun, fokus diberikan ke TextFormField
    WidgetsBinding.instance?.addPostFrameCallback((_) {
      FocusScope.of(context).requestFocus(controller.textFormFieldFocusNode);
    });

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => Get.back(),
          icon: const Icon(
            Icons.arrow_back_ios,
            color: white,
          ),
        ),
        leadingWidth: 40,
        actions: [
          const SizedBox(width: 40),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 10),
              child: TextFormField(
                focusNode: controller.textFormFieldFocusNode,
                controller: controller.inputan,
                decoration: const InputDecoration(
                  hintText: 'ketikkan tujuan anda',
                  hintStyle: TextStyle(color: white),
                  filled: true,
                  fillColor: Colors.transparent,
                  border: InputBorder.none,
                ),
                style: const TextStyle(color: white),
                textInputAction: TextInputAction.done,
                onChanged: (value) => controller.searchTrip(value),
                onFieldSubmitted: (value) {
                  controller.searchTrip(value);
                },
                onEditingComplete: () {
                  // Aksi yang dilakukan ketika keyboard mengklik tombol "Done"
                  // Misalnya, menyimpan nilai atau melakukan pencarian
                },
              ),
            ),
          ),
        ],
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
                fullNameC: "Belum Ada",
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
