import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../../../theme.dart';
import '../../find_ride/views/find_ride_view.dart';
import '../../leaving_today/views/leaving_today_view.dart';
import '../../popular_route/views/popular_route_view.dart';
import '../controllers/home_controller.dart';
import 'widgets/button_box.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Column(
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
                    onTap: LeavingTodayView(),
                  ),
                  ButtonBox(
                    icon: "assets/carit.png",
                    tittLe: "Cari Tebengan",
                    onTap: FindRideView(),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
