import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../../../shared/rating_bar.dart';
import '../../../../theme.dart';
import '../../find_ride/views/find_ride_view.dart';
import '../../leaving_today/views/leaving_today_view.dart';
import '../../popular_route/views/popular_route_view.dart';
import '../controllers/home_controller.dart';
import 'widgets/button_box.dart';

class HomeView extends GetView<HomeController> {
  HomeView({Key? key}) : super(key: key);

  final List<Widget> closets = List.generate(
    20,
    (index) => Container(
      margin: const EdgeInsets.only(right: 20, left: 20, bottom: 30),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
          border: Border.all(color: grayDuaColor, width: 3),
          borderRadius: BorderRadius.circular(5)),
      child: SizedBox(
        height: 160,
        width: double.infinity,
        child: Column(
          children: [
            Row(
              children: [
                SizedBox(
                  height: 25,
                  child: Row(
                    children: [
                      Container(
                        height: 25.0,
                        width: 25.0,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(50)),
                        child: Image.asset(
                          "assets/profile.png",
                          width: 25.0,
                          height: 25.0,
                          fit: BoxFit.fill,
                        ),
                      ),
                      const SizedBox(width: 4),
                      Column(
                        children: [
                          Text(
                            "Irwansyah",
                            style: textBlackDuaStyle.copyWith(
                              fontSize: 9.33,
                              fontWeight: medium,
                            ),
                          ),
                          Container(
                            margin: const EdgeInsets.only(top: 4),
                            height: 8,
                            width: 40,
                            child: const RatingBar(
                              rating: 4.5,
                              ratingCount: 12,
                              size: 8,
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
              margin: const EdgeInsets.only(top: 8),
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
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Makassar',
                                style: textBlackDuaStyle.copyWith(
                                    fontSize: 9.83, fontWeight: medium),
                              ),
                              Text(
                                '13 Januari  03:00 PM',
                                style: textGrayStyle.copyWith(
                                    fontSize: 6.13, fontWeight: medium),
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
                          Text(
                            'Takalar',
                            style: textBlackDuaStyle.copyWith(
                                fontSize: 9.83, fontWeight: medium),
                          ),
                        ],
                      ),
                    ],
                  ),
                  Container(
                    margin: const EdgeInsets.only(right: 82, top: 11),
                    child: Text(
                      'Harga : Rp.100.000',
                      style: textBlackDuaStyle.copyWith(
                          fontSize: 9.83, fontWeight: medium),
                    ),
                  )
                ],
              ),
            ),
            const SizedBox(height: 9),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  width: 145,
                  height: 29,
                  child: ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: primaryColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5),
                      ),
                    ),
                    child: Text(
                      "Pesan",
                      style: textWhiteStyle.copyWith(
                        fontSize: 14,
                        fontWeight: semiBold,
                      ),
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    ),
  ).reversed.toList();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding:
                  const EdgeInsets.symmetric(horizontal: 20.0, vertical: 16.0),
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
                    "Motive",
                    style: textWhiteStyle.copyWith(
                      fontSize: 19.76,
                      fontWeight: bold,
                    ),
                  ),
                  const SizedBox(height: 42.85),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 13.0),
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
                          child: TextField(
                            onSubmitted: (_) {},
                            style: textGrayStyle.copyWith(
                                fontSize: 12, fontWeight: regular),
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: 'Cari tujuan anda',
                              hintStyle: textGrayStyle.copyWith(
                                  fontSize: 12, fontWeight: regular),
                            ),
                          ),
                        ),
                      ],
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
                    onTap: PopularRouteView(),
                  ),
                  ButtonBox(
                    icon: "assets/bhi.png",
                    tittLe: "Berangkat ini hari",
                    onTap: const LeavingTodayView(),
                  ),
                  ButtonBox(
                    icon: "assets/carit.png",
                    tittLe: "Cari Tebengan",
                    onTap: const FindRideView(),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 4),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
              child: Text(
                "Terdekat dari Anda",
                style: textBigBlackStyle.copyWith(
                  fontSize: 15,
                  fontWeight: semiBold,
                ),
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: closets.length,
                itemBuilder: (context, index) => closets[index],
              ),
            )
          ],
        ),
      ),
    );
  }
}
