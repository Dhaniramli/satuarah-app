import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../theme.dart';

// ignore: must_be_immutable
class ButtonBox extends StatelessWidget {
  String icon;
  String tittLe;
  final Widget onTap;

  ButtonBox(
      {super.key,
      required this.icon,
      required this.tittLe,
      required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // Navigator.pushReplacement(
        //     context, MaterialPageRoute(builder: ((context) => onTap)));
        Get.to(onTap);
      },
      child: SizedBox(
        width: 74,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 3.15,
                    blurRadius: 3.15,
                    offset: const Offset(3, 3),
                  ),
                ],
              ),
              child: Image.asset(
                // 'assets/rutepopuler.png',
                icon,
                width: 74,
                height: 74,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              // "Rute Populer",
              tittLe,
              textAlign: alignCenter,
              style: textBlackDuaStyle.copyWith(
                fontSize: 13.6,
                fontWeight: medium,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
