import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../shared/rating_bar.dart';
import '../../../../theme.dart';
import '../controllers/order_detail_controller.dart';

class OrderDetailView extends GetView<OrderDetailController> {
  const OrderDetailView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Deskripsi Pemesanan'),
        centerTitle: true,
        leading: IconButton(
          onPressed: () => Get.back(),
          icon: const Icon(
            Icons.arrow_back_ios,
            color: white,
          ),
        ),
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
                              child: Image.asset(
                                "assets/profile.png",
                                width: 40.51,
                                height: 40.51,
                                fit: BoxFit.fill,
                              ),
                            ),
                            const SizedBox(width: 4),
                            Column(
                              children: [
                                Text(
                                  "Irwansyah",
                                  style: textBlackDuaStyle.copyWith(
                                    fontSize: 16,
                                    fontWeight: medium,
                                  ),
                                ),
                                Container(
                                  margin: const EdgeInsets.only(top: 6.92),
                                  height: 12.96,
                                  width: 64.81,
                                  child: const RatingBar(
                                    rating: 4.5,
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
                  const SizedBox(height: 34),
                  Text(
                    'Beri Penilaian ke Driver?',
                    style: textBlackDuaStyle.copyWith(
                      fontSize: 15,
                      fontWeight: semiBold,
                    ),
                  ),
                  const SizedBox(height: 9),
                  const RatingBar(rating: 3.5, size: 30),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 23, vertical: 21),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(Icons.location_on_outlined, color: grayTigaColor),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Makassar',
                              style: textBlackDuaStyle.copyWith(
                                  fontSize: 16, fontWeight: medium),
                            ),
                            Text(
                              '13 Januari  03:00 PM',
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
                        Icon(Icons.location_on_outlined, color: grayTigaColor),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Makassar',
                              style: textBlackDuaStyle.copyWith(
                                  fontSize: 16, fontWeight: medium),
                            ),
                            Text(
                              '13 Januari  03:00 PM',
                              style: textGrayStyle.copyWith(
                                  fontSize: 10, fontWeight: medium),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 55),
                Row(
                  children: [
                    Text(
                      'Biaya Perjalanan',
                      style: textBlackDuaStyle.copyWith(
                        fontSize: 13,
                        fontWeight: regular,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 15),
                Row(
                  children: [
                    Text(
                      'Biaya Jasa Aplikasi',
                      style: textBlackDuaStyle.copyWith(
                        fontSize: 13,
                        fontWeight: regular,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 15),
                Row(
                  children: [
                    Text(
                      'Total',
                      style: textBlackDuaStyle.copyWith(
                        fontSize: 13,
                        fontWeight: semiBold,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
