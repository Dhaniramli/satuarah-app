import 'package:flutter/material.dart';

class RatingBar extends StatelessWidget {
  final double rating;
  final double size;
  final int? ratingCount;

  const RatingBar({
    super.key,
    required this.rating,
    required this.size,
    this.ratingCount,
  });

  @override
  Widget build(BuildContext context) {
    List<Widget> _starList = [];

    int realNumber = rating.floor(); //3.55->3
    int partNumber = ((rating - realNumber) * 10).ceil(); //6

    for (int i = 0; i < 5; i++) {
      if (i < realNumber) {
        _starList.add(Icon(Icons.star,
            color: Theme.of(context).primaryColor, size: size));
      } else if (i == realNumber) {
        _starList.add(
          SizedBox(
            height: size,
            width: size,
            child: Stack(
              fit: StackFit.expand,
              children: [
                Icon(
                  Icons.star,
                  color: Theme.of(context).primaryColor,
                  size: size,
                ),
                ClipRect(
                  clipper: _Clipper(part: partNumber),
                  child: Icon(
                    Icons.star,
                    color: Colors.grey,
                    size: size,
                  ),
                )
              ],
            ),
          ),
        );
      } else {
        _starList.add(
          Icon(
            Icons.star,
            color: Colors.grey,
            size: size,
          ),
        );
      }
    }

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: _starList,
    );
  }
}

// 3.5=>5
class _Clipper extends CustomClipper<Rect> {
  final int part;
  _Clipper({required this.part});

  @override
  Rect getClip(Size size) {
    return Rect.fromLTRB(
      size.width / 10 * part,
      0.0,
      size.width,
      size.height,
    );
  }

  @override
  bool shouldReclip(covariant CustomClipper<Rect> oldClipper) => true;
}
