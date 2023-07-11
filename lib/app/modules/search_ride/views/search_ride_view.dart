import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../../../../theme.dart';
import '../../../data/models/trip_model.dart';
import '../../../routes/app_pages.dart';
import '../controllers/search_ride_controller.dart';
import 'widgets/card_full.dart';

class SearchRideView extends StatefulWidget {
  const SearchRideView({super.key});

  @override
  State<SearchRideView> createState() => _SearchRideViewState();
}

class _SearchRideViewState extends State<SearchRideView> {
  List searchResult = [];

  void searchFromFirebase(String query) async {
    final controller = Get.put(SearchRideController());
    try {
      controller.isLoading(true);
      final result = await FirebaseFirestore.instance
          .collection('trip')
          .where("trip_status", whereIn: ['Menunggu', 'Dalam Perjalanan'])
          .where("subAdministrativeArea_finish_array", arrayContains: query.toLowerCase())
          .get();

      setState(() {
        searchResult = result.docs.map((e) => e.data()).toList();
      });
      controller.isLoading(false);
    } on Exception catch (err) {
      controller.isLoading(false);
      Get.snackbar(
        "Terjadi kesalahan",
        "$err",
        duration: const Duration(seconds: 2),
        snackStyle: SnackStyle.FLOATING,
        backgroundColor: primaryColor,
        colorText: Colors.white,
        borderRadius: 10,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(SearchRideController());

    return Scaffold(
      appBar: AppBar(
        backgroundColor: white,
        leading: IconButton(
          onPressed: () => Get.back(),
          icon: Icon(
            Icons.arrow_back_ios,
            color: primaryColor,
          ),
        ),
        leadingWidth: 40,
        actions: [
          const SizedBox(width: 40),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 10),
              child: TextFormField(
                controller: controller.inputan,
                decoration: InputDecoration(
                  hintText: 'ketikkan kota/kabupaten tujuan anda',
                  hintStyle: TextStyle(color: primaryColor),
                  filled: true,
                  fillColor: Colors.transparent,
                  border: InputBorder.none,
                ),
                style: TextStyle(color: primaryColor),
                onChanged: (value) {
                  setState(() {
                    searchFromFirebase(value);
                  });
                },
                onFieldSubmitted: (value) {
                  setState(() {
                    searchFromFirebase(value);
                  });
                },
              ),
            ),
          ),
        ],
      ),
      body: Obx(
        () => controller.isLoading.isTrue
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : controller.inputan.text.isEmpty
                ? SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.only(top: 200),
                      child: Center(
                        child: Icon(
                          Icons.search,
                          size: 70,
                          color: primaryColor,
                        ),
                      ),
                    ),
                  )
                : searchResult.isEmpty
                    ? SingleChildScrollView(
                        child: Padding(
                          padding: const EdgeInsets.only(top: 200),
                          child: Center(
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
                                  "Tujuan tidak ditemukan",
                                  style: textGrayStyle.copyWith(
                                      fontWeight: semiBold),
                                ),
                              ],
                            ),
                          ),
                        ),
                      )
                    : ListView.builder(
                        itemCount: searchResult.length,
                        itemBuilder: (BuildContext context, int index) {
                          TripModel trip = TripModel(
                            latitudeStart: searchResult[index]
                                ["latitude_start"],
                            latitudeFinish: searchResult[index]
                                ["latitude_finish"],
                            longitudeStart: searchResult[index]
                                ["longitude_start"],
                            longitudeFinish: searchResult[index]
                                ["longitude_finish"],
                            subLocalityStart: searchResult[index]
                                ["subLocality_start"],
                            subLocalityFinish: searchResult[index]
                                ["subLocality_finish"],
                            localityStart: searchResult[index]
                                ["locality_start"],
                            localityFinish: searchResult[index]
                                ["locality_finish"],
                            thoroughfareStart: searchResult[index]
                                ["thoroughfare_start"],
                            thoroughfareFinish: searchResult[index]
                                ["thoroughfare_finish"],
                            subAdministrativeAreaStart:
                                "${searchResult[index]["subAdministrativeArea_start"]}",
                            subAdministrativeAreaFinish:
                                "${searchResult[index]["subAdministrativeArea_finish"]}",
                            chair: "${searchResult[index]["chair"]}",
                            email: "${searchResult[index]["email"]}",
                            fullName: "${searchResult[index]["full_name"]}",
                            idDriver: "${searchResult[index]["id_driver"]}",
                            idTrip: "${searchResult[index]["id_trip"]}",
                            merekKendaraan:
                                "${searchResult[index]["merek_kendaraan"]}",
                            nomorPlat: "${searchResult[index]["nomor_plat"]}",
                            otherInformation:
                                "${searchResult[index]["other_information"]}",
                            photo: "${searchResult[index]["photo"]}",
                            tripDate: "${searchResult[index]["trip_date"]}",
                            tripPrice: "${searchResult[index]["trip_price"]}",
                            tripStatus: "${searchResult[index]["trip_status"]}",
                            tripTime: "${searchResult[index]["trip_time"]}",
                            rides: ["${searchResult[index][index]}"],
                            requestField: ["${searchResult[index][index]}"],
                          );

                          return CardFull(
                            latitudeStartC: double.parse(trip.latitudeStart),
                            latitudeFinishC: double.parse(trip.latitudeFinish),
                            longitudeStartC: double.parse(trip.longitudeStart),
                            longitudeFinishC:
                                double.parse(trip.longitudeFinish),
                            localityStartC: trip.localityStart,
                            localityFinishC: trip.localityFinish,
                            subAdministrativeAreaStartC:
                                trip.subAdministrativeAreaStart,
                            subAdministrativeAreaFinishC:
                                trip.subAdministrativeAreaFinish,
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
                              WidgetsBinding.instance.addPostFrameCallback((_) {
                                FocusScope.of(context).unfocus();
                              });
                              SystemChannels.textInput
                                  .invokeMethod('TextInput.hide');
                            },
                          );
                        },
                      ),
      ),
    );
  }
}
