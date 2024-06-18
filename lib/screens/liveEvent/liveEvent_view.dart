import 'package:avatar_glow/avatar_glow.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';
import 'package:smartbet/screens/coin/coinhistory/historyMobile.dart';
import 'package:smartbet/screens/coin/provider.dart';
import 'package:smartbet/screens/history/mobile.dart';
import 'package:smartbet/screens/liveEvent/liveEvent_view_model.dart';
import 'package:smartbet/services/oddsClient.dart';
import 'package:smartbet/socket/provider.dart';
import 'package:smartbet/utils/config/color.dart';
import 'package:smartbet/widget/alertSnackBar.dart';
import 'package:smartbet/widget/button.dart';
import 'package:smartbet/widget/customAppBar.dart';
import 'package:smartbet/widget/customGridview.dart';
import 'package:smartbet/widget/gameWidget.dart';
import 'package:smartbet/widget/resultWidget.dart';
import 'package:smartbet/widget/stakeContainer.dart';

class LiveEventMobileScreen extends StatefulWidget {
  const LiveEventMobileScreen(
      {super.key,
      required this.symbol,
      required this.img,
      required this.option});

  final String symbol;
  final String img;
  final List option;

  @override
  State<LiveEventMobileScreen> createState() => _LiveEventMobileScreenState();
}

class _LiveEventMobileScreenState extends State<LiveEventMobileScreen> {
  late Future<List<Odds>> futureOdds;
  late double coinOdds;

  @override
  void initState() {
    super.initState();
    futureOdds = fetchOdds();
    coinOdds = 0.0;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: customAppbar(context),
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
                      color: Colors.transparent,
                    ).paddingLeft(15.w).onTap(() {
                      //finish(context);
                    }),
                    80.w.toInt().width,
                    Text(
                      "Live Prediction",
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
                        "Correct Prediction Wins:",
                        style: TextStyle(
                          color: ColorConfig.iconColor,
                          fontSize: 13.sp,

                          /// fontWeight: FontWeight.w500,
                        ),
                      ),
                      Container().expand(),
                      //   Card(ch)
                      Container(
                        decoration: BoxDecoration(
                          color: ColorConfig.yellow,
                          borderRadius: BorderRadius.circular(5.r),
                        ),
                        padding:
                            EdgeInsets.all(4.r), // Adding padding if needed
                        child: IntrinsicWidth(
                          child: IntrinsicHeight(
                            child: Center(
                              child: Text(
                                "\$$coinOdds / \$30.4",
                                style: TextStyle(
                                  color: ColorConfig.black,
                                  fontSize: 12.sp,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            // child: YourChildWidget(), // Replace with your actual child widget
                          ),
                        ),
                      ),
                      // Container(
                      //   decoration:
                      //       BoxDecoration(color: ColorConfig.yellow),
                      //   height: 19.h,
                      //   width: 58.h,
                      //   child:
                      // ).cornerRadiusWithClipRRect(5.r),
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
                        ).onTap(() {
                          CoinHistoryMobile(
                            isStake: false,
                          ).launch(context);
                          // CustomSnackBar(
                          //     context: context,
                          //     message: "Coming Soon!",
                          //     leftColor: ColorConfig.yellow,
                          //     width: 165);
                        }),
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
                        ).onTap(() {
                          CoinHistoryMobile(
                            isStake: true,
                          ).launch(context);
                        }),
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

                //10.h.toInt().height,
                gameCard(
                  count: 30.toString(),
                  img: widget.img,
                  symbol: '',
                  tp: '',
                ),

                Consumer<LiveEventPredictionProvider>(
                    builder: (BuildContext context, provider, _) {
                  return Container(
                    ///color: ColorConfig.blue,
                    width: 300.w,
                    height: provider.isOdd(provider.gameOption.length)
                        ? provider.gameOption.length * 30.h
                        : provider.gameOption.length * 24.3.h,
                    child: CustomGridView(
                      gridCount: true,
                      useAspectRatio: true,
                      itemCount: provider.gameOption.length,
                      crossAxisCount: 2,
                      crossAxisSpacing: 10.0,
                      mainAxisSpacing: 1.h,
                      itemBuilder: (BuildContext context, int index) {
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: CustomAppButton(
                            text: provider.gameOption[index],
                            usePadding: true,

                            ///  shimmer: true,
                            onPressed: () {
                              provider.toggleOption(provider.gameOption[index]);
                              provider.toggleOptionIndex(provider.gameOption
                                  .indexOf(provider.gameOption[index]));
                              print([
                                provider.gameOption[index],
                                provider.gameOption.indexOf(
                                  provider.selectedOption,
                                ),
                                provider.gameOption
                                        .indexOf(provider.gameOption[index]) ==
                                    provider.selectedOptionIndex
                              ]);
                              // provider.setCurrentTab(
                              //   tail: !provider.tail,
                              //   head: false,
                              // );
                              // Add your onPressed logic here
                            },
                            color: provider.gameOption
                                        .indexOf(provider.gameOption[index]) ==
                                    provider.selectedOptionIndex
                                ? ColorConfig.yellow
                                : ColorConfig.tabincurrentindex,
                            textColor: Colors.white,
                            borderRadius: 4.r,
                            height: 0,
                            width: 0,
                            size: 14,
                            //  padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 12.0),
                          ),
                        );
                      },
                    ),
                  );
                }).paddingTop(30.h),
                //  15.h.toInt().height,

                // Text(
                //   "Select Side",
                //   style: TextStyle(
                //     fontSize: 13.sp,
                //     color: ColorConfig.iconColor,
                //   ),

                Consumer<SocketProvider>(
                    builder: (BuildContext context, model, _) {
                  if (model.counter <= 10) {
                    return CustomAppButton(
                      color: Colors.grey,
                      textColor: Colors.black,
                      borderRadius: 4.r,
                      height: 22.h,
                      width: 60.w,
                      size: 14,

                      ///    shimmer: true,
                      onPressed: () {
                        CustomSnackBar(
                            context: context,
                            message: "Game Session Ended!",
                            width: 220);
                      },

                      ///  color: Colors.grey,
                      text: 'Play',
                    );
                  }
                  return CustomAppButton(
                    text: 'Play',
                    color: ColorConfig.yellow,
                    textColor: Colors.white,
                    borderRadius: 4.r,
                    height: 22.h,
                    width: 60.w,
                    size: 14,
                    onPressed: () {
                      final gameState = Provider.of<CoinStateProvider>(context,
                          listen: false);

                      if (gameState.head || gameState.tail) {
                        showDialog(
                          useRootNavigator: false,
                          barrierDismissible: true,
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
                                maxAmount: 0.000048,
                                minAmount: 0.00005,
                              ),
                            );
                          },
                        );
                      } else {
                        CustomSnackBar(
                            context: context,
                            message: "Please Select A Side",
                            width: 220);
                      }
                    },
                  );
                }),
                // ),
                25.h.toInt().height,
                //10.h.toInt().height,
              ],
            ),
          ),
        ));
  }
}

class gameCard extends StatelessWidget {
  const gameCard({
    super.key,
    required this.img,
    required this.symbol,
    required this.count,
    required this.tp,
  });
  final String img;
  final String symbol;
  final String count;
  final String tp;

  @override
  Widget build(BuildContext context) {
    print(img);
    return Container(
      height: 150.h,
      width: 300.w,
      decoration: symbol == ''
          ? BoxDecoration(
              image: DecorationImage(
                  //  opacity: 0.5,
                  fit: symbol == '' ? BoxFit.cover : BoxFit.fitHeight,
                  image: NetworkImage(img)),
              gradient: LinearGradient(
                colors: symbol == ''
                    ? [
                        Color.fromARGB(0, 0, 0, 0),
                        Colors.transparent,
                      ]
                    : [
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
            )
          : BoxDecoration(
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
      child: Column(
        children: [
          Stack(children: [
            symbol == ''
                ? Row(
                    children: [],
                  )
                : Row(
                    mainAxisAlignment: MainAxisAlignment.center,

                    // mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.network(
                        img,
                        height: 75.h,
                      ).cornerRadiusWithClipRRect(50),
                      15.w.toInt().width,
                      Text(
                        "\$150",
                        style: TextStyle(
                            fontSize: 25.sp,
                            color: ColorConfig.iconColor,
                            fontWeight: FontWeight.bold),
                      )
                    ],
                  ).paddingTop(28.h),
            Row(
              children: [
                Container(
                  color: Colors.transparent,
                  height: 25.h,
                  width: 298.w,
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
                        decoration: BoxDecoration(
                          color: ColorConfig.appBar,
                          borderRadius: BorderRadius.only(
                              topLeft: radiusCircular(10.r),
                              topRight: radiusCircular(10.r),
                              bottomLeft: radiusCircular(10.r)),
                        ),
                        height: 30.h,
                        width: 50.w,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.person,
                              color: ColorConfig.iconColor,
                            ),
                            Text(
                              count,
                              style: TextStyle(
                                fontSize: 15.sp,
                                // color: ColorConfig.iconColor,
                              ),
                            ).center(),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ]),
          Container().expand(),
          Padding(
            padding: const EdgeInsets.all(7.0),
            child: Row(
              children: [
                Shimmer.fromColors(
                  baseColor: Colors.grey,
                  highlightColor: Colors.white,
                  period: Duration(milliseconds: 1500),
                  child: Text(
                    "Total Pool: ",
                    style: TextStyle(
                        fontSize: 15.sp,
                        // color: ColorConfig.iconColor,
                        fontWeight: FontWeight.bold),
                  ).paddingBottom(6.h).paddingLeft(1.w),
                ),
                Container().expand(),
                Shimmer.fromColors(
                  baseColor: Colors.grey,
                  highlightColor: Colors.white,
                  period: Duration(milliseconds: 1500),
                  child: Text(
                    "\$40",
                    style: TextStyle(
                        fontSize: 15.sp,
                        // color: ColorConfig.iconColor,
                        fontWeight: FontWeight.bold),
                  ).paddingBottom(6.h).paddingLeft(1.w),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
