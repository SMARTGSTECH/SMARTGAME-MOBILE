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
      required this.onTapFuntion,
      this.symbol = '',
      required this.count});

  final String img;
  final String text;
  final String symbol;
  final String count;
  final VoidCallback onTapFuntion;

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.bottomCenter,
      children: [
        img.contains("http")
            ? Container(
                height: double.infinity,
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [
                      Color.fromARGB(0, 70, 59, 59),
                      Colors.black,
                    ],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  ),
                  borderRadius: BorderRadius.circular(10.r),
                  border: Border.all(
                    color: ColorConfig.white,
                    width: 1,
                  ),
                ),
                child: Stack(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(50.0),
                      child: Image.network(
                        img,
                      ).cornerRadiusWithClipRRect(50),
                    ),
                    Row(
                      children: [
                        Container(
                          color: Colors.transparent,
                          height: 25.h,
                          width: 163.w,
                          child: Row(
                            children: [
                              symbol != ''
                                  ? Container(
                                      decoration: BoxDecoration(
                                        color: ColorConfig.appBar,
                                        borderRadius: BorderRadius.only(
                                            topLeft: radiusCircular(10.r),
                                            topRight: radiusCircular(10.r),
                                            bottomRight: radiusCircular(10.r)),
                                      ),
                                      height: 30.h,
                                      width: 50.w,
                                      child: Text(
                                        symbol,
                                        style: TextStyle(
                                          fontSize: 15.sp,
                                          // color: ColorConfig.iconColor,
                                        ),
                                      ).center(),
                                    )
                                  : Container(),
                              Container().expand(),
                              Container(
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(
                                      Icons.person,
                                      color: ColorConfig.iconColor,
                                    ),
                                    Text(
                                      count ?? "03",
                                      style: TextStyle(
                                        fontSize: 15.sp,
                                        // color: ColorConfig.iconColor,
                                      ),
                                    ).center(),
                                  ],
                                ),
                                decoration: BoxDecoration(
                                  color: ColorConfig.appBar,
                                  borderRadius: BorderRadius.only(
                                      topLeft: radiusCircular(10.r),
                                      topRight: radiusCircular(10.r),
                                      bottomLeft: radiusCircular(10.r)),
                                ),
                                height: 30.h,
                                width: 50.w,
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
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
        img.contains("http")
            ? Container()
            : Container(
                height: 65.h,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.r),
                  border: const Border(
                    left: BorderSide(
                      color: Colors
                          .white, // Assuming ColorConfig.white is Colors.white
                      //  width: 1,
                    ),
                    bottom: BorderSide(
                      color: Colors
                          .white, // Assuming ColorConfig.white is Colors.white
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
