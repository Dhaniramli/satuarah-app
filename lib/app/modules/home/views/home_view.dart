// ignore_for_file: unnecessary_null_comparison

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../theme.dart';
import '../../../data/models/trip_model.dart';
import '../../../data/models/user_model.dart';
import '../../../routes/app_pages.dart';
import '../../leaving_today/views/leaving_today_view.dart';
import '../../loading/loading_view.dart';
import '../../popular_route/views/popular_route_view.dart';
import '../../register_driver/views/register_driver_view.dart';
import '../../search_ride/views/search_ride_view.dart';
import '../controllers/home_controller.dart';
import 'widgets/button_box.dart';
import 'widgets/card_full.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(HomeController());

    return Scaffold(
      body: SafeArea(
        child: StreamBuilder<DocumentSnapshot<Object?>>(
          stream: controller.userCollection.snapshots(),
          builder: (context, snapshot) {
            if (snapshot.hasError) return const Text("Error");
            if (!snapshot.hasData) return const LoadingView();
            if (snapshot.data!.data != null) {
              Map<String, dynamic>? data =
                  (snapshot.data!.data() as Map<String, dynamic>?);
              data!["id"] = snapshot.data!.id;

              UserModel user = UserModel(
                email: data["email"] ?? "",
                fullName: data["full_name"] ?? "",
                idUser: data["id_user"] ?? "",
                merekKendaraan: data["merek_kendaraan"] ?? "",
                nomorKtp: data["nomor_ktp"] ?? "",
                nomorPlat: data["nomor_plat"] ?? "",
                nomorSim: data["nomor_sim"] ?? "",
                phoneNumber: data["phone_number"] ?? "",
                userAs: data["user_as"] ?? "",
                photo: data["photo"] ?? "",
              );

              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20.0, vertical: 16.0),
                    height: 160.0,
                    width: MediaQuery.of(context).size.width,
                    color: primaryColor,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Selamat Datang",
                          style: textWhiteStyle.copyWith(
                            fontSize: 12.0,
                            fontWeight: regular,
                          ),
                        ),
                        const SizedBox(height: 3.15),
                        Text(
                          user.fullName,
                          style: textWhiteStyle.copyWith(
                            fontSize: 19.76,
                            fontWeight: bold,
                          ),
                        ),
                        const SizedBox(height: 42.85),
                        GestureDetector(
                          onTap: () => Get.to(() => const SearchRideView()),
                          child: Container(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 13.0),
                            height: 26.0,
                            width: MediaQuery.of(context).size.width,
                            decoration: BoxDecoration(
                              color: white,
                              borderRadius: BorderRadius.circular(5),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Image.asset(
                                  'assets/lokasi.png',
                                  width: 10.0,
                                  height: 17.21,
                                ),
                                const SizedBox(width: 8.0),
                                Expanded(
                                  child: Text(
                                    "Cari Tujuan Anda",
                                    style: textGrayStyle.copyWith(
                                        fontSize: 12, fontWeight: regular),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    height: 170.0,
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                      border: BorderDirectional(
                        bottom: BorderSide(
                          color: black,
                          width: 1.0,
                          style: BorderStyle.solid,
                        ),
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        ButtonBox(
                          icon: "assets/rutepopuler.png",
                          tittLe: "Rute Populer",
                          onTap: () {
                            Get.to(() => const PopularRouteView());
                          },
                        ),
                        ButtonBox(
                          icon: "assets/bhi.png",
                          tittLe: "Semua Tebengan",
                          onTap: () => Get.to(() => const LeavingTodayView()),
                        ),
                        ButtonBox(
                          icon: "assets/carit.png",
                          tittLe: "Buat Tebengan",
                          onTap: () {
                            if (user.userAs == "driver") {
                              Get.toNamed(Routes.MAKE_A_TRIP, arguments: user);
                            } else {
                              Get.snackbar(
                                "Anda Belum Terdaftar Sebagai Driver",
                                "Silahkan lakukan pendaftaran terlebih dahulu",
                                duration: const Duration(seconds: 2),
                                snackStyle: SnackStyle.FLOATING,
                                backgroundColor: white,
                                colorText: primaryColor,
                                borderRadius: 10,
                              );
                              Get.to(() => const RegisterDriverView());
                            }
                          },
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 4),
                  Container(
                    margin: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 14),
                    child: Text(
                      "Berangkat hari ini",
                      style: textBigBlackStyle.copyWith(
                        fontSize: 15,
                        fontWeight: semiBold,
                      ),
                    ),
                  ),
                  Expanded(
                    child: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
                      stream: controller.streamtrip(),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
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
                                  style: textGrayStyle.copyWith(
                                      fontWeight: semiBold),
                                ),
                                Text(
                                  "berangkat hari ini",
                                  style: textGrayStyle.copyWith(
                                      fontWeight: semiBold),
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
                  )
                ],
              );
            }
            return const LoadingView();
          },
        ),
      ),
    );
  }
}
