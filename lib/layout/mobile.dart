import 'package:avatar_glow/avatar_glow.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:provider/provider.dart';
import 'package:smartbet/screens/coin/provider.dart';
import 'package:smartbet/socket/provider.dart';
import 'package:smartbet/utils/config/color.dart';
import 'package:smartbet/widget/alertSnackBar.dart';
import 'package:smartbet/widget/button.dart';
import 'package:smartbet/widget/gameWidget.dart';
import 'package:smartbet/widget/stakeContainer.dart';

class CoinMobileScreen extends StatefulWidget {
  const CoinMobileScreen({super.key});

  @override
  State<CoinMobileScreen> createState() => _CoinMobileScreenState();
}

class _CoinMobileScreenState extends State<CoinMobileScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Image.asset(
          "assets/images/icon/icon.png",
          width: 15.h,
          height: 15.h,
        ).paddingLeft(23.w),
        actions: [
          Icon(
            Icons.account_balance_wallet_rounded,
            color: ColorConfig.iconColor,
            size: 25.sp,
          ).paddingRight(23.w),
        ],
        centerTitle: true,
        title: Text(
          "SmartBet",
          style: TextStyle(
            color: ColorConfig.iconColor,
            fontSize: 18.sp,
            fontWeight: FontWeight.w500,
          ),
        ),
        backgroundColor: ColorConfig.appBar,
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 10.h),
          child: Column(
            children: [
              Row(
                children: [
                  Icon(
                    Icons.arrow_back,
                    size: 25.sp,
                    color: ColorConfig.iconColor,
                  ).paddingLeft(15.w).onTap(() {
                    finish(context);
                  }),
                  100.w.toInt().width,
                  Text(
                    "COIN FLIP",
                    style: TextStyle(
                      color: ColorConfig.iconColor,
                      fontSize: 15.sp,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
              20.h.toInt().height,
              Container(
                decoration: BoxDecoration(color: ColorConfig.appBar),
                height: 30.h,
                width: 300.w,
                child: Row(
                  children: [
                    11.w.toInt().width,
                    Text(
                      "Correct Side Wins:",
                      style: TextStyle(
                        color: ColorConfig.iconColor,
                        fontSize: 13.sp,

                        /// fontWeight: FontWeight.w500,
                      ),
                    ),
                    Container().expand(),
                    Container(
                      decoration: BoxDecoration(color: ColorConfig.yellow),
                      height: 19.h,
                      width: 35.h,
                      child: Center(
                        child: Text(
                          "1.5x",
                          style: TextStyle(
                            color: ColorConfig.black,
                            fontSize: 13.sp,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ).cornerRadiusWithClipRRect(5.r),
                    11.w.toInt().width,
                  ],
                ),
              ).cornerRadiusWithClipRRect(6.r),
              20.h.toInt().height,
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      CircleAvatar(
                        radius: 17.r,
                        backgroundColor: ColorConfig.appBar,
                        child: Center(
                          child: Icon(
                            Icons.history,
                            size: 25.sp,
                            color: ColorConfig.iconColor,
                          ),
                        ),
                      ),
                      5.h.toInt().height,
                      // Text(
                      //   "Game",
                      //   style: TextStyle(
                      //       fontSize: 12.sp,
                      //       color: ColorConfig.iconColor,
                      //       fontWeight: FontWeight.bold),
                      // ),
                      Text(
                        "History",
                        style: TextStyle(
                            fontSize: 12.sp,
                            color: ColorConfig.iconColor,
                            fontWeight: FontWeight.w500),
                      )
                    ],
                  ),
                  Container(
                    // color: Colors.amber,
                    width: 200.w,
                    // padding: EdgeInsetsDirectional.symmetric(horizontal: 85.w),
                    child: Column(
                      children: [
                        // First Row
                        Row(
                          children: List.generate(
                            5,
                            (index) => Expanded(
                              child: Container(
                                decoration: BoxDecoration(
                                  color: ColorConfig.scaffold,
                                  border: Border.all(
                                    color: ColorConfig.white.withOpacity(0.4),
                                  ),
                                ),
                                height: 30.h,
                                width: 30.h,
                                margin: EdgeInsets.symmetric(
                                    vertical: 1.0.h, horizontal: 1.0.w),
                                child: Center(
                                  child: Text(
                                    "H",
                                    style: TextStyle(
                                        fontSize: 15.sp,
                                        color: ColorConfig.iconColor,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ).cornerRadiusWithClipRRect(3.r),
                            ),
                          ),
                        ),
                        // Second Row
                        Row(
                          children: List.generate(
                            5,
                            (index) => Expanded(
                              child: Container(
                                decoration: BoxDecoration(
                                  color: ColorConfig.scaffold,
                                  border: Border.all(
                                    color: ColorConfig.white.withOpacity(0.4),
                                  ),
                                ),
                                height: 30.h,
                                width: 30.h,
                                margin: EdgeInsets.symmetric(
                                    vertical: 1.0.h, horizontal: 1.0.w),
                                child: Center(
                                  child: Text(
                                    "T",
                                    style: TextStyle(
                                        fontSize: 15.sp,
                                        color: ColorConfig.iconColor,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ).cornerRadiusWithClipRRect(3.r),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      CircleAvatar(
                        radius: 17.r,
                        backgroundColor: ColorConfig.appBar,
                        child: Center(
                          child: Icon(
                            Icons.history,
                            size: 25.sp,
                            color: ColorConfig.iconColor,
                          ),
                        ),
                      ),
                      5.h.toInt().height,
                      // Text(
                      //   "My",
                      //   style: TextStyle(
                      //       fontSize: 12.sp,
                      //       color: ColorConfig.iconColor,
                      //       fontWeight: FontWeight.bold),
                      // ),
                      Text(
                        "Stakes",
                        style: TextStyle(
                            fontSize: 12.sp,
                            color: ColorConfig.iconColor,
                            fontWeight: FontWeight.w500),
                      )
                    ],
                  ),
                ],
              ),
              20.h.toInt().height,
              Consumer<SocketProvider>(
                  builder: (BuildContext context, provider, _) {
                return Container(
                  decoration: BoxDecoration(color: ColorConfig.appBar),
                  child: Center(
                    child: Text(
                      "${provider.counter}:00",
                      style: TextStyle(
                          fontSize: 16.sp,
                          color: ColorConfig.iconColor,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                )
                    .withWidth(60.w)
                    .withHeight(30.h)
                    .cornerRadiusWithClipRRect(5.r);
              }),
              //10.h.toInt().height,
              Stack(
                alignment: Alignment.center,
                children: [
                  Container(
                    //  color: ColorConfig.coindollars,
                    width: double.infinity,
                    height: 250.h,
                  ),
                  Consumer<SocketProvider>(
                      builder: (BuildContext context, provider, _) {
                    return Container(
                      padding: EdgeInsets.symmetric(
                          vertical: 10.h, horizontal: 20.w),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.r),
                        // color: Colors.deepOrangeAccent,
                        border: Border.all(color: ColorConfig.lightBoarder),
                      ),
                      height: 180.h,
                      width: 200.w,
                      child: Container(
                        decoration: BoxDecoration(
                          image: DecorationImage(
                              //  opacity: 0.5,
                              fit: BoxFit.fill,
                              image: provider.counter == 49 ||
                                      provider.counter == 48 ||
                                      provider.counter == 47 ||
                                      provider.counter == 46
                                  ? AssetImage(
                                      "assets/images/${provider.result["coin"]}.png")
                                  : AssetImage("assets/images/coin.gif")),
                        ),
                      ),
                    );
                  })
                ],
              ),

              Consumer<CoinStateProvider>(
                  builder: (BuildContext context, provider, _) {
                return Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    MobileGameWidget(
                      dym: 30,
                      wt: 2.h,
                      txtButton: 'Head',
                      colorImg: true,
                      backgroundCar: true,
                      currentTab: provider.head,
                      function: () {
                        provider.setCurrentTab(
                          head: !provider.head,
                          tail: false,
                        );
                      },
                    ),
                    CustomAppButton(
                      text: 'Head',

                      ///  shimmer: true,
                      onPressed: () {
                        // Add your onPressed logic here
                      },
                      color: ColorConfig.yellow,
                      textColor: Colors.white,
                      borderRadius: 4.r,
                      height: 22.h,
                      width: 60.w,
                      size: 14,
                      //  padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 12.0),
                    ),
                  ],
                ).paddingSymmetric(horizontal: 50.w);
              }),
              15.h.toInt().height,

              // Text(
              //   "Select Side",
              //   style: TextStyle(
              //     fontSize: 13.sp,
              //     color: ColorConfig.iconColor,
              //   ),
              // ),
              15.h.toInt().height,

              CustomAppButton(
                text: 'Play',
                color: ColorConfig.yellow,
                textColor: Colors.white,
                borderRadius: 4.r,
                height: 22.h,
                width: 55.w,
                size: 14,
                onPressed: () {
                  final gameState =
                      Provider.of<CoinStateProvider>(context, listen: false);

                  if (gameState.head || gameState.tail) {
                    showDialog(
                      useRootNavigator: false,
                      barrierDismissible: false,
                      context: context,
                      builder: (BuildContext context) {
                        return Dialog(
                          // shape: CircleBorder(),
                          backgroundColor: Colors.transparent,
                          elevation: 10,
                          child: StakeContainer(
                            fruit: false,
                            car: false,
                            coin: true,
                            dice: false,
                            maxAmount: 1,
                            minAmount: 0.001,
                          ),
                        );
                      },
                    );
                  } else {
                    CustomSnackBar(
                        context: context,
                        message: "Please Select A Side",
                        width: 195);
                  }
                },
              ),

              //10.h.toInt().height,
            ],
          ),
        ),
      ),
    );
  }
}
