import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:text_scroll/text_scroll.dart';

import '../../../../theme.dart';
import '../../cek/views/cek_view.dart';
import '../controllers/popular_route_controller.dart';

class PopularRouteView extends GetView<PopularRouteController> {
  const PopularRouteView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(PopularRouteController());

    return Scaffold(
      appBar: AppBar(
        title: const Text('Rute Populer'),
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

          return ListView.builder(
            itemCount: snapshot.data!.docs.length,
            itemBuilder: (context, index) {
              return Container(
                margin: const EdgeInsets.only(right: 20, left: 20, top: 34),
                decoration: BoxDecoration(
                    border: Border.all(color: grayDuaColor, width: 3),
                    borderRadius: BorderRadius.circular(5)),
                child: InkWell(
                  onTap: () {
                    Get.to(() => CekView(
                          snapshot.data!.docs[index]["city_start"],
                          snapshot.data!.docs[index]["city_finish"],
                        ));
                  },
                  child: SizedBox(
                    height: 98,
                    width: double.infinity,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Center(
                          child: TextScroll(
                            '${snapshot.data!.docs[index]["city_start"]} - ${snapshot.data!.docs[index]["city_finish"]}',
                            mode: TextScrollMode.endless,
                            velocity:
                                const Velocity(pixelsPerSecond: Offset(50, 0)),
                            style: textBlackDuaStyle.copyWith(
                              fontSize: 13,
                              fontWeight: semiBold,
                            ),
                          ),
                        ),
                        Center(
                          child: SizedBox(
                            width: 145,
                            height: 29,
                            child: ElevatedButton(
                              onPressed: () {
                                Get.to(() => CekView(
                                      snapshot.data!.docs[index]["city_start"],
                                      snapshot.data!.docs[index]["city_finish"],
                                    ));
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: primaryColor,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(5),
                                ),
                              ),
                              child: Text(
                                "Cek",
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
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
