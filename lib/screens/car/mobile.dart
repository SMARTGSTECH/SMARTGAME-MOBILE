import 'package:avatar_glow/avatar_glow.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:just_audio/just_audio.dart';
import 'package:lottie/lottie.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:provider/provider.dart';
import 'package:smartbet/screens/car/carhistory/historyMobile.dart';
import 'package:smartbet/screens/history/desktop.dart';
import 'package:smartbet/screens/history/mobile.dart';
import 'package:smartbet/services/oddsClient.dart';
import 'package:smartbet/socket/provider.dart';
import 'package:smartbet/utils/config/color.dart';
import 'package:smartbet/utils/config/size.dart';
import 'package:smartbet/widget/alertSnackBar.dart';
import 'package:smartbet/widget/button.dart';
import 'package:smartbet/screens/car/provider.dart';
import 'package:smartbet/widget/customAppBar.dart';
import 'package:smartbet/widget/gameWidget.dart';
import 'package:smartbet/widget/resultWidget.dart';
import 'package:smartbet/widget/stakeContainer.dart';
import 'package:smartbet/screens/car/provider.dart';

class CarMobileScreen extends StatefulWidget {
  const CarMobileScreen({super.key});

  @override
  State<CarMobileScreen> createState() => _CarMobileScreenState();
}

class _CarMobileScreenState extends State<CarMobileScreen> {
  late Future<List<Odds>> futureOdds;
  late List raceOdds;

  @override
  void initState() {
    print("initialized");
    super.initState();
    futureOdds = fetchOdds();
    // raceOdds = 0.0;
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
              final raceOddsData = oddsList.firstWhere(
                  (odd) => odd.type == 'race',
                  orElse: () => Odds(
                      id: -1,
                      maxAmount: 0,
                      minAmount: 0,
                      odds: 0,
                      type: 'race'));
              raceOdds = [
                raceOddsData.minAmount,
                raceOddsData.maxAmount,
                raceOddsData.odds
              ];
              print('THIS IS THE EXPERIENCESS');
              print(raceOdds);
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
                            //   finish(context);
                          }),
                          100.w.toInt().width,
                          Text(
                            "CAR RACING",
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
                              "Correct Car Wins:",
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
                                  "${raceOdds[2]}" 'x',
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
                                CarHistoryMobile(
                                  isStake: false,
                                ).launch(context);
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
                            //     provider.counter == 49 ||
                            // provider.counter == 48 ||
                            // provider.counter == 47 ||
                            // provider.counter == 46
                            // color: Colors.amber,

                            // padding: EdgeInsetsDirectional.symmetric(horizontal: 85.w),
                            child: Consumer<SocketProvider>(
                                builder: (BuildContext context, provider, _) {
                              return provider.gameHistory.isEmpty
                                  ? Lottie.asset(
                                      "assets/images/beiLoader.json",
                                      height: 60,
                                      width: 60,
                                    )
                                  : provider.counter <= 45
                                      ? Column(
                                          children: [
                                            // First Row

                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: List.generate(
                                                  provider
                                                      .firstFiveHistory.length,
                                                  (index) => resultContainer(
                                                        colorImg: true,
                                                        color: provider
                                                                    .firstFiveHistory[index]
                                                                        ["race"]
                                                                    .toLowerCase() ==
                                                                "g"
                                                            ? ColorConfig
                                                                .greenCar
                                                                .withOpacity(
                                                                    0.8)
                                                            : provider.firstFiveHistory[index]["race"]
                                                                        .toLowerCase() ==
                                                                    "y"
                                                                ? ColorConfig
                                                                    .yellowCar
                                                                : provider.firstFiveHistory[index]["race"]
                                                                            .toLowerCase() ==
                                                                        'r'
                                                                    ? ColorConfig
                                                                        .redCar
                                                                        .withOpacity(
                                                                            0.9)
                                                                    : ColorConfig
                                                                        .blueCar
                                                                        .withOpacity(
                                                                            0.8),
                                                        img:
                                                            "assets/images/tesla.png",
                                                        height: 40,
                                                        width: 40,
                                                      )),
                                            ),
                                            // Second Row
                                            8.height,

                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: List.generate(
                                                  provider
                                                      .lastFiveHistory.length,
                                                  (index) => resultContainer(
                                                        colorImg: true,
                                                        color: provider
                                                                    .lastFiveHistory[index]
                                                                        ["race"]
                                                                    .toLowerCase() ==
                                                                "g"
                                                            ? ColorConfig
                                                                .greenCar
                                                                .withOpacity(
                                                                    0.8)
                                                            : provider.lastFiveHistory[index]["race"]
                                                                        .toLowerCase() ==
                                                                    "y"
                                                                ? ColorConfig
                                                                    .yellowCar
                                                                : provider.lastFiveHistory[index]["race"]
                                                                            .toLowerCase() ==
                                                                        'r'
                                                                    ? ColorConfig
                                                                        .redCar
                                                                        .withOpacity(
                                                                            0.9)
                                                                    : ColorConfig
                                                                        .blueCar
                                                                        .withOpacity(
                                                                            0.8),
                                                        img:
                                                            "assets/images/tesla.png",
                                                        height: 40,
                                                        width: 40,
                                                      )),
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
                                CarHistoryMobile(
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
                      //  Consumer<SocketProvider>(
                      //     builder: (BuildContext context, provider, _) {
                      //       return Container(
                      //         decoration: BoxDecoration(
                      //             color: ColorConfig.appBar),
                      //         child: Center(
                      //           child: Text(
                      //             "${provider.counter}:00",
                      //             style: TextStyle(
                      //                 fontSize: 16.sp,
                      //                 color: ColorConfig.iconColor,
                      //                 fontWeight: FontWeight.bold),
                      //           ),
                      //         ),
                      //       )
                      //             .withWidth(60.w)
                      //       .withHeight(30.h)
                      //       .cornerRadiusWithClipRRect(5.r);
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
                      // })

                      Stack(
                        alignment: Alignment.center,
                        children: [
                          Container(
                            //  color: ColorConfig.coindollars,
                            width: double.infinity,
                            height: 250.h,
                          ),

                          CarGamePlayMode(),

                          // Container(
                          //   decoration: BoxDecoration(
                          //     // color: Colors.deepOrangeAccent,
                          //     border: Border.all(color: ColorConfig.lightBoarder),
                          //     image: DecorationImage(
                          //         //  opacity: 0.5,
                          //         fit: BoxFit.fill,
                          //         image: AssetImage("assets/images/car.gif")),
                          //   ),
                          //   height: 200.h,
                          //   width: 300.w,
                          // ).cornerRadiusWithClipRRect(5.r),

                          Positioned(
                              bottom: 175.h,
                              right: 0,
                              left: 275.w,
                              //     bottom: SizeConfigs.getPercentageHeight(2),
                              child: AvatarGlow(
                                  endRadius: 45.r,
                                  animate: true,
                                  showTwoGlows: true,
                                  repeatPauseDuration:
                                      Duration(milliseconds: 100),
                                  glowColor: ColorConfig.iconColor,
                                  duration: Duration(milliseconds: 2000),
                                  child: CircleAvatar(
                                      radius: 20.r,
                                      backgroundColor: ColorConfig.yellow,
                                      child: CarGameMusicToggler()))),
                        ],
                      ),

                      Consumer<CarStateProvider>(
                          builder: (BuildContext context, provider, _) {
                        return Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            gameWidget(
                              indexcolor: ColorConfig.tabincurrentindex,
                              dym: 70,
                              ht: 3.h,
                              wt: 30.h,
                              isMobileScreen: true,
                              img: "assets/images/tesla.png",
                              imgcolor: ColorConfig.greenCar,
                              colorImg: true,
                              backgroundCar: true,
                              currentTab: provider.green,
                              function: () {
                                provider.setCurrentTab(
                                    yellow: false,
                                    red: false,
                                    green: !provider.green,
                                    blue: false);
                              },
                            ),
                            gameWidget(
                              indexcolor: ColorConfig.tabincurrentindex,
                              dym: 70,
                              ht: 3.h,
                              wt: 30.h,
                              isMobileScreen: true,
                              img: "assets/images/tesla.png",
                              imgcolor: ColorConfig.yellowCar,
                              colorImg: true,
                              backgroundCar: true,
                              currentTab: provider.yellow,
                              function: () {
                                provider.setCurrentTab(
                                    green: false,
                                    red: false,
                                    yellow: !provider.yellow,
                                    blue: false);
                              },
                            ),
                            gameWidget(
                              indexcolor: ColorConfig.tabincurrentindex,
                              dym: 70,
                              ht: 3.h,
                              wt: 30.h,
                              isMobileScreen: true,
                              img: "assets/images/tesla.png",
                              imgcolor: ColorConfig.redCar,
                              colorImg: true,
                              backgroundCar: true,
                              currentTab: provider.red,
                              function: () {
                                provider.setCurrentTab(
                                    green: false,
                                    yellow: false,
                                    red: !provider.red,
                                    blue: false);
                              },
                            ),
                            gameWidget(
                              indexcolor: ColorConfig.tabincurrentindex,
                              dym: 70,
                              ht: 3.h,
                              wt: 30.h,
                              isMobileScreen: true,
                              img: "assets/images/tesla.png",
                              imgcolor: ColorConfig.blueCar,
                              colorImg: true,
                              backgroundCar: true,
                              currentTab: provider.blue,
                              function: () {
                                provider.setCurrentTab(
                                    green: false,
                                    red: false,
                                    blue: !provider.blue,
                                    yellow: false);
                              },
                            ),
                          ],
                        ).paddingSymmetric(horizontal: 50.w);
                      }),
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
                              final gameState = Provider.of<CarStateProvider>(
                                  context,
                                  listen: false);

                              if (gameState.blue ||
                                  gameState.green ||
                                  gameState.red ||
                                  gameState.yellow) {
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
                                        car: true,
                                        coin: false,
                                        dice: false,
                                        maxAmount: raceOdds[1],
                                        minAmount: raceOdds[0],
                                        gameType: 'car',
                                      ),
                                    );
                                  },
                                );
                              } else {
                                CustomSnackBar(
                                    context: context,
                                    message: "Please Select A Car",
                                    width: 195);
                              }

                              // Add your onPressed logic here
                            },
                            color: ColorConfig.yellow,
                            textColor: Colors.white,
                            borderRadius: 5,
                            height: 24,
                            width: 60,
                            size: 16
                            //  padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 12.0),
                            );
                      }),

                      // Text(
                      //   "Select Car",
                      //   style: TextStyle(
                      //     fontSize: 13.sp,
                      //     color: ColorConfig.iconColor,
                      //   ),
                      // ),
                      // 15.h.toInt().height,

                      // C ustomButtonDesktop(
                      //   text: 'Stake',
                      //   shimmer: true,
                      //   onPressed: () {
                      //     // Add your onPressed logic here
                      //   },
                      //   color: ColorConfig.yellow,
                      //   textColor: Colors.white,
                      //   borderRadius: 4.r,
                      //   height: 22.h,
                      //   width: 55.w,
                      //   size: 14,
                      //   //  padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 12.0),
                      // ),

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

class CarGameMusicToggler extends StatelessWidget {
  const CarGameMusicToggler({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Center(child: Consumer<CarStateProvider>(
      builder: (context, carStateProvider, _) {
        return Icon(
          carStateProvider.isPlaying
              ? Icons.volume_up_outlined
              : Icons.volume_off,
          size: 25.0,
          color: Colors.black,
        ).onTap(() {
          carStateProvider.togglePlayPauseButton(!carStateProvider.isPlaying);
          carStateProvider.isPlaying
              ? carStateProvider.audioPlayer.play()
              : carStateProvider.audioPlayer.pause();
          carStateProvider.isPlaying
              ? carStateProvider.audioPlayer.setLoopMode(LoopMode.one)
              : carStateProvider.audioPlayer.setLoopMode(LoopMode.off);
        });
      },
    ));
  }
}

class carWidget extends StatelessWidget {
  const carWidget({
    super.key,
    required this.carcolor,
    required this.indexcolor,
    required currentTab,
  });
  final Color carcolor;
  final Color indexcolor;

  @override
  Widget build(BuildContext context) {
    return Consumer<CarStateProvider>(
        builder: (BuildContext context, provider, _) {
      return Column(
        children: [
          Image.asset(
            "assets/images/tesla.png",
            color: carcolor,
            // width: 100,
          ),
          1.h.toInt().height,
          Container(
            decoration: BoxDecoration(color: indexcolor),
            height: 3.h,
            width: 30.h,
          ).cornerRadiusWithClipRRect(20.r),
        ],
      );
    });
  }
}

class CarGamePlayMode extends StatelessWidget {
  const CarGamePlayMode({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Consumer<SocketProvider>(
      builder: (BuildContext context, provider, _) {
        return Container(
          decoration: BoxDecoration(
            // color: Colors.deepOrangeAccent,
            border: Border.all(color: ColorConfig.lightBoarder),
            image: DecorationImage(
                //  opacity: 0.5,
                fit: BoxFit.fill,
                image: provider.counter == 49 ||
                        provider.counter == 48 ||
                        provider.counter == 47 ||
                        provider.counter == 46
                    ? AssetImage(provider.result["race"].toLowerCase() == "b"
                        ? "assets/images/bluegif.gif"
                        : "assets/images/${provider.result["race"]}.gif")
                    : AssetImage("assets/images/car.gif")),
          ),
          height: 200.h,
          width: 300.w,
        ).cornerRadiusWithClipRRect(5.r);
      },
    );
  }
}
