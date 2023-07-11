import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../../../shared/rating_bar.dart';
import '../../../../../theme.dart';

class CardFull extends StatelessWidget {
  final String fullNameC;
  final String dateC;
  final String timeC;
  final String priceC;
  final String photoC;
  final void Function()? onPressed;
  final double latitudeStartC;
  final double longitudeStartC;
  final String localityStartC;
  final String subAdministrativeAreaStartC;
  final String thoroughfareStartC;
  final String subLocalityStartC;

  final double latitudeFinishC;
  final double longitudeFinishC;
  final String localityFinishC;
  final String subAdministrativeAreaFinishC;
  final String thoroughfareFinishC;
  final String subLocalityFinishC;

  const CardFull({
    super.key,
    required this.fullNameC,
    required this.dateC,
    required this.timeC,
    required this.priceC,
    this.onPressed,
    required this.photoC,
    required this.latitudeStartC,
    required this.latitudeFinishC,
    required this.longitudeStartC,
    required this.longitudeFinishC,
    required this.localityStartC,
    required this.localityFinishC,
    required this.subAdministrativeAreaStartC,
    required this.subAdministrativeAreaFinishC,
    required this.thoroughfareStartC,
    required this.thoroughfareFinishC,
    required this.subLocalityStartC,
    required this.subLocalityFinishC,
  });

  @override
  Widget build(BuildContext context) {
    final NumberFormat numberFormat = NumberFormat('#,###');

    return InkWell(
      onTap: onPressed,
      child: Container(
        margin: const EdgeInsets.only(right: 20, left: 20, bottom: 5, top: 10),
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
                          child: photoC == ""
                              ? Image.asset(
                                  "assets/profile.png",
                                  width: 25.0,
                                  height: 25.0,
                                  fit: BoxFit.fill,
                                )
                              : ClipRRect(
                                  borderRadius: BorderRadius.circular(100),
                                  child: Image.network(
                                    photoC,
                                    width: 25.0,
                                    height: 25.0,
                                    fit: BoxFit.fill,
                                  ),
                                ),
                        ),
                        const SizedBox(width: 4),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              fullNameC,
                              style: textBlackDuaStyle.copyWith(
                                fontSize: 9.33,
                                fontWeight: medium,
                              ),
                            ),
                            Container(
                              margin: const EdgeInsets.only(top: 4),
                              height: 8,
                              width: 40,
                              child: const RatingBarView(
                                rating: 0,
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
                                  subAdministrativeAreaStartC,
                                  style: textBlackDuaStyle.copyWith(
                                      fontSize: 9.83, fontWeight: medium),
                                ),
                                Text(
                                  '$dateC  $timeC',
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
                              subAdministrativeAreaFinishC,
                              style: textBlackDuaStyle.copyWith(
                                  fontSize: 9.83, fontWeight: medium),
                            ),
                          ],
                        ),
                      ],
                    ),
                    Container(
                      margin: const EdgeInsets.only(right: 23, top: 11),
                      child: Text(
                        'Harga : Rp.${numberFormat.format(int.parse(priceC))}',
                        style: textBlackDuaStyle.copyWith(
                            fontSize: 9.83, fontWeight: medium),
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
