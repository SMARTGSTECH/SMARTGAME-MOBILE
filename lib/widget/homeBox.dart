import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:provider/provider.dart';
import 'package:smartbet/main_screen/provider.dart';
import 'package:smartbet/utils/config/color.dart';
import 'package:smartbet/widget/button.dart';

class HomeContainerBox extends StatelessWidget {
  const HomeContainerBox(
      {super.key,
      required this.img,
      required this.name,
      required this.onTap,
      this.isFitted = false,
      required this.index});
  final String img;
  final String name;
  final VoidCallback onTap;
  final int index;
  final bool? isFitted;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 12.w, vertical: 5.h),
      decoration: boxDecorationWithRoundedCorners(
          border: Border.all(color: ColorConfig.lightBoarder),
          backgroundColor: Colors.black12,
          borderRadius: BorderRadius.circular(4.r)),
      width: double.infinity,
      child: Row(
        children: [
          true
              ? Container(
                  height: 95.h,
                  width: 175.w,
                  child: Lottie.asset(img
                      // height: 60,
                      // width: 600,
                      ),
                  decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          (img == AppImageDetails.coin ||
                                  img == AppImageDetails.dice)
                              ? Colors.red
                              : Colors.transparent,
                          (img == AppImageDetails.coin ||
                                  img == AppImageDetails.dice)
                              ? Colors.orange
                              : Colors.transparent,
                        ],
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                      ),
                      image: DecorationImage(
                          fit: isFitted!
                              ? BoxFit.fitHeight
                              : name.toLowerCase() == "fruits"
                                  ? BoxFit.fill
                                  : BoxFit.cover,
                          image: AssetImage(img))))
              : Container(
                  height: 95.h,
                  width: 175.w,
                  decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          (img == AppImageDetails.coin ||
                                  img == AppImageDetails.dice)
                              ? Colors.red
                              : Colors.transparent,
                          (img == AppImageDetails.coin ||
                                  img == AppImageDetails.dice)
                              ? Colors.orange
                              : Colors.transparent,
                        ],
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                      ),
                      image: DecorationImage(
                          fit: isFitted!
                              ? BoxFit.fitHeight
                              : name.toLowerCase() == "fruits"
                                  ? BoxFit.fill
                                  : BoxFit.cover,
                          image: AssetImage(img)))),
          Expanded(
              child: Container(
            color: Colors.transparent,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  name,
                  style: primaryTextStyle(
                      color: ColorConfig.iconColor,
                      size: 13.sp.toInt(),
                      weight: FontWeight.bold),
                ),
                10.h.toInt().height,
                Consumer<MainScreenProvider>(
                  builder: (BuildContext context, model, _) {
                    return CustomAppButton(
                      text: 'Play Nkkow',
                      onPressed: () {
                        model.setPageIndex(index);
                      },
                      color: ColorConfig.yellow,
                      textColor: Colors.white,
                      borderRadius: 5.r,
                      height: 20.h,
                      width: 70.w,
                      padding: EdgeInsets.symmetric(
                          horizontal: 20.0, vertical: 12.0),
                    );
                  },
                )
              ],
            ),
          ))
        ],
      ),
    );
  }
}
