import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:smartbet/utils/config/color.dart';
import 'package:smartbet/utils/constants.dart';

class conInput extends StatelessWidget {
  const conInput(
      {super.key,
      this.ht,
      this.wt,
      this.predition,
      this.img,
      this.colorImg = false,
      this.color});
  final double? ht;
  final double? wt;
  final String? predition;
  final String? img;
  final bool? colorImg;
  final Color? color;
  @override
  Widget build(BuildContext context) {
    predictionContoller.text = predition!;
    print("this is for production : $predition");
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 7.w),
      child: Container(
        height: 45.h,
        width: SizeConfig.screenWidth! <= 450 ? 300.w : 400,
        decoration: BoxDecoration(
          color: Color.fromARGB(255, 19, 27, 93).withOpacity(0.4),
          borderRadius: BorderRadius.circular(12.r),
        ),
        child: Row(children: [
          9.width,
          Icon(
            Icons.gamepad_sharp,
            color: ColorConfig.iconColor,
          ),
          9.width,
          Text(
            'Predicted: $predition' ?? 'Predicted: 3',
            style: TextStyle(
              //  fontFamily: AppFont.euclidCircularARegular,
              fontSize: 14.sp,
              color: const Color(0xFF9FA4BC),
            ),
          ),
          0.width.expand(),
          !colorImg!
              ? Image.asset(
                  img ?? "assets/images/d2.png",
                  //   color: imgcolor,
                  width: 45,
                  height: 45,
                )
              : Image.asset(
                  img ?? "assets/images/d2.png",
                  color: color ?? Colors.teal,
                  width: 45,
                  height: 45,
                ),
          6.width,
        ]),
      ),
    );
  }
}
