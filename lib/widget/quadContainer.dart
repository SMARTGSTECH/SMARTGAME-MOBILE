import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:shimmer/shimmer.dart';
import 'package:smartbet/screens/car/mobile.dart';
import 'package:smartbet/screens/coin/mobile.dart';
import 'package:smartbet/screens/dice/desktop.dart';
import 'package:smartbet/screens/dice/mobile.dart';
import 'package:smartbet/screens/fruit/mobile.dart';
import 'package:smartbet/utils/config/color.dart';

class QuadrantBox extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return true
        ? Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Center(
                child: Container(
                  decoration: boxDecorationWithRoundedCorners(
                      //             border: Border.all(color: ColorConfig.lightBoarder),
                      backgroundColor: Colors.transparent,
                      borderRadius: BorderRadius.circular(4.r)),
                  width: 260.h,
                  height: 260.h,
                  child: Row(
                    children: [
                      ExpandedBotton(
                        img1: AppImageDetails.car,
                        text1: "CAR RACING",
                        img2: AppImageDetails.dice,
                        text2: "DICE",
                      ),
                      ExpandedBotton(
                        img1: AppImageDetails.coin,
                        img2: AppImageDetails.fruit,
                        text1: 'COIN',
                        text2: 'FRUITS',
                      ),
                    ],
                  ),
                ).cornerRadiusWithClipRRect(10.r),
              ),
            ],
          )
        : Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Center(
                child: Container(
                  decoration: boxDecorationWithRoundedCorners(
                      //             border: Border.all(color: ColorConfig.lightBoarder),
                      backgroundColor: Colors.transparent,
                      borderRadius: BorderRadius.circular(4.r)),
                  width: 260.h,
                  height: 260.h,
                  child: Row(
                    children: [
                      ExpandedBotton(
                        img1: AppImageDetails.car,
                        text1: "CAR RACING",
                        img2: AppImageDetails.dice,
                        text2: "DICE",
                      ),
                      ExpandedBotton(
                        img1: AppImageDetails.coin,
                        img2: AppImageDetails.fruit,
                        text1: 'COIN',
                        text2: 'FRUITS',
                      ),
                    ],
                  ),
                ).cornerRadiusWithClipRRect(10.r),
              ),
            ],
          );
  }
}

class ExpandedBotton extends StatelessWidget {
  const ExpandedBotton(
      {super.key,
      required this.img1,
      required this.img2,
      required this.text1,
      required this.text2});
  final String img1;
  final String text1;
  final String img2;
  final String text2;
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        children: [
          ExpandedWidget(
            img: img1,
            text: text1,
            onTapFuntion: () {
              print(text1);
              text1.toLowerCase() == "CAR RACING".toLowerCase()
                  ? CarMobileScreen().launch(context,
                      pageRouteAnimation: PageRouteAnimation.Fade)
                  : CoinMobileScreen().launch(context,
                      pageRouteAnimation: PageRouteAnimation.Fade);
            },
          ),
          ExpandedWidget(
            img: img2,
            text: text2,
            onTapFuntion: () {
              text2.toLowerCase() == "Dice".toLowerCase()
                  ? DiceMobileScreen().launch(context,
                      pageRouteAnimation: PageRouteAnimation.Fade)
                  : FruitMobileScreen().launch(context,
                      pageRouteAnimation: PageRouteAnimation.Fade);
            },
          ),
        ],
      ),
    );
  }
}

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
    return Expanded(
      child: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.r),
              border: Border.all(
                color: ColorConfig.white,
                width: 2,
              ),
              gradient: const LinearGradient(
                colors: [Colors.red, Colors.orange],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
              image: DecorationImage(
                  //  opacity: 0.5,
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
      ).onTap(onTapFuntion),
    );
  }
}
