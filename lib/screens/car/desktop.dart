import 'package:avatar_glow/avatar_glow.dart';

import 'package:contained_tab_bar_view/contained_tab_bar_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:flutter_web3/flutter_web3.dart' as p;
import 'package:lottie/lottie.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:provider/provider.dart';
import 'package:smartbet/screens/car/carhistory/desktop.dart';
import 'package:smartbet/screens/car/mobile.dart';
import 'package:smartbet/screens/car/provider.dart';
import 'package:smartbet/screens/coin/desktop.dart';
import 'package:smartbet/screens/fruit/provider.dart';
import 'package:smartbet/screens/history/components/details.dart';
import 'package:smartbet/screens/history/desktop.dart';
import 'package:smartbet/screens/history/provider.dart';
import 'package:smartbet/services/oddsClient.dart';
import 'package:smartbet/socket/provider.dart';
import 'package:smartbet/utils/config/color.dart';
import 'package:smartbet/utils/config/size.dart';
import 'package:smartbet/utils/helpers.dart';
import 'package:smartbet/utils/style.dart';
import 'package:smartbet/widget/alertSnackBar.dart';
import 'package:smartbet/widget/app_input_field.dart';
import 'package:smartbet/widget/button.dart';
import 'package:smartbet/widget/comingSoon.dart';
import 'package:smartbet/widget/conInput.dart';
import 'package:smartbet/widget/connectWallet.dart';
import 'package:smartbet/widget/customAppBar.dart';
import 'package:smartbet/widget/gameWidget.dart';
import 'package:smartbet/widget/resultWidget.dart';
import 'package:smartbet/widget/stakeContainer.dart';
import 'package:smartbet/widget/walletTabContainer.dart';

import 'package:just_audio/just_audio.dart';

class CarDesktopScreen extends StatefulWidget {
  CarDesktopScreen({super.key, this.directLaunch = false});
  final bool? directLaunch;
  @override
  State<CarDesktopScreen> createState() => _CarDesktopScreenState();
}

class _CarDesktopScreenState extends State<CarDesktopScreen> {
  @override
  Widget build(BuildContext context) {
    if (widget.directLaunch!) {
      return Scaffold(
        backgroundColor: ColorConfig.scaffold,
        appBar: customAppbar(context),
        // body: RowBody(),
        body: SizeConfig.screenWidth! <= 850
            ? _TabletRowBody()
            : _DesktopRowBody(),
      );
    } else {
      return Scaffold(
        backgroundColor: ColorConfig.scaffold,
        body: SizeConfig.screenWidth! <= 850
            ? _TabletRowBody()
            : _DesktopRowBody(),
      );
    }
  }
}

// }
class _TabletRowBody extends StatefulWidget {
  const _TabletRowBody({super.key});

  @override
  State<_TabletRowBody> createState() => __TabletRowBodyState();
}

class __TabletRowBodyState extends State<_TabletRowBody> {
  late Future<List<Odds>> futureOdds;
  late double raceOdds;

  @override
  void initState() {
    super.initState();
    futureOdds = fetchOdds();
    raceOdds = 0.0;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Odds>>(
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
                    id: -1, maxAmount: 0, minAmount: 0, odds: 0, type: 'race'));
            raceOdds = raceOddsData.odds;
            return Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: EdgeInsets.only(left: 20),
                      width: SizeConfigs.getPercentageWidth(97), //650
                      child: Row(
                        children: [
                          Column(
                            children: [
                              CircleAvatar(
                                  radius: 30,
                                  backgroundColor: ColorConfig.appBar,
                                  child: Center(
                                    child: Icon(
                                      Icons.tv,
                                      size: 23,
                                      color: ColorConfig.iconColor,
                                    ),
                                  )),
                              8.height,
                              Text(
                                "Stakes",
                                style: TextStyle(
                                    fontSize: 16.sp,
                                    color: ColorConfig.iconColor,
                                    fontWeight: FontWeight.w500),
                              ),
                            ],
                          ),
                          SizeConfigs.screenWidth <= 562
                              ? SizeConfigs.getPercentageWidth(3).toInt().width
                              : 45.width,
                          Column(
                            children: [
                              CircleAvatar(
                                  radius: 30,
                                  backgroundColor: ColorConfig.appBar,
                                  child: Center(
                                    child: Icon(
                                      Icons.history,
                                      size: 23,
                                      color: ColorConfig.iconColor,
                                    ),
                                  )).onTap(() {
                                CarHistoryScreen().launch(context);
                                // CustomSnackBar(
                                //     context: context,
                                //     message: "Coming Soon!",
                                //     leftColor: ColorConfig.yellow,
                                //     width: 165);
                              }),
                              8.height,
                              GestureDetector(
                                onTap: () {
                                  // navigateToDetails(context, 'race');
                                },
                                child: Text(
                                  "History",
                                  style: TextStyle(
                                    fontSize: 16.sp,
                                    color: ColorConfig.iconColor,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          0.width.expand(),
                          Container(
                            padding: EdgeInsets.only(
                                right: SizeConfigs.screenWidth <= 850 ? 0 : 0),
                            child: Consumer<SocketProvider>(
                              builder: (BuildContext context, provider, _) {
                                return provider.gameHistory.isEmpty
                                    ? Lottie.asset(
                                        "assets/images/beiLoader.json",
                                        height: 80,
                                        width: 80,
                                      )
                                    : Column(
                                        children: [
                                          Row(
                                            children: List.generate(
                                              provider.firstFiveHistory.length,
                                              (index) => resultContainer(
                                                colorImg: true,
                                                color: provider.firstFiveHistory[
                                                                index]["race"]
                                                            .toLowerCase() ==
                                                        "g"
                                                    ? ColorConfig.greenCar
                                                        .withOpacity(0.8)
                                                    : provider.firstFiveHistory[index]
                                                                    ["race"]
                                                                .toLowerCase() ==
                                                            "y"
                                                        ? ColorConfig.yellowCar
                                                        : provider.firstFiveHistory[index]
                                                                        ["race"]
                                                                    .toLowerCase() ==
                                                                'r'
                                                            ? ColorConfig.redCar
                                                                .withOpacity(
                                                                    0.9)
                                                            : ColorConfig
                                                                .blueCar
                                                                .withOpacity(0.8),
                                                img: "assets/images/tesla.png",
                                                height: 50,
                                                width: 50,
                                              ),
                                            ),
                                          ),
                                          Row(
                                            children: List.generate(
                                              provider.lastFiveHistory.length,
                                              (index) => resultContainer(
                                                colorImg: true,
                                                color: provider.lastFiveHistory[
                                                                index]["race"]
                                                            .toLowerCase() ==
                                                        "g"
                                                    ? ColorConfig.greenCar
                                                        .withOpacity(0.8)
                                                    : provider.lastFiveHistory[index]
                                                                    ["race"]
                                                                .toLowerCase() ==
                                                            "y"
                                                        ? ColorConfig.yellowCar
                                                        : provider.lastFiveHistory[index]
                                                                        ["race"]
                                                                    .toLowerCase() ==
                                                                'r'
                                                            ? ColorConfig.redCar
                                                                .withOpacity(
                                                                    0.9)
                                                            : ColorConfig
                                                                .blueCar
                                                                .withOpacity(0.8),
                                                img: "assets/images/tesla.png",
                                                height: 50,
                                                width: 50,
                                              ),
                                            ),
                                          ),
                                        ],
                                      );
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.only(
                          right: SizeConfigs.getPercentageWidth(2)),
                      height: 600,
                      width: SizeConfigs.screenWidth <= 465
                          ? SizeConfigs.getPercentageWidth(94)
                          : SizeConfigs.getPercentageWidth(94),
                      //backgroundColor: Colors.black12,
                      //ColorConfig.appBar.withOpacity(0.1),
                      decoration: BoxDecoration(
                        color: ColorConfig.desktopGameappBar.withOpacity(0.6),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SingleChildScrollView(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Column(
                                  children: [
                                    Container(
                                      color: ColorConfig.appBar,
                                      height: 40,
                                      width: 345,
                                      child: Row(children: [
                                        11.width,
                                        Text(
                                          "Correct Car Wins:",
                                          style: TextStyle(
                                            color: ColorConfig.iconColor,
                                            fontSize: 15.sp,

                                            /// fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                        Container().expand(),
                                        Container(
                                          decoration: BoxDecoration(
                                              color: ColorConfig.yellow),
                                          height: 30,
                                          width: 50,
                                          child: Center(
                                            child: Text(
                                              '$raceOdds'
                                              'x',
                                              // "${oddsProvider.odds.where((odd) => odd.type == 'race').first.odds.toString()}x",
                                              // '3.0x',
                                              style: TextStyle(
                                                color: ColorConfig.black,
                                                fontSize: 15.sp,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ),
                                        ).cornerRadiusWithClipRRect(6),
                                        11.toInt().width,
                                      ]),
                                    ).cornerRadiusWithClipRRect(6),
                                    20.toInt().height,
                                    // 30.toInt().height,
                                    //  50.width,
                                    Column(
                                      children: [
                                        Consumer<SocketProvider>(
                                          builder: (BuildContext context,
                                              provider, _) {
                                            return Container(
                                              decoration: BoxDecoration(
                                                  color: ColorConfig
                                                      .desktopGameappBar),
                                              child: Center(
                                                child: Text(
                                                  "${provider.counter}:00",
                                                  style: TextStyle(
                                                      fontSize: 18.sp,
                                                      color:
                                                          ColorConfig.iconColor,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                              ),
                                            )
                                                .withWidth(65)
                                                .withHeight(35)
                                                .cornerRadiusWithClipRRect(5);
                                          },
                                        ),
                                        //  27.toInt().height,

                                        Stack(
                                          alignment: Alignment.center,
                                          children: [
                                            Container(
                                              width: 410,
                                              //SizeConfig.screenWidth! > 999 ? 410 : 280,
                                              height: 275,
                                            ),
                                            CarGamePlayMode(),
                                            Positioned(
                                                bottom: 189,
                                                // right: 0,
                                                left: 325,
                                                //     bottom: SizeConfigs.getPercentageHeight(2),
                                                child: AvatarGlow(
                                                    endRadius: 45,
                                                    animate: true,
                                                    showTwoGlows: true,
                                                    repeatPauseDuration:
                                                        Duration(
                                                            milliseconds: 100),
                                                    glowColor:
                                                        ColorConfig.iconColor,
                                                    duration: Duration(
                                                        milliseconds: 2000),
                                                    child: CircleAvatar(
                                                        radius: 20,
                                                        backgroundColor:
                                                            ColorConfig.yellow,

                                                        //car music
                                                        child:
                                                            musicgametoggler()))),
                                          ],
                                        ),
                                      ],
                                    ),
                                    Text(
                                      "Select Car",
                                      style: TextStyle(
                                        fontSize: 16.sp,
                                        color: ColorConfig.iconColor,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                    8.toInt().height,
                                    Consumer<CarStateProvider>(
                                      builder:
                                          (BuildContext context, provider, _) {
                                        return Row(
                                          children: [
                                            gameWidget(
                                              //  indexcolor: ,
                                              dym: 70,
                                              ht: 6,
                                              wt: 30,
                                              img: "assets/images/tesla.png",
                                              imgcolor: ColorConfig.greenCar
                                                  .withOpacity(0.8),
                                              colorImg: true,
                                              backgroundCar: true,
                                              currentTab: provider.green,
                                              function: () {
                                                provider.setCurrentTab(
                                                    green: !provider.green,
                                                    red: false,
                                                    yellow: false,
                                                    blue: false);
                                              },
                                            ),
                                            7.width,
                                            gameWidget(
                                              indexcolor:
                                                  ColorConfig.tabincurrentindex,
                                              dym: 70,
                                              ht: 6,
                                              wt: 30,
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
                                            7.width,
                                            gameWidget(
                                              indexcolor:
                                                  ColorConfig.tabincurrentindex,
                                              dym: 70,
                                              ht: 6,
                                              wt: 30,
                                              img: "assets/images/tesla.png",
                                              imgcolor: ColorConfig.redCar
                                                  .withOpacity(0.9),
                                              colorImg: true,
                                              backgroundCar: true,
                                              currentTab: provider.red,
                                              function: () {
                                                provider.setCurrentTab(
                                                    green: false,
                                                    red: !provider.red,
                                                    yellow: false,
                                                    blue: false);
                                              },
                                            ),
                                            7.width,
                                            gameWidget(
                                              indexcolor:
                                                  ColorConfig.tabincurrentindex,
                                              dym: 70,
                                              ht: 6,
                                              wt: 30,
                                              img: "assets/images/tesla.png",
                                              imgcolor: ColorConfig.blueCar
                                                  .withOpacity(0.8),
                                              colorImg: true,
                                              backgroundCar: true,
                                              currentTab: provider.blue,
                                              function: () {
                                                provider.setCurrentTab(
                                                  green: false,
                                                  red: false,
                                                  yellow: false,
                                                  blue: !provider.blue,
                                                );
                                              },
                                            ),
                                          ],
                                        );
                                      },
                                    ),

                                    3.toInt().height,

                                    Consumer<SocketProvider>(builder:
                                        (BuildContext context, model, _) {
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
                                            final gameState =
                                                Provider.of<CarStateProvider>(
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
                                                builder:
                                                    (BuildContext context) {
                                                  return Dialog(
                                                    // shape: CircleBorder(),
                                                    backgroundColor:
                                                        Colors.transparent,
                                                    elevation: 10,
                                                    child: StakeContainer(
                                                      fruit: false,
                                                      car: true,
                                                      coin: false,
                                                      dice: false,
                                                      maxAmount: 300000,
                                                      minAmount: 0.0005,
                                                    ),
                                                  );
                                                },
                                              );
                                            } else {
                                              CustomSnackBar(
                                                  context: context,
                                                  message:
                                                      "Please Select A Car",
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
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    )
                        .cornerRadiusWithClipRRect(18)
                        .paddingTop(15)
                        .paddingRight(SizeConfigs.getPercentageWidth(2))
                        .paddingLeft(SizeConfigs.getPercentageWidth(2)),
                  ],
                )
              ],
            );
          }
        });
  }
}

class _DesktopRowBody extends StatefulWidget {
  const _DesktopRowBody({Key? key}) : super(key: key);

  @override
  __DesktopRowBodyState createState() => __DesktopRowBodyState();
}

class __DesktopRowBodyState extends State<_DesktopRowBody> {
  late Future<List<Odds>> futureOdds;
  late double raceOdds;

  @override
  void initState() {
    super.initState();
    futureOdds = fetchOdds();
    raceOdds = 0.0;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Odds>>(
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
                    id: -1, maxAmount: 0, minAmount: 0, odds: 0, type: 'race'));
            raceOdds = raceOddsData.odds;

            return Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      // color: Colors.amber,
                      padding: EdgeInsets.only(left: 20),
                      width: SizeConfig.screenWidth! < 1000 ? 850 : 1000,

                      child: Row(
                        // mainAxisAlignment: MainAxisAlignment.start,
                        // crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Column(
                          //   children: [
                          //     CircleAvatar(
                          //         radius: 30,
                          //         backgroundColor: ColorConfig.appBar,
                          //         child: Center(
                          //           child: Icon(
                          //             Icons.tv,
                          //             size: 25,
                          //             color: ColorConfig.iconColor,
                          //           ),
                          //         )),
                          //     8.height,
                          //     Text(
                          //       "Stakes",
                          //       style: TextStyle(
                          //           fontSize: 16.sp,
                          //           color: ColorConfig.iconColor,
                          //           fontWeight: FontWeight.w500),
                          //     ),
                          //   ],
                          // ),
                          // 45.width,
                          Column(
                            children: [
                              CircleAvatar(
                                  radius: 30,
                                  backgroundColor: ColorConfig.appBar,
                                  child: Center(
                                    child: Icon(
                                      Icons.history,
                                      size: 25,
                                      color: ColorConfig.iconColor,
                                    ),
                                  )).onTap(() {
                                CarHistoryScreen().launch(context);
                                // CustomSnackBar(
                                //     context: context,
                                //     message: "Coming Soon!",
                                //     leftColor: ColorConfig.yellow,
                                //     width: 165);
                              }),
                              8.height,
                              Text(
                                "History",
                                style: TextStyle(
                                    fontSize: 16.sp,
                                    color: ColorConfig.iconColor,
                                    fontWeight: FontWeight.w500),
                              ),
                            ],
                          ),
                          0.width.expand(),
                          if (SizeConfig.screenWidth! > 850) 0.width.expand(),
                          if (SizeConfig.screenWidth! > 850)
                            Consumer<SocketProvider>(
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
                                              // Container(
                                              //   alignment: AlignmentDirectional.centerEnd,
                                              //   width: 550,
                                              //   child: Icon(Icons.arrow_back),
                                              // ),
                                              Container(
                                                child: Row(
                                                  children: List.generate(
                                                    provider.gameHistory.length,
                                                    (index) => resultContainer(
                                                      colorImg: true,
                                                      color: provider
                                                                  .gameHistory[index]
                                                                      ["race"]
                                                                  .toLowerCase() ==
                                                              "g"
                                                          ? ColorConfig.greenCar
                                                              .withOpacity(0.8)
                                                          : provider.gameHistory[index][
                                                                          "race"]
                                                                      .toLowerCase() ==
                                                                  "y"
                                                              ? ColorConfig
                                                                  .yellowCar
                                                              : provider.gameHistory[index]["race"]
                                                                          .toLowerCase() ==
                                                                      'r'
                                                                  ? ColorConfig
                                                                      .redCar
                                                                      .withOpacity(
                                                                          0.9)
                                                                  : ColorConfig
                                                                      .blueCar
                                                                      .withOpacity(0.8),
                                                      img:
                                                          "assets/images/tesla.png",
                                                      height: 50,
                                                      width: 50,
                                                    ),
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
                              },
                            ),

                          // Positioned(
                          //                 top: 0,
                          //                 right: 0,
                          //                 child: Icon(Icons.arrow_back),
                          //               ),
                        ],
                      ),
                    ),
                    //Main cointianer

                    Container(
                      padding: EdgeInsets.only(right: 10),
                      height: 600,
                      width: SizeConfig.screenWidth! < 1000 ? 850 : 1000,
                      //backgroundColor: Colors.black12,
                      //ColorConfig.appBar.withOpacity(0.1),
                      decoration: BoxDecoration(
                        color: ColorConfig.desktopGameappBar.withOpacity(0.6),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Column(
                                children: [
                                  Container(
                                    color: ColorConfig.appBar,
                                    height: 40,
                                    width: 310,
                                    child: Row(children: [
                                      11.width,
                                      Text(
                                        "Correct Car Wins:",
                                        style: TextStyle(
                                          color: ColorConfig.iconColor,
                                          fontSize: 15.sp,

                                          /// fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                      Container().expand(),
                                      Container(
                                        decoration: BoxDecoration(
                                            color: ColorConfig.yellow),
                                        height: 30,
                                        width: 50,
                                        child: Center(
                                          child: Text(
                                            '$raceOdds'
                                            'x',
                                            style: TextStyle(
                                              color: ColorConfig.black,
                                              fontSize: 15.sp,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ),
                                      ).cornerRadiusWithClipRRect(6),
                                      11.toInt().width,
                                    ]),
                                  ).cornerRadiusWithClipRRect(6),
                                  35.toInt().height,
                                  // 30.toInt().height,
                                  Text(
                                    "Select Car",
                                    style: TextStyle(
                                      fontSize: 16.sp,
                                      color: ColorConfig.iconColor,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  8.toInt().height,
                                  Consumer<CarStateProvider>(
                                    builder:
                                        (BuildContext context, provider, _) {
                                      return Row(
                                        children: [
                                          gameWidget(
                                            //  indexcolor: ,
                                            dym: 70,
                                            ht: 6,
                                            wt: 30,
                                            img: "assets/images/tesla.png",
                                            imgcolor: ColorConfig.greenCar
                                                .withOpacity(0.8),
                                            colorImg: true,
                                            backgroundCar: true,
                                            currentTab: provider.green,
                                            function: () {
                                              provider.setCurrentTab(
                                                  green: !provider.green,
                                                  red: false,
                                                  yellow: false,
                                                  blue: false);
                                            },
                                          ),
                                          7.width,
                                          gameWidget(
                                            indexcolor:
                                                ColorConfig.tabincurrentindex,
                                            dym: 70,
                                            ht: 6,
                                            wt: 30,
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
                                          7.width,
                                          gameWidget(
                                            indexcolor:
                                                ColorConfig.tabincurrentindex,
                                            dym: 70,
                                            ht: 6,
                                            wt: 30,
                                            img: "assets/images/tesla.png",
                                            imgcolor: ColorConfig.redCar
                                                .withOpacity(0.9),
                                            colorImg: true,
                                            backgroundCar: true,
                                            currentTab: provider.red,
                                            function: () {
                                              provider.setCurrentTab(
                                                  green: false,
                                                  red: !provider.red,
                                                  yellow: false,
                                                  blue: false);
                                            },
                                          ),
                                          7.width,
                                          gameWidget(
                                            indexcolor:
                                                ColorConfig.tabincurrentindex,
                                            dym: 70,
                                            ht: 6,
                                            wt: 30,
                                            img: "assets/images/tesla.png",
                                            imgcolor: ColorConfig.blueCar
                                                .withOpacity(0.8),
                                            colorImg: true,
                                            backgroundCar: true,
                                            currentTab: provider.blue,
                                            function: () {
                                              provider.setCurrentTab(
                                                green: false,
                                                red: false,
                                                yellow: false,
                                                blue: !provider.blue,
                                              );
                                            },
                                          ),
                                        ],
                                      );
                                    },
                                  ),

                                  35.toInt().height,

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
                                            final gameState =
                                                Provider.of<CarStateProvider>(
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
                                                builder:
                                                    (BuildContext context) {
                                                  return Dialog(
                                                    // shape: CircleBorder(),
                                                    backgroundColor:
                                                        Colors.transparent,
                                                    elevation: 10,
                                                    child: StakeContainer(
                                                      fruit: false,
                                                      car: true,
                                                      coin: false,
                                                      dice: false,
                                                      maxAmount: 300000,
                                                      minAmount: 0.0005,
                                                    ),
                                                  );
                                                },
                                              );
                                            } else {
                                              CustomSnackBar(
                                                  context: context,
                                                  message:
                                                      "Please Select A Car",
                                                  width: 195);
                                            }

                                            // Add your onPressed logic here

                                            // GestureDetector(
                                            // onTap: () {
                                            // Navigator.of(context)
                                            //     .pop(); // Close the dialog
                                            // },
                                            // );
                                          },
                                          color: ColorConfig.yellow,
                                          textColor: Colors.white,
                                          borderRadius: 5,
                                          height: 24,
                                          width: 60,
                                          size: 16
                                          //  padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 12.0),
                                          );
                                    },
                                  ),
                                ],
                              ),
                              50.width,
                              Column(
                                children: [
                                  Consumer<SocketProvider>(
                                    builder:
                                        (BuildContext context, provider, _) {
                                      return Container(
                                        decoration: BoxDecoration(
                                            color:
                                                ColorConfig.desktopGameappBar),
                                        child: Center(
                                          child: Text(
                                            "${provider.counter}:00",
                                            style: TextStyle(
                                                fontSize: 18.sp,
                                                color: ColorConfig.iconColor,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ),
                                      )
                                          .withWidth(65)
                                          .withHeight(35)
                                          .cornerRadiusWithClipRRect(5);
                                    },
                                  ),
                                  //  27.toInt().height,

                                  Stack(
                                    alignment: Alignment.center,
                                    children: [
                                      Container(
                                        width: 410,
                                        //SizeConfig.screenWidth! > 999 ? 410 : 280,
                                        height: 275,
                                      ),
                                      CarGamePlayMode(),
                                      Positioned(
                                          bottom: 189,
                                          // right: 0,
                                          left: 325,
                                          //     bottom: SizeConfigs.getPercentageHeight(2),
                                          child: AvatarGlow(
                                              endRadius: 45,
                                              animate: true,
                                              showTwoGlows: true,
                                              repeatPauseDuration:
                                                  Duration(milliseconds: 100),
                                              glowColor: ColorConfig.iconColor,
                                              duration:
                                                  Duration(milliseconds: 2000),
                                              child: CircleAvatar(
                                                  radius: 20,
                                                  backgroundColor:
                                                      ColorConfig.yellow,

                                                  //car music
                                                  child: musicgametoggler()))),
                                    ],
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                    ).cornerRadiusWithClipRRect(18).paddingTop(15),
                  ],
                )
              ],
            );
          }
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
                    ? AssetImage("assets/images/${provider.result["race"]}.gif")
                    : AssetImage("assets/images/car.gif")),
          ),
          height: 220,
          width: 340,
        ).cornerRadiusWithClipRRect(5);
      },
    );
  }
}

class musicgametoggler extends StatelessWidget {
  const musicgametoggler({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Center(child: Consumer2<CarStateProvider, FruitStateProvider>(
        builder: (context, carStateProvider, fruitCarProvider, _) {
      return Icon(
        carStateProvider.isPlaying
            ? Icons.volume_up_outlined
            : Icons.volume_off,
        size: 25.0,
        color: Colors.black,
      ).onTap(() {
        fruitCarProvider.togglePlayPauseButton(false, context);
        carStateProvider.togglePlayPauseButton(!carStateProvider.isPlaying);
        carStateProvider.isPlaying
            ? carStateProvider.audioPlayer.play()
            : carStateProvider.audioPlayer.pause();
        carStateProvider.isPlaying
            ? carStateProvider.audioPlayer.setLoopMode(LoopMode.one)
            : carStateProvider.audioPlayer.setLoopMode(LoopMode.off);
      });
    }));
  }
}


// void navigateToDetails(BuildContext context, String endpoint) {
//   Navigator.push(
//     context,
//     MaterialPageRoute(
//       builder: (context) => Details(endpoint: endpoint),
//     ),
//   );
// }
