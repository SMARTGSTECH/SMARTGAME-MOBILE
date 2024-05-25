import 'package:flutter/material.dart';
import 'package:smartbet/utils/config/color.dart';

class resultContainer extends StatelessWidget {
  resultContainer(
      {super.key,
      required this.img,
      required this.height,
      required this.width,
      this.colorImg = false,
      this.color = const Color(0xfffbd604)});

  final String img;
  final colorImg;
  final Color color;
  final double width;
  final double height;

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      Container(
          decoration: BoxDecoration(
            color: Colors.black38,
            borderRadius: BorderRadius.circular(5),
            border: Border.all(
              color: ColorConfig.white.withOpacity(0.4),
            ),
          ),
          height: height,
          width: width,
          margin: EdgeInsets.symmetric(horizontal: 3.0),
          child: (img == "assets/images/pine.png") || colorImg
              ? Image.asset(
                  img,
                  color: color,
                  // width: 100,
                )
              : Image.asset(
                  img,
                  // width: 100,
                )),
      Positioned(
        top: 0,
        right: 0,
        child: Icon(
          Icons.arrow_circle_right,
          size: 18,
        ),
      ),
    ]);
  }
}
