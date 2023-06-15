import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../../shared/rating_bar.dart';
import '../../../../theme.dart';
import '../../../data/models/trip_model.dart';
import '../../../routes/app_pages.dart';
import '../controllers/ordering_controller.dart';

class OrderingView extends StatefulWidget {
  const OrderingView({super.key});

  @override
  State<OrderingView> createState() => _OrderingViewState();
}

class _OrderingViewState extends State<OrderingView> {
  @override
  Widget build(BuildContext context) {
    final TripModel trip = Get.arguments;
    final NumberFormat numberFormat = NumberFormat('#,###');
    final controller = Get.put(OrderingController());
    return Scaffold(
      appBar: AppBar(
        title: trip.idDriver == controller.auth.currentUser!.uid
            ? const Text('Detail')
            : const Text('Pesan'),
        centerTitle: true,
        leading: IconButton(
          onPressed: () => Get.back(),
          icon: const Icon(
            Icons.arrow_back_ios,
            color: white,
          ),
        ),
        actions: [
          trip.idDriver == controller.auth.currentUser!.uid
              ? IconButton(
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                        title: const Text('Konfirmasi'),
                        content: const Text(
                            'Apakah Anda yakin ingin menghapus ini?'),
                        actions: <Widget>[
                          TextButton(
                            onPressed: () => Get.back(),
                            child: const Text('Tidak'),
                          ),
                          TextButton(
                            onPressed: () => controller.doDelete(trip.idTrip),
                            child: const Text('Ya'),
                          ),
                        ],
                      ),
                    );
                  },
                  icon: const Icon(
                    Icons.delete,
                    size: 25.0,
                  ),
                )
              : const SizedBox(),
          const SizedBox(width: 10),
          trip.idDriver == controller.auth.currentUser!.uid
              ? IconButton(
                  onPressed: () {
                    Get.toNamed(Routes.EDIT_A_TRIP, arguments: trip);
                  },
                  icon: const Icon(
                    Icons.edit,
                    size: 25.0,
                  ),
                )
              : const SizedBox(),
        ],
      ),
      body: SingleChildScrollView(
        controller: ScrollController(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(color: black, width: 2),
                ),
              ),
              child: SizedBox(
                height: 180,
                width: double.infinity,
                child: Column(
                  children: [
                    Row(
                      children: [
                        SizedBox(
                          height: 40.51,
                          child: Row(
                            children: [
                              Container(
                                height: 40.51,
                                width: 40.51,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(50)),
                                child: Image.asset(
                                  "assets/profile.png",
                                  width: 40.51,
                                  height: 40.51,
                                  fit: BoxFit.fill,
                                ),
                              ),
                              const SizedBox(width: 4),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    trip.fullName,
                                    style: textBlackDuaStyle.copyWith(
                                      fontSize: 16,
                                      fontWeight: medium,
                                    ),
                                  ),
                                  Container(
                                    margin: const EdgeInsets.only(top: 6.92),
                                    height: 12.96,
                                    width: 64.81,
                                    child: const RatingBarView(
                                      rating: 0,
                                      ratingCount: 12,
                                      size: 12.96,
                                    ),
                                  )
                                ],
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                    Container(
                      margin: const EdgeInsets.only(top: 22.49),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Icon(Icons.location_on_outlined,
                                      color: grayTigaColor),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        trip.cityStart,
                                        style: textBlackDuaStyle.copyWith(
                                            fontSize: 16, fontWeight: medium),
                                      ),
                                      Text(
                                        '${trip.tripDate}  ${trip.tripTime}',
                                        style: textGrayStyle.copyWith(
                                            fontSize: 10, fontWeight: medium),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              Container(
                                width: 1,
                                height: 20,
                                color: grayTigaColor,
                                margin: const EdgeInsets.only(
                                    left: 11, top: 3.79, bottom: 3.79),
                              ),
                              Row(
                                children: [
                                  Icon(Icons.location_on_outlined,
                                      color: grayTigaColor),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        trip.cityFinish,
                                        style: textBlackDuaStyle.copyWith(
                                            fontSize: 16, fontWeight: medium),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ],
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Harga : Rp.${numberFormat.format(int.parse(trip.tripPrice))}',
                                style: textBlackDuaStyle.copyWith(
                                    fontSize: 15, fontWeight: medium),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 23, vertical: 21),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Deskripsi',
                    style: textBlackDuaStyle.copyWith(
                      fontSize: 16,
                      fontWeight: medium,
                    ),
                  ),
                  const SizedBox(height: 15),
                  Row(
                    children: [
                      Image.asset(
                        "assets/bus.png",
                        width: 24,
                        height: 24,
                      ),
                      const SizedBox(width: 6),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            trip.merekKendaraan,
                            style: textBlackDuaStyle.copyWith(
                                fontSize: 15, fontWeight: medium),
                          ),
                        ],
                      )
                    ],
                  ),
                  const SizedBox(height: 22),
                  Row(
                    children: [
                      Image.asset(
                        "assets/user.png",
                        width: 24,
                        height: 24,
                      ),
                      const SizedBox(width: 6),
                      Text(
                        "${trip.chair} Kursi",
                        style: textBlackDuaStyle.copyWith(
                            fontSize: 15, fontWeight: medium),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 203),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  margin: const EdgeInsets.only(top: 38),
                  width: 145,
                  height: 42,
                  child: ElevatedButton(
                    onPressed: () {
                      if (controller.isLoading.isFalse) {
                        controller.isLoading(true);
                        if (trip.idDriver == controller.auth.currentUser!.uid) {
                          if (trip.tripStatus == "Menunggu") {
                            controller.doUpdateSatu(trip.idTrip);
                          } else if (trip.tripStatus == "Dalam Perjalanan") {
                            controller.doUpdateDua(trip.idTrip);
                          }
                          Future.delayed(const Duration(seconds: 3), () {
                            controller.isLoading.value = false;
                          });
                          setState(() {
                            trip.tripStatus;
                          });
                        } else {
                          controller.addNewConnection(trip);
                        }
                        controller.isLoading(false);
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: trip.tripStatus == "Selesai"
                          ? grayColor
                          : primaryColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5),
                      ),
                    ),
                    child: Obx(
                      () => Text(
                        controller.isLoading.isFalse
                            ? trip.idDriver == controller.auth.currentUser!.uid
                                ? trip.tripStatus == "Menunggu"
                                    ? "Mulai Perjalanan"
                                    : trip.tripStatus == "Dalam Perjalanan"
                                        ? "Akhiri Perjalanan"
                                        : "Selesai"
                                : "Pesan"
                            : "Memuat..",
                        style: textWhiteStyle.copyWith(
                          fontSize: 14,
                          fontWeight: semiBold,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
