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
  @override
  Widget build(BuildContext context) {
    final controller = Get.put(SearchRideController());

    // Setelah widget terbangun, fokus diberikan ke TextFormField
    // WidgetsBinding.instance.addPostFrameCallback((_) {
    //   FocusScope.of(context).requestFocus(controller.textFormFieldFocusNode);
    // });

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
                focusNode: controller.textFormFieldFocusNode,
                controller: controller.inputan,
                decoration: InputDecoration(
                  hintText: 'ketikkan tujuan anda',
                  hintStyle: TextStyle(color: primaryColor),
                  filled: true,
                  fillColor: Colors.transparent,
                  border: InputBorder.none,
                ),
                style: TextStyle(color: primaryColor),
                onChanged: (value) {
                  setState(() {
                    controller.searchTrip(value);
                  });
                },
                onFieldSubmitted: (value) {
                  setState(() {
                    controller.searchTrip(value);
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
                : controller.tempSearch.isEmpty
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
                        // Padding(
                        //   padding: const EdgeInsets.only(top: 200),
                        //   child: Center(
                        //     child: Icon(
                        //       Icons.search,
                        //       size: 70,
                        //       color: primaryColor,
                        //     ),
                        //   ),
                        // ),
                      )
                    : ListView.builder(
                        itemCount: controller.tempSearch.length,
                        itemBuilder: (BuildContext context, int index) {
                          TripModel trip = TripModel(
                            latitudeStart: controller.tempSearch[index]
                                ["latitude_start"],
                            latitudeFinish: controller.tempSearch[index]
                                ["latitude_finish"],
                            longitudeStart: controller.tempSearch[index]
                                ["longitude_start"],
                            longitudeFinish: controller.tempSearch[index]
                                ["longitude_finish"],
                            subLocalityStart: controller.tempSearch[index]
                                ["subLocality_start"],
                            subLocalityFinish: controller.tempSearch[index]
                                ["subLocality_finish"],
                            localityStart: controller.tempSearch[index]
                                ["locality_start"],
                            localityFinish: controller.tempSearch[index]
                                ["locality_finish"],
                            thoroughfareStart: controller.tempSearch[index]
                                ["thoroughfare_start"],
                            thoroughfareFinish: controller.tempSearch[index]
                                ["thoroughfare_finish"],
                            subAdministrativeAreaFinish:
                                "${controller.tempSearch[index]["subAdministrativeArea_start"]}",
                            subAdministrativeAreaStart:
                                "${controller.tempSearch[index]["subAdministrativeArea_finish"]}",
                            chair: "${controller.tempSearch[index]["chair"]}",
                            email: "${controller.tempSearch[index]["email"]}",
                            fullName:
                                "${controller.tempSearch[index]["full_name"]}",
                            idDriver:
                                "${controller.tempSearch[index]["id_driver"]}",
                            idTrip:
                                "${controller.tempSearch[index]["id_trip"]}",
                            merekKendaraan:
                                "${controller.tempSearch[index]["merek_kendaraan"]}",
                            nomorPlat:
                                "${controller.tempSearch[index]["nomor_plat"]}",
                            otherInformation:
                                "${controller.tempSearch[index]["other_information"]}",
                            photo: "${controller.tempSearch[index]["photo"]}",
                            tripDate:
                                "${controller.tempSearch[index]["trip_date"]}",
                            tripPrice:
                                "${controller.tempSearch[index]["trip_price"]}",
                            tripStatus:
                                "${controller.tempSearch[index]["trip_status"]}",
                            tripTime:
                                "${controller.tempSearch[index]["trip_time"]}",
                            rides: ["${controller.tempSearch[index][index]}"],
                            requestField: [
                              "${controller.tempSearch[index][index]}"
                            ],
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
