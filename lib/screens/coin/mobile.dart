import 'package:avatar_glow/avatar_glow.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:provider/provider.dart';
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

class CoinMobileScreen extends StatefulWidget {
  const CoinMobileScreen({super.key});

  @override
  State<CoinMobileScreen> createState() => _CoinMobileScreenState();
}

class _CoinMobileScreenState extends State<CoinMobileScreen> {
  late Future<List<Odds>> futureOdds;
  late double coinOdds;
  late List coinOddsq;

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
              print('THIS IS THE EXPERIEkekwejkwjewjekwjekweNCESS');
              print(oddsList);
              //    final coinOddsData = oddsList.where((e.)=>);
              // Find odds for race type
              final coinOddsData = oddsList
                  .where(
                    (odd) => odd.type == 'coin',
                  )
                  .toList()
                  .first;
              coinOddsq = [
                coinOddsData.minAmount,
                coinOddsData.maxAmount,
                coinOddsData.odds
              ];
              print('THIS IS THE EXPERIENCESS');
              print(coinOddsq);
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
                            //finish(context);
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
                              decoration:
                                  BoxDecoration(color: ColorConfig.yellow),
                              height: 19.h,
                              width: 35.h,
                              child: Center(
                                child: Text(
                                  "${coinOddsq[2]}" 'x',
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
                          Container(
                            // color: Colors.amber,
                            // width: 200.w,
                            // padding: EdgeInsetsDirectional.symmetric(horizontal: 85.w),
                            child: Consumer<SocketProvider>(
                                builder: (BuildContext context, provider, _) {
                              return provider.gameHistory.isEmpty
                                  ? Lottie.asset(
                                      "assets/images/beiLoader.json",
                                      height: 80,
                                      width: 80,
                                    )
                                  : provider.counter <= 290
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
                                                  // color: Color(0xffc89e3c),
                                                  height: 40,
                                                  width: 40,
                                                  img: provider
                                                              .firstFiveHistory[
                                                                  index]['coin']
                                                              .toLowerCase() ==
                                                          'head'
                                                      ? "assets/images/H.png"
                                                      : 'assets/images/T.png',
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
                                                  // color: Color(0xffc89e3c),
                                                  height: 40,
                                                  width: 40,
                                                  img: provider.lastFiveHistory[
                                                                  index]['coin']
                                                              .toLowerCase() ==
                                                          'tail'
                                                      ? "assets/images/T.png"
                                                      : 'assets/images/H.png',
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
                              height: 180.h,
                              width: 200.w,
                              child: Container(
                                decoration: BoxDecoration(
                                  image: DecorationImage(
                                      //  opacity: 0.5,
                                      fit: BoxFit.fill,
                                      image: provider.counter == 299 ||
                                              provider.counter == 298 ||
                                              provider.counter == 297 ||
                                              provider.counter == 296 ||
                                              provider.counter == 295 ||
                                              provider.counter == 294 ||
                                              provider.counter == 293 ||
                                              provider.counter == 292 ||
                                              provider.counter == 291 ||
                                              provider.counter == 290
                                          ? AssetImage(
                                              "assets/images/${provider.result["coin"]}.png")
                                          : AssetImage(
                                              "assets/images/coin.gif")),
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
                              usePadding: provider.head,

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
                              usePadding: provider.tail,

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
                        model.getWalletState();
                        if (!model.status) {
                          print(model.status);
                          print('objectobjectobjectobjectobjectobject');
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
                                  message: "Import Wallet",
                                  width: 195);
                            },

                            ///  color: Colors.grey,
                            text: 'Play',
                          );
                        }
                        if (model.counter <= 60) {
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
                          width: 60.w,
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
                                      maxAmount: coinOddsq[1],
                                      minAmount: coinOddsq[0],
                                      gameType: 'coin',
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
