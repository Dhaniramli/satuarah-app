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
        () => controller.tempSearch.isEmpty
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
            : controller.isLoading.isTrue
                ? const Center(
                    child: CircularProgressIndicator(),
                  )
                : ListView.builder(
                    itemCount: controller.tempSearch.length,
                    itemBuilder: (BuildContext context, int index) {
                      TripModel trip = TripModel(
                        chair: "${controller.tempSearch[index]["chair"]}",
                        cityFinish:
                            "${controller.tempSearch[index]["city_finish"]}",
                        cityStart:
                            "${controller.tempSearch[index]["city_start"]}",
                        email: "${controller.tempSearch[index]["email"]}",
                        fullName:
                            "${controller.tempSearch[index]["full_name"]}",
                        idDriver:
                            "${controller.tempSearch[index]["id_driver"]}",
                        idTrip: "${controller.tempSearch[index]["id_trip"]}",
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
                        fullNameC: trip.fullName,
                        startC: trip.cityStart,
                        finishC: trip.cityFinish,
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
