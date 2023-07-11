import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:text_scroll/text_scroll.dart';

import '../../../../shared/rating_bar.dart';
import '../../../../theme.dart';
import '../../../data/models/trip_model.dart';
import '../../../routes/app_pages.dart';
import '../../ordering_map/views/ordering_map_view.dart';
import '../controllers/ordering_controller.dart';

class OrderingView extends StatefulWidget {
  const OrderingView({super.key});

  @override
  State<OrderingView> createState() => _OrderingViewState();
}

class _OrderingViewState extends State<OrderingView> {
  @override
  void initState() {
    super.initState();
    SystemChannels.textInput.invokeMethod('TextInput.hide');
  }

  final TripModel? trip = Get.arguments;
  final NumberFormat numberFormat = NumberFormat('#,###');
  final controller = Get.put(OrderingController());
  Map<String, dynamic> userMap = {};

  // var dataWaitingDriver;
  // var dataDoneDriver;

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      FocusScope.of(context).unfocus();
    });
    if (trip == null) {
      Get.back();
    }

    return Scaffold(
      appBar: AppBar(
        title: trip?.idDriver == controller.auth.currentUser!.uid
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
          // dataWaitingDriver != null
          //     ? IconButton(
          //         onPressed: () {},
          //         icon: const Icon(
          //           Icons.chat,
          //           size: 25.0,
          //         ),
          //       )
          //     : const SizedBox(),
          // dataDoneDriver != null
          //     ? IconButton(
          //         onPressed: () {},
          //         icon: const Icon(
          //           Icons.chat,
          //           size: 25.0,
          //         ),
          //       )
          //     : const SizedBox(),
          trip?.idDriver == controller.auth.currentUser!.uid
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
                            onPressed: () => controller.doDelete(trip!.idTrip),
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
          trip!.idDriver == controller.auth.currentUser!.uid
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
      body: Column(
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
                              child: trip!.photo == ""
                                  ? Image.asset(
                                      "assets/profile.png",
                                      width: 40.51,
                                      height: 40.51,
                                      fit: BoxFit.fill,
                                    )
                                  : ClipRRect(
                                      borderRadius: BorderRadius.circular(100),
                                      child: Image.network(
                                        trip!.photo,
                                        width: 40.51,
                                        height: 40.51,
                                        fit: BoxFit.fill,
                                      ),
                                    ),
                            ),
                            const SizedBox(width: 4),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  trip!.fullName,
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
                        SizedBox(
                          width: Get.width / 2,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Icon(Icons.location_on_outlined,
                                      color: grayTigaColor),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        TextScroll(
                                          trip!.subAdministrativeAreaStart,
                                          mode: TextScrollMode.endless,
                                          velocity: const Velocity(
                                              pixelsPerSecond: Offset(50, 0)),
                                          style: textBlackDuaStyle.copyWith(
                                              fontSize: 16, fontWeight: medium),
                                        ),
                                        Text(
                                          '${trip!.tripDate}  ${trip!.tripTime}',
                                          style: textGrayStyle.copyWith(
                                              fontSize: 10, fontWeight: medium),
                                        ),
                                      ],
                                    ),
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
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        TextScroll(
                                          trip!.subAdministrativeAreaFinish,
                                          mode: TextScrollMode.endless,
                                          velocity: const Velocity(
                                              pixelsPerSecond: Offset(50, 0)),
                                          style: textBlackDuaStyle.copyWith(
                                              fontSize: 16, fontWeight: medium),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Harga : Rp.${numberFormat.format(int.parse(trip!.tripPrice))}',
                              style: textBlackDuaStyle.copyWith(
                                  fontSize: 15, fontWeight: medium),
                            ),
                            const SizedBox(height: 20),
                            ElevatedButton(
                              onPressed: () {
                                Get.to(() => OrderingMapView(
                                      latitudeStart: trip!.latitudeStart,
                                      latitudeFinish: trip!.latitudeFinish,
                                      longitudeStart: trip!.longitudeStart,
                                      longitudeFinish: trip!.longitudeFinish,
                                      localityStart: trip!.localityStart,
                                      localityFinish: trip!.localityFinish,
                                      subAdministrativeAreaStart:
                                          trip!.subAdministrativeAreaStart,
                                      subAdministrativeAreaFinish:
                                          trip!.subAdministrativeAreaFinish,
                                      thoroughfareStart:
                                          trip!.thoroughfareStart,
                                      thoroughfareFinish:
                                          trip!.thoroughfareFinish,
                                      subLocalityStart: trip!.subLocalityStart,
                                      subLocalityFinish:
                                          trip!.subLocalityFinish,
                                    ));
                              },
                              style: ElevatedButton.styleFrom(
                                minimumSize: const Size(137, 35),
                                padding: const EdgeInsets.all(10),
                              ),
                              child: Text(
                                'Cek Peta',
                                style:
                                    textWhiteStyle.copyWith(fontWeight: bold),
                              ),
                            ),
                          ],
                        ),
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
                          trip!.merekKendaraan,
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
                      "${trip!.chair} Kursi",
                      style: textBlackDuaStyle.copyWith(
                          fontSize: 15, fontWeight: medium),
                    ),
                  ],
                ),
                const SizedBox(height: 22),
                StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
                  stream: controller.streamPenumpang(trip!.idTrip),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Row(
                        children: [
                          Image.asset(
                            "assets/user2.png",
                            width: 24,
                            height: 24,
                          ),
                          const SizedBox(width: 6),
                          Text(
                            "0 Penumpang",
                            style: textBlackDuaStyle.copyWith(
                                fontSize: 15, fontWeight: medium),
                          ),
                        ],
                      );
                    }

                    final data2 = snapshot.data!;

                    return Row(
                      children: [
                        Image.asset(
                          "assets/user2.png",
                          width: 24,
                          height: 24,
                        ),
                        const SizedBox(width: 6),
                        Text(
                          data2.docs.isEmpty
                              ? "0 Penumpang"
                              : "${data2.docs.length} Penumpang",
                          style: textBlackDuaStyle.copyWith(
                              fontSize: 15, fontWeight: medium),
                        ),
                      ],
                    );
                  },
                ),
              ],
            ),
          ),
          Container(
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(color: black, width: 1),
              ),
            ),
          ),
          trip!.idDriver != controller.auth.currentUser!.uid
              ? const SizedBox()
              : Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 23, vertical: 10),
                  child: Text(
                    'Permintaan',
                    style: textBlackDuaStyle.copyWith(
                      fontSize: 16,
                      fontWeight: medium,
                    ),
                  ),
                ),
          Expanded(
            child: trip!.idDriver == controller.auth.currentUser!.uid
                ? Container(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
                      stream: controller.streamtrip(trip!.idTrip),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        }

                        if (snapshot.data!.docs.isEmpty) {
                          return const Center(
                            child: Text("Tidak Ada Data"),
                          );
                        }
                        final data = snapshot.data!;

                        return ListView.builder(
                          itemCount: snapshot.data!.docs.length,
                          itemBuilder: (context, index) {
                            Map<String, dynamic> item = data.docs[index].data();
                            return Container(
                              height: 65,
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 20, vertical: 5),
                              width: double.infinity,
                              // color: primaryColor,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      ClipRRect(
                                        borderRadius:
                                            BorderRadius.circular(100),
                                        child: item["photo"] == ""
                                            ? Image.asset(
                                                "assets/profile.png",
                                                width: 40.51,
                                                height: 40.51,
                                                fit: BoxFit.cover,
                                              )
                                            : Image.network(
                                                item["photo"] ?? "",
                                                width: 40.51,
                                                height: 40.51,
                                                fit: BoxFit.cover,
                                              ),
                                      ),
                                      const SizedBox(width: 10),
                                      Text(
                                        "${item["full_name"]}",
                                        style: textBlackDuaStyle.copyWith(
                                          fontSize: 15,
                                          fontWeight: regular,
                                        ),
                                        maxLines: 1,
                                      ),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      GestureDetector(
                                        onTap: () {
                                          controller.addNewRide(
                                            item,
                                            trip!.idTrip,
                                            item["id_user"],
                                            trip,
                                          );
                                        },
                                        child: Image.asset(
                                          "assets/centant.png",
                                          width: 30.0,
                                          height: 30.0,
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                      const SizedBox(width: 20),
                                      GestureDetector(
                                        onTap: () {
                                          controller.deleteTrip(
                                            trip!.idTrip,
                                            item["id_user"],
                                            trip,
                                            item,
                                          );
                                        },
                                        child: Image.asset(
                                          "assets/cancel.png",
                                          width: 30.0,
                                          height: 30.0,
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            );
                          },
                        );
                      },
                    ),
                  )
                : Container(),
          ),
          StreamBuilder<DocumentSnapshot<Map<String, dynamic>>>(
            stream: FirebaseFirestore.instance
                .collection('trip')
                .doc(trip!.idTrip)
                .snapshots(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }

              if (!snapshot.hasData) {
                return const Text(
                  'Data tidak ada',
                  style: TextStyle(
                    color: Colors.red,
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                );
              }

              final data = snapshot.data!.data();
              // dataWaitingDriver = data!['request_field']
              //     .contains(controller.auth.currentUser!.uid);
              // dataDoneDriver =
              //     data['rides'].contains(controller.auth.currentUser!.uid);

              return SizedBox(
                width: double.infinity,
                height: 42,
                child: ElevatedButton(
                  onPressed: () async {
                    // var userMap;
                    await controller.firestore
                        .collection('users')
                        .where(
                          "full_name",
                          isEqualTo: trip!.fullName,
                        )
                        .get()
                        .then((value) {
                      if (value.docs.isNotEmpty) {
                        userMap = value.docs[0].data();
                        // Lanjutkan dengan kode lainnya
                        setState(() {});
                      } else {
                        // Handle ketika list kosong
                      }
                    });
                    if (controller.isLoading.isFalse) {
                      controller.isLoading(true);
                      if (data['id_driver'] ==
                          controller.auth.currentUser!.uid) {
                        if (data['trip_status'] == "Menunggu") {
                          controller.doUpdateSatu(trip!.idTrip);
                        } else if (data['trip_status'] == "Dalam Perjalanan") {
                          controller.doUpdateDua(trip!.idTrip);
                        }
                        Future.delayed(const Duration(seconds: 3), () {
                          controller.isLoading.value = false;
                        });
                        setState(() {
                          data['trip_status'];
                        });
                      } else {
                        if (trip!.rides
                                .contains(controller.auth.currentUser!.uid) ==
                            true) {
                          if (data['trip_status'] == "Selesai") {
                          } else {
                            controller.deleteRides(trip!.idTrip);
                          }
                        } else {
                          if (trip!.requestField
                                  .contains(controller.auth.currentUser!.uid) ==
                              true) {
                          } else {
                            setState(() {
                              controller.addNewConnection(
                                  trip, userMap, trip!.idTrip);
                            });
                          }
                        }
                      }
                      controller.isLoading(false);
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: data!['trip_status'] == "Selesai"
                        ? grayColor
                        : data['request_field']
                                .contains(controller.auth.currentUser!.uid)
                            ? grayColor
                            : primaryColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5),
                    ),
                  ),
                  child: Obx(
                    () => Text(
                      controller.isLoading.isFalse
                          ? data['id_driver'] ==
                                  controller.auth.currentUser!.uid
                              ? data['trip_status'] == "Menunggu"
                                  ? "Mulai Perjalanan"
                                  : data['trip_status'] == "Dalam Perjalanan"
                                      ? "Akhiri Perjalanan"
                                      : "Selesai"
                              : data['request_field'].contains(
                                      controller.auth.currentUser!.uid)
                                  ? "Menunggu Persetujuan driver"
                                  : data['rides'].contains(
                                          controller.auth.currentUser!.uid)
                                      ? data['trip_status'] == "Selesai"
                                          ? "Selesai"
                                          : "Batal"
                                      : "Pesan"
                          : "Memuat..",
                      style: textWhiteStyle.copyWith(
                        fontSize: 14,
                        fontWeight: semiBold,
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
