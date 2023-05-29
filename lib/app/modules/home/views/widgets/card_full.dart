import 'package:flutter/material.dart';

import '../../../../../shared/rating_bar.dart';
import '../../../../../theme.dart';

class CardFull extends StatelessWidget {
  const CardFull({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
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
    );
  }
}
