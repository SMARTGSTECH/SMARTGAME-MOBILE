import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:shimmer/shimmer.dart';
import 'package:smartbet/utils/config/color.dart';

class ExpandedWidget extends StatelessWidget {
  const ExpandedWidget(
      {super.key,
      required this.img,
      required this.text,
      required this.onTapFuntion});

  final String img;
  final String text;
  final VoidCallback onTapFuntion;

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.bottomCenter,
      children: [
        img.contains("http")
            ? Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.r),
                  border: Border.all(
                    color: ColorConfig.white,
                    width: 2,
                  ),
                ),
                child: Image.network(img),
              )
            : Container(
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [Colors.red, Colors.orange],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  ),
                  borderRadius: BorderRadius.circular(10.r),
                  border: Border.all(
                    color: ColorConfig.white,
                    width: 2,
                  ),
                  image: DecorationImage(
                      //opacity: 0.5,
                      fit: BoxFit.fill,
                      image: AssetImage(img)),
                ),
              ),
        Container(
          height: 65.h,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.r),
            border: const Border(
              left: BorderSide(
                color:
                    Colors.white, // Assuming ColorConfig.white is Colors.white
                //  width: 1,
              ),
              bottom: BorderSide(
                color:
                    Colors.white, // Assuming ColorConfig.white is Colors.white
                // width: 1,
              ),
            ),
            gradient: const LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Color.fromARGB(0, 110, 109, 109),
                Colors.black, // Transparent color at the top
                // Solid color at the bottom
              ],
            ),
          ),
          //  color: Colors.black.withOpacity(0.4),
        ),
        Shimmer.fromColors(
          baseColor: Colors.grey,
          highlightColor: Colors.white,
          period: Duration(milliseconds: 1500),
          child: Text(
            text,
            style: TextStyle(
                fontSize: 15.sp,
                // color: ColorConfig.iconColor,
                fontWeight: FontWeight.bold),
          ).paddingBottom(6.h).paddingLeft(1.w),
        )
      ],
    ).onTap(onTapFuntion);
  }
}
