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
import 'package:smartbet/services/oddsClient.dart';
import 'package:smartbet/socket/provider.dart';
import 'package:smartbet/utils/config/color.dart';
import 'package:smartbet/widget/alertSnackBar.dart';
import 'package:smartbet/widget/button.dart';
import 'package:smartbet/widget/customAppBar.dart';
import 'package:smartbet/widget/gameWidget.dart';
import 'package:smartbet/widget/resultWidget.dart';
import 'package:smartbet/widget/stakeContainer.dart';

class SmartTradeMobileScreen extends StatefulWidget {
  const SmartTradeMobileScreen(
      {super.key, required this.symbol, required this.img});

  final String symbol;
  final String img;
  @override
  State<SmartTradeMobileScreen> createState() => _SmartTradeMobileScreenState();
}

class _SmartTradeMobileScreenState extends State<SmartTradeMobileScreen> {
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
              final coinOddsData = oddsList.firstWhere(
                  (odd) => odd.type == 'coin',
                  orElse: () => Odds(
                      id: -1,
                      maxAmount: 0,
                      minAmount: 0,
                      odds: 0,
                      type: 'coin'));
              coinOdds = coinOddsData.odds;
              return SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Padding(
                  padding: EdgeInsets.symmetric(vertical: 10.h),
                  child: Column(
                    children: [
                      gameCard(
                        count: 3.toString(),
                        img: widget.img,
                        symbol: widget.symbol,
                      ),
                      Row(
                        children: [
                          Icon(
                            Icons.arrow_back,
                            size: 25.sp,
                            color: Colors.transparent,
                          ).paddingLeft(15.w).onTap(() {
                            //finish(context);
                          }),
                          100.w.toInt().width,
                          Text(
                            "Smart Trade",
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
                              padding: EdgeInsets.all(
                                  4.r), // Adding padding if needed
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
                              decoration:
                                  BoxDecoration(color: ColorConfig.appBar),
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

                      // Stack(
                      //   alignment: Alignment.center,
                      //   children: [
                      //     Container(
                      //       //  color: ColorConfig.coindollars,
                      //       width: double.infinity,
                      //       height: 250.h,
                      //     ),
                      //     Consumer<SocketProvider>(
                      //         builder: (BuildContext context, provider, _) {
                      //       return Container(
                      //         padding: EdgeInsets.symmetric(
                      //             vertical: 10.h, horizontal: 20.w),
                      //         decoration: BoxDecoration(
                      //           borderRadius: BorderRadius.circular(10.r),
                      //           // color: Colors.deepOrangeAccent,
                      //           border:
                      //               Border.all(color: ColorConfig.lightBoarder),
                      //         ),
                      //         height: 180.h,
                      //         width: 200.w,
                      //         child: Container(
                      //           decoration: BoxDecoration(
                      //             image: DecorationImage(
                      //                 //  opacity: 0.5,
                      //                 fit: BoxFit.fill,
                      //                 image: provider.counter == 49 ||
                      //                         provider.counter == 48 ||
                      //                         provider.counter == 47 ||
                      //                         provider.counter == 46
                      //                     ? AssetImage(
                      //                         "assets/images/${provider.result["coin"]}.png")
                      //                     : AssetImage(
                      //                         "assets/images/coin.gif")),
                      //           ),
                      //         ),
                      //       );
                      //     })
                      //   ],
                      // ),

                      Consumer<CoinStateProvider>(
                          builder: (BuildContext context, provider, _) {
                        return Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            // MobileGameWidget(
                            //   dym: 30,
                            //   wt: 2.h,
                            //   txtButton: 'Head',
                            //   colorImg: true,
                            //   backgroundCar: true,
                            //   currentTab: provider.head,
                            //   function: () {
                            //     provider.setCurrentTab(
                            //       head: !provider.head,
                            //       tail: false,
                            //     );
                            //   },
                            // ),
                            CustomAppButton(
                              text: 'Head',
                              isMobileWidget: provider.head,

                              ///  shimmer: true,
                              onPressed: () {
                                provider.setCurrentTab(
                                  head: !provider.head,
                                  tail: false,
                                );
                                // Add your onPressed logic here
                              },
                              color: provider.head
                                  ? ColorConfig.yellow
                                  : ColorConfig.tabincurrentindex,
                              textColor: Colors.white,
                              borderRadius: 4.r,
                              height: 22.h,
                              width: 60.w,
                              size: 14,
                              //  padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 12.0),
                            ),
                            CustomAppButton(
                              text: 'Tail',
                              isMobileWidget: provider.tail,

                              ///  shimmer: true,
                              onPressed: () {
                                provider.setCurrentTab(
                                  tail: !provider.tail,
                                  head: false,
                                );
                                // Add your onPressed logic here
                              },
                              color: provider.tail
                                  ? ColorConfig.yellow
                                  : ColorConfig.tabincurrentindex,
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
                          color: ColorConfig.yellow,
                          textColor: Colors.white,
                          borderRadius: 4.r,
                          height: 22.h,
                          width: 55.w,
                          size: 14,
                          onPressed: () {
                            final gameState = Provider.of<CoinStateProvider>(
                                context,
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
                                  width: 195);
                            }
                          },
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

class gameCard extends StatelessWidget {
  const gameCard({
    super.key,
    required this.img,
    required this.symbol,
    required this.count,
  });
  final String img;
  final String symbol;
  final String count;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 150.h,
      width: 300.w,
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
      child: Column(
        children: [
          Stack(children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.network(
                  img,
                  height: 100,
                ).cornerRadiusWithClipRRect(50),
              ],
            ),
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
