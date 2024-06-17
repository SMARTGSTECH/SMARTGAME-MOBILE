import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:provider/provider.dart';
import 'package:smartbet/screens/dice/dicehistory/historyMobile.dart';
import 'package:smartbet/screens/dice/provider.dart';
import 'package:smartbet/screens/history/mobile.dart';
import 'package:smartbet/services/oddsClient.dart';
import 'package:smartbet/socket/provider.dart';
import 'package:smartbet/utils/config/color.dart';
import 'package:smartbet/widget/alertSnackBar.dart';
import 'package:smartbet/widget/button.dart';
import 'package:smartbet/widget/customAppBar.dart';
import 'package:smartbet/widget/gameWidget.dart';
import 'package:smartbet/widget/resultWidget.dart';
import 'package:smartbet/widget/stakeContainer.dart';

class DiceMobileScreen extends StatefulWidget {
  const DiceMobileScreen({super.key});

  @override
  State<DiceMobileScreen> createState() => _DiceMobileScreenState();
}

class _DiceMobileScreenState extends State<DiceMobileScreen> {
  late Future<List<Odds>> futureOdds;
  late double diceOdds;

  @override
  void initState() {
    super.initState();
    futureOdds = fetchOdds();
    diceOdds = 0.0;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppbarNOWallet(context),
      body: FutureBuilder<List<Odds>>(
          future: futureOdds,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}');
            } else {
              final oddsList = snapshot.data!;
              // Find odds for race type
              final diceOddsData = oddsList.firstWhere(
                  (odd) => odd.type == 'dice',
                  orElse: () => Odds(
                      id: -1,
                      maxAmount: 0,
                      minAmount: 0,
                      odds: 0,
                      type: 'dice'));
              diceOdds = diceOddsData.odds;
              return SingleChildScrollView(
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
                            ///inish(context);
                          }),
                          100.w.toInt().width,
                          Text(
                            "Throw Dice",
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
                              "Correct Number Wins:",
                              style: TextStyle(
                                color: ColorConfig.iconColor,
                                fontSize: 13.sp,

                                /// fontWeight: FontWeight.w500,
                              ),
                            ),
                            Container().expand(),
                            Container(
                              decoration:
                                  BoxDecoration(color: ColorConfig.yellow),
                              height: 19.h,
                              width: 35.h,
                              child: Center(
                                child: Text(
                                  "$diceOdds" "x",
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
                              ).onTap(() {
                                // HistoryMobile().launch(context);
                                DiceHistoryMobile(
                                  isStake: false,
                                ).launch(context);
                                //   CustomSnackBar(
                                //       context: context,
                                //       message: "Coming Soon!",
                                //       leftColor: ColorConfig.yellow,
                                //       width: 165);
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
                          Container(
                            // color: Colors.amber,

                            // padding: EdgeInsetsDirectional.symmetric(horizontal: 85.w),
                            child: Consumer<SocketProvider>(
                                builder: (BuildContext context, provider, _) {
                              return provider.gameHistory.isEmpty
                                  ? Lottie.asset(
                                      "assets/images/beiLoader.json",
                                      height: 80,
                                      width: 80,
                                    )
                                  : provider.counter <= 45
                                      ? Column(
                                          children: [
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: List.generate(
                                                provider
                                                    .firstFiveHistory.length,
                                                (index) => resultContainer(
                                                  // colorImg: true,
                                                  //color: ColorConfig.redCar.withOpacity(0.9),
                                                  img: provider.firstFiveHistory[
                                                              index]['dice'] ==
                                                          '1'
                                                      ? "assets/images/1.png"
                                                      : provider.firstFiveHistory[
                                                                      index]
                                                                  ['dice'] ==
                                                              '2'
                                                          ? "assets/images/2.png"
                                                          : provider.firstFiveHistory[
                                                                          index][
                                                                      'dice'] ==
                                                                  '3'
                                                              ? "assets/images/3.png"
                                                              : provider.firstFiveHistory[index]
                                                                          ['dice'] ==
                                                                      '4'
                                                                  ? "assets/images/4.png"
                                                                  : provider.firstFiveHistory[index]['dice'] == '5'
                                                                      ? "assets/images/5.png"
                                                                      : "assets/images/6.png",

                                                  height: 40,
                                                  width: 40,
                                                ),
                                              ),
                                            ),
                                            8.height,
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: List.generate(
                                                provider.lastFiveHistory.length,
                                                (index) => resultContainer(
                                                  // colorImg: true,
                                                  //color: ColorConfig.redCar.withOpacity(0.9),
                                                  img: provider.lastFiveHistory[
                                                              index]['dice'] ==
                                                          "1"
                                                      ? "assets/images/1.png"
                                                      : provider.lastFiveHistory[
                                                                      index]
                                                                  ['dice'] ==
                                                              "2"
                                                          ? "assets/images/2.png"
                                                          : provider.lastFiveHistory[
                                                                          index][
                                                                      'dice'] ==
                                                                  "3"
                                                              ? "assets/images/3.png"
                                                              : provider.lastFiveHistory[index]
                                                                          ['dice'] ==
                                                                      "4"
                                                                  ? "assets/images/4.png"
                                                                  : provider.lastFiveHistory[index]['dice'] == "5"
                                                                      ? "assets/images/5.png"
                                                                      : "assets/images/6.png",

                                                  height: 40,
                                                  width: 40,
                                                ),
                                              ),
                                            ),
                                          ],
                                        )
                                      : Lottie.asset(
                                          "assets/images/beiLoader.json",
                                          height: 60,
                                          width: 60,
                                        );
                              ;
                            }),
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
                              ).onTap(() {
                                // HistoryMobile().launch(context);
                                DiceHistoryMobile(
                                  isStake: true,
                                ).launch(context);
                                //   CustomSnackBar(
                                //       context: context,
                                //       message: "Coming Soon!",
                                //       leftColor: ColorConfig.yellow,
                                //       width: 165);
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
                                // border:
                                //     Border.all(color: ColorConfig.lightBoarder),
                              ),
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
                                              "assets/images/d${provider.result["dice"]}.png")
                                          : AssetImage(
                                              "assets/images/loader.gif")),
                                ),
                              ),
                              height: 180.h,
                              width: 200.w,
                            );
                          })
                          // Positioned(
                          //     bottom: 175.h,
                          //     right: 0,
                          //     left: 275.w,
                          //     //     bottom: SizeConfigs.getPercentageHeight(2),
                          //     child: AvatarGlow(
                          //         endRadius: 45.r,
                          //         animate: true,
                          //         showTwoGlows: true,
                          //         repeatPauseDuration: Duration(milliseconds: 100),
                          //         glowColor: ColorConfig.yellow,
                          //         duration: Duration(milliseconds: 2000),
                          //         child: CircleAvatar(
                          //             radius: 20.r,
                          //             backgroundColor: ColorConfig.appBar,
                          //             child: Center(
                          //               child: Icon(
                          //                 Icons.volume_up,
                          //                 size: 25.sp,
                          //                 color: ColorConfig.iconColor,
                          //               ),
                          //             )))),
                        ],
                      ),
                      Consumer<DiceStateProvider>(
                          builder: (BuildContext context, provider, _) {
                        return Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            CustomAppButton(
                              text: '1',
                              usePadding: provider.one,

                              ///  shimmer: true,
                              onPressed: () {
                                provider.setCurrentTab(
                                    one: !provider.one,
                                    two: false,
                                    three: false,
                                    four: false,
                                    five: false,
                                    six: false);
                                // Add your onPressed logic here
                              },
                              color: provider.one
                                  ? ColorConfig.yellow
                                  : ColorConfig.tabincurrentindex,
                              textColor: Colors.white,
                              borderRadius: 4.r,
                              height: 22.h,
                              width: 30.w,
                              size: 14,
                              //  padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 12.0),
                            ),
                            CustomAppButton(
                              text: '2',
                              usePadding: provider.two,

                              ///  shimmer: true,
                              onPressed: () {
                                provider.setCurrentTab(
                                    one: false,
                                    two: !provider.two,
                                    three: false,
                                    four: false,
                                    five: false,
                                    six: false);
                                // Add your onPressed logic here
                              },
                              color: provider.two
                                  ? ColorConfig.yellow
                                  : ColorConfig.tabincurrentindex,
                              textColor: Colors.white,
                              borderRadius: 4.r,
                              height: 22.h,
                              width: 30.w,
                              size: 14,
                              //  padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 12.0),
                            ),
                            CustomAppButton(
                              text: '3',
                              usePadding: provider.three,

                              ///  shimmer: true,
                              onPressed: () {
                                provider.setCurrentTab(
                                    one: false,
                                    two: false,
                                    three: !provider.three,
                                    four: false,
                                    five: false,
                                    six: false);
                                // Add your onPressed logic here
                              },
                              color: provider.three
                                  ? ColorConfig.yellow
                                  : ColorConfig.tabincurrentindex,
                              textColor: Colors.white,
                              borderRadius: 4.r,
                              height: 22.h,
                              width: 30.w,
                              size: 14,
                              //  padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 12.0),
                            ),
                            CustomAppButton(
                              text: '4',
                              usePadding: provider.four,

                              ///  shimmer: true,
                              onPressed: () {
                                provider.setCurrentTab(
                                    one: false,
                                    two: false,
                                    three: false,
                                    four: !provider.four,
                                    five: false,
                                    six: false);
                                // Add your onPressed logic here
                              },
                              color: provider.four
                                  ? ColorConfig.yellow
                                  : ColorConfig.tabincurrentindex,
                              textColor: Colors.white,
                              borderRadius: 4.r,
                              height: 22.h,
                              width: 30.w,
                              size: 14,
                              //  padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 12.0),
                            ),
                            CustomAppButton(
                              text: '5',
                              usePadding: provider.five,

                              ///  shimmer: true,
                              onPressed: () {
                                provider.setCurrentTab(
                                    one: false,
                                    two: false,
                                    three: false,
                                    four: false,
                                    five: !provider.five,
                                    six: false);
                                // Add your onPressed logic here
                              },
                              color: provider.five
                                  ? ColorConfig.yellow
                                  : ColorConfig.tabincurrentindex,
                              textColor: Colors.white,
                              borderRadius: 4.r,
                              height: 22.h,
                              width: 30.w,
                              size: 14,
                              //  padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 12.0),
                            ),
                            CustomAppButton(
                              text: '6',
                              usePadding: provider.six,

                              ///  shimmer: true,
                              onPressed: () {
                                provider.setCurrentTab(
                                    one: false,
                                    two: false,
                                    three: false,
                                    four: false,
                                    five: false,
                                    six: !provider.six);
                                // Add your onPressed logic here
                              },
                              color: provider.six
                                  ? ColorConfig.yellow
                                  : ColorConfig.tabincurrentindex,
                              textColor: Colors.white,
                              borderRadius: 4.r,
                              height: 22.h,
                              width: 30.w,
                              size: 14,
                              //  padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 12.0),
                            ),
                          ],
                        ).paddingSymmetric(horizontal: 50.w);
                      }),
                      // 15.h.toInt().height,
                      // Text(
                      //   "Select Number",
                      //   style: TextStyle(
                      //     fontSize: 13.sp,
                      //     color: ColorConfig.iconColor,
                      //   ),
                      // ),

                      15.h.toInt().height,
                      Consumer<SocketProvider>(
                          builder: (BuildContext context, model, _) {
                        if (model.counter <= 10) {
                          return CustomAppButton(
                            color: Colors.grey,
                            textColor: Colors.black,
                            borderRadius: 5,
                            height: 24,
                            width: 60,
                            size: 16,

                            ///    shimmer: true,
                            onPressed: () {
                              CustomSnackBar(
                                  context: context,
                                  message: "Game Session Ended!",
                                  width: 195);
                            },

                            ///  color: Colors.grey,
                            text: 'Play',
                          );
                        }

                        return CustomAppButton(
                            text: 'Play',
                            shimmer: true,
                            onPressed: () {
                              final gameState = Provider.of<DiceStateProvider>(
                                  context,
                                  listen: false);

                              if (gameState.one ||
                                  gameState.two ||
                                  gameState.three ||
                                  gameState.four ||
                                  gameState.five ||
                                  gameState.six) {
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
                                        coin: false,
                                        dice: true,
                                        maxAmount: 2,
                                        minAmount: 0.000005,
                                      ),
                                    );
                                  },
                                );
                              } else {
                                CustomSnackBar(
                                    context: context,
                                    message: "Please Select Dice",
                                    width: 185);
                              }
                            },
                            color: ColorConfig.yellow,
                            textColor: Colors.white,
                            borderRadius: 5,
                            height: 22.h,
                            width: 60.w,
                            size: 14
                            //  padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 12.0),
                            );
                      }),

                      //10.h.toInt().height,
                    ],
                  ),
                ),
              );
            }
          }),
    );
  }
}
