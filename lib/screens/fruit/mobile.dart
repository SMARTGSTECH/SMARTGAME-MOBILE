import 'package:avatar_glow/avatar_glow.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:just_audio/just_audio.dart';
import 'package:lottie/lottie.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:provider/provider.dart';
import 'package:smartbet/screens/car/provider.dart';
import 'package:smartbet/screens/fruit/fruitHistory/historyMobile.dart';
import 'package:smartbet/screens/fruit/provider.dart';
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

class FruitMobileScreen extends StatefulWidget {
  const FruitMobileScreen({super.key});

  @override
  State<FruitMobileScreen> createState() => _FruitMobileScreenState();
}

class _FruitMobileScreenState extends State<FruitMobileScreen> {
  late Future<List<Odds>> futureOdds;
  late double fruitOdds;

  @override
  void initState() {
    print("initialized");
    super.initState();
    futureOdds = fetchOdds();
    fruitOdds = 0.0;
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
              final fruitOddsData = oddsList.firstWhere(
                  (odd) => odd.type == 'friut',
                  orElse: () => Odds(
                      id: -1,
                      maxAmount: 0,
                      minAmount: 0,
                      odds: 0,
                      type: 'friut'));
              fruitOdds = fruitOddsData.odds;

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
                            ///   finish(context);
                          }),
                          110.w.toInt().width,
                          Text(
                            "FRUITS",
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
                              "Correct Fruit Wins:",
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
                                  "$fruitOdds" "x",
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
                                FruitHistoryMobile(
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
                                                  colorImg: provider
                                                          .firstFiveHistory[
                                                              index]['fruit']
                                                          .toLowerCase() ==
                                                      'p',
                                                  //color: ColorConfig.redCar.withOpacity(0.9),
                                                  img: provider
                                                              .firstFiveHistory[
                                                                  index]
                                                                  ['fruit']
                                                              .toLowerCase() ==
                                                          's'
                                                      ? "assets/images/straw.png"
                                                      : provider.firstFiveHistory[
                                                                      index]
                                                                      ['fruit']
                                                                  .toLowerCase() ==
                                                              'b'
                                                          ? "assets/images/banana.png"
                                                          : provider.firstFiveHistory[
                                                                          index]
                                                                          [
                                                                          'fruit']
                                                                      .toLowerCase() ==
                                                                  'o'
                                                              ? "assets/images/orange.png"
                                                              : "assets/images/pine.png",

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
                                                  colorImg: provider
                                                          .lastFiveHistory[
                                                              index]['fruit']
                                                          .toLowerCase() ==
                                                      'p',
                                                  // if (true) color: Color(0xfffbd604),
                                                  img: provider.lastFiveHistory[
                                                                  index]
                                                                  ['fruit']
                                                              .toLowerCase() ==
                                                          's'
                                                      ? "assets/images/straw.png"
                                                      : provider.lastFiveHistory[
                                                                      index]
                                                                      ['fruit']
                                                                  .toLowerCase() ==
                                                              'b'
                                                          ? "assets/images/banana.png"
                                                          : provider.lastFiveHistory[
                                                                          index]
                                                                          [
                                                                          'fruit']
                                                                      .toLowerCase() ==
                                                                  'o'
                                                              ? "assets/images/orange.png"
                                                              : "assets/images/pine.png",
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
                                FruitHistoryMobile(
                                  isStake: true,
                                ).launch(context);
                                // CustomSnackBar(
                                //     context: context,
                                //     message: "Coming Soon!",
                                //     leftColor: ColorConfig.yellow,
                                //     width: 165);
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
                                    fontWeight: FontWeight.bold),
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
                      10.h.toInt().height,

                      Stack(
                        alignment: Alignment.center,
                        children: [
                          Container(
                            //  color: ColorConfig.coindollars,
                            width: double.infinity,
                            height: 250.h,
                          ),

                          //GameplayMode
                          MobileFruitGamePlay(),
                          // Container(
                          //   decoration: BoxDecoration(
                          //     // color: Colors.deepOrangeAccent,
                          //     border:
                          //         Border.all(color: ColorConfig.lightBoarder),
                          //     image: DecorationImage(
                          //         //  opacity: 0.5,
                          //         fit: BoxFit.cover,
                          //         image:
                          //             AssetImage("assets/images/847myv.gif")),
                          //   ),
                          //   height: 200.h,
                          //   width: 300.w,
                          // ).cornerRadiusWithClipRRect(5.r),
                          //gameplaymode

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
                                      child: FruitGameMusicToggler()))),
                        ],
                      ),

                      Consumer<FruitStateProvider>(
                          builder: (BuildContext context, provider, _) {
                        return Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            gameWidget(
                              //  indexcolor: ColorConfig.tabincurrentindex,

                              dym: 70.h,
                              ht: 3.h,
                              wt: 30.w,
                              spacer: 8,
                              img: "assets/images/pine.png",
                              imgcolor: Color(0xfffbd604),
                              colorImg: true,
                              backgroundCar: true,
                              currentTab: provider.pineapple,
                              isMobileScreen: true,
                              function: () {
                                provider.setCurrentTab(
                                    pine: !provider.pineapple,
                                    orange: false,
                                    banana: false,
                                    straw: false);
                              },
                            ),
                            gameWidget(
                              //  indexcolor: ColorConfig.tabincurrentindex,
                              dym: 70.h,
                              ht: 3.h,
                              spacer: 8,
                              wt: 30.w,
                              img: "assets/images/orange.png",
                              imgcolor: ColorConfig.yellowCar,
                              isMobileScreen: true,
                              // colorImg: true,
                              backgroundCar: true,
                              currentTab: provider.orange,
                              function: () {
                                provider.setCurrentTab(
                                    pine: false,
                                    orange: !provider.orange,
                                    banana: false,
                                    straw: false);
                              },
                            ),
                            gameWidget(
                              //  indexcolor: ColorConfig.tabincurrentindex,
                              dym: 70.h,
                              ht: 3.h,
                              wt: 30.w,
                              spacer: 8,
                              img: "assets/images/banana.png",

                              // colorImg: true,
                              backgroundCar: true,
                              isMobileScreen: true,
                              currentTab: provider.banana,
                              function: () {
                                provider.setCurrentTab(
                                    pine: false,
                                    orange: false,
                                    banana: !provider.banana,
                                    straw: false);
                              },
                            ),
                            gameWidget(
                              // indexcolor: ColorConfig.tabincurrentindex,
                              dym: 70.h,
                              ht: 3.h,
                              spacer: 8,
                              wt: 30.w,
                              img: "assets/images/straw.png",
                              imgcolor: ColorConfig.blueCar.withOpacity(0.8),
                              currentTab: provider.starwberry,
                              isMobileScreen: true,
                              function: () {
                                provider.setCurrentTab(
                                    pine: false,
                                    orange: false,
                                    banana: false,
                                    straw: !provider.starwberry);
                              },
                              backgroundCar: true,
                            ),
                          ],
                        ).paddingSymmetric(horizontal: 40.w);
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
                          color: ColorConfig.yellow,
                          textColor: Colors.white,
                          borderRadius: 4.r,
                          height: 22.h,
                          width: 60.w,
                          size: 14,
                          onPressed: () {
                            final gameState = Provider.of<FruitStateProvider>(
                                context,
                                listen: false);

                            if (gameState.pineapple ||
                                gameState.orange ||
                                gameState.banana ||
                                gameState.starwberry) {
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
                                      fruit: true,
                                      car: false,
                                      coin: false,
                                      dice: false,
                                      maxAmount: 0.0009876,
                                      minAmount: 0.000012,
                                    ),
                                  );
                                },
                              );
                            } else {
                              CustomSnackBar(
                                  context: context,
                                  message: "Please Select A Fruit",
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

class FruitGameMusicToggler extends StatelessWidget {
  const FruitGameMusicToggler({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Center(child: Consumer2<FruitStateProvider, CarStateProvider>(
        builder: (context, fruitStateProvider, carStateProvider, _) {
      return Icon(
        fruitStateProvider.isPlaying
            ? Icons.volume_up_outlined
            : Icons.volume_off,
        size: 25.0,
        color: Colors.black,
      ).onTap(() {
        carStateProvider.togglePlayPauseButton(false);
        fruitStateProvider.togglePlayPauseButton(
            !fruitStateProvider.isPlaying, context);
        fruitStateProvider.isPlaying
            ? fruitStateProvider.audioPlayer.play()
            : fruitStateProvider.audioPlayer.pause();
        fruitStateProvider.isPlaying
            ? fruitStateProvider.audioPlayer.setLoopMode(LoopMode.one)
            : fruitStateProvider.audioPlayer.setLoopMode(LoopMode.off);
      });
    }));
  }
}

class fruitWidget extends StatelessWidget {
  const fruitWidget({
    super.key,
    required this.carcolor,
    required this.indexcolor,
    required this.img,
    this.currentTab = false,
    this.function,
  });
  final Color carcolor;
  final Color indexcolor;
  final String img;
  final bool currentTab;

  final VoidCallback? function;

  @override
  Widget build(BuildContext context) {
    return img == "assets/images/orange.png"
        ? Consumer<FruitStateProvider>(
            builder: (BuildContext context, provider, _) {
            return Column(
              children: [
                Image.asset(
                  img,
                  color: carcolor,
                  height: 68,
                  // width: 100,
                ),
                6.h.toInt().height,
                Container(
                  decoration: BoxDecoration(color: indexcolor),
                  height: 3.h,
                  width: 30.h,
                ).cornerRadiusWithClipRRect(20.r),
              ],
            );
          })
        : Column(
            children: [
              Image.asset(
                img,
                color: carcolor,
                // height: 51.h,
                // width: 100,
              ),
              9.h.toInt().height,
              Container(
                decoration: BoxDecoration(color: indexcolor),
                height: 3.h,
                width: 30.h,
              ).onTap(() {
                function!();
              }).cornerRadiusWithClipRRect(20.r)
            ],
          );
  }
}

class MobileFruitGamePlay extends StatelessWidget {
  const MobileFruitGamePlay({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Consumer2<SocketProvider, FruitStateProvider>(
      builder: (BuildContext context, provider, fruit, _) {
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
                    ? provider.result["fruit"] != null
                        ? AssetImage(
                            "assets/images/${provider.result["fruit"].toLowerCase()}.gif")
                        : const AssetImage("assets/images/fruits.png")
                    : const AssetImage("assets/images/847myv.gif")),
          ),
          height: 200.h,
          width: 300.w,
        ).cornerRadiusWithClipRRect(5);
      },
    );
  }
}
