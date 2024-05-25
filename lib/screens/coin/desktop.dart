import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:provider/provider.dart';
import 'package:smartbet/screens/coin/coinhistory/desktop.dart';
import 'package:smartbet/screens/coin/provider.dart';
import 'package:smartbet/screens/history/desktop.dart';
import 'package:smartbet/services/oddsClient.dart';
import 'package:smartbet/socket/provider.dart';
import 'package:smartbet/utils/config/color.dart';
import 'package:smartbet/utils/config/size.dart';
import 'package:smartbet/widget/alertSnackBar.dart';
import 'package:smartbet/widget/button.dart';
import 'package:smartbet/widget/customAppBar.dart';
import 'package:smartbet/widget/gameWidget.dart';
import 'package:smartbet/widget/resultWidget.dart';
import 'package:smartbet/widget/stakeContainer.dart';

class CoinDesktopScreen extends StatefulWidget {
  const CoinDesktopScreen({super.key, this.directLaunch = false});
  final bool? directLaunch;

  @override
  State<CoinDesktopScreen> createState() => _CoinDesktopScreenState();
}

class _CoinDesktopScreenState extends State<CoinDesktopScreen> {
  @override
  Widget build(BuildContext context) {
    if (widget.directLaunch!) {
      return Scaffold(
        appBar: customAppbar(context),
        backgroundColor: ColorConfig.scaffold,
        body: SizeConfig.screenWidth! <= 850
            ? coinTabletBody()
            : coinDesktopBody(),
      );
    } else {
      return Scaffold(
        backgroundColor: ColorConfig.scaffold,
        body: SizeConfig.screenWidth! <= 850
            ? coinTabletBody()
            : coinDesktopBody(),
      );
    }
  }
}

class coinTabletBody extends StatefulWidget {
  const coinTabletBody({super.key});

  @override
  State<coinTabletBody> createState() => _coinTabletBodyState();
}

class _coinTabletBodyState extends State<coinTabletBody> {
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
            final coinOddsData = oddsList.firstWhere(
                (odd) => odd.type == 'coin',
                orElse: () => Odds(
                    id: -1, maxAmount: 0, minAmount: 0, odds: 0, type: 'coin'));
            coinOdds = coinOddsData.odds;

            return Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      // color: Colors.amber,
                      width: SizeConfigs.getPercentageWidth(97),
                      child: Row(
                        // mainAxisAlignment: MainAxisAlignment.start,
                        // crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Column(
                            children: [
                              CircleAvatar(
                                  radius: 30,
                                  backgroundColor: ColorConfig.appBar,
                                  child: Center(
                                    child: Icon(
                                      Icons.tv,
                                      size: 25,
                                      color: ColorConfig.iconColor,
                                    ),
                                  )).onTap(() {
                                CoinHistoryScreen().launch(context);
                                // CustomSnackBar(
                                //     context: context,
                                //     message: "Coming Soon!",
                                //     leftColor: ColorConfig.yellow,
                                //     width: 165);
                              }),
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
                                      size: 25,
                                      color: ColorConfig.iconColor,
                                    ),
                                  )).onTap(() {
                                CustomSnackBar(
                                    context: context,
                                    message: "Coming Soon!",
                                    leftColor: ColorConfig.yellow,
                                    width: 165);
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
                          Container(
                            padding: EdgeInsets.only(
                                right: SizeConfigs.screenWidth <= 717 ? 0 : 0),
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
                                              // colorImg: true,
                                              // color: Color(0xffc89e3c),
                                              height: 40,
                                              width: 50,
                                              img: provider.firstFiveHistory[
                                                              index]['coin']
                                                          .toLowerCase() ==
                                                      'head'
                                                  ? "assets/images/H.png"
                                                  : 'assets/images/T.png',
                                            ),
                                          ),
                                        ),
                                        Row(
                                          children: List.generate(
                                            provider.lastFiveHistory.length,
                                            (index) => resultContainer(
                                              // colorImg: true,
                                              // color: Color(0xffc89e3c),
                                              height: 50,
                                              width: 50,
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
                                    );
                            }),
                          )
                        ],
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.only(
                          right: SizeConfigs.getPercentageWidth(2), top: 20),
                      height: 600,
                      width: SizeConfigs.screenWidth <= 465
                          ? SizeConfigs.getPercentageWidth(98)
                          : SizeConfigs.getPercentageWidth(98),
                      //backgroundColor: Colors.black12,
                      //ColorConfig.appBar.withOpacity(0.1),
                      decoration: BoxDecoration(
                        color: ColorConfig.desktopGameappBar.withOpacity(0.6),
                      ),
                      child: SingleChildScrollView(
                        scrollDirection: Axis.vertical,
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
                                          "Correct Side Wins:",
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
                                              "$coinOdds" "x",
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
                                    18.toInt().height,
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
                                        18.toInt().height,
                                        Consumer<SocketProvider>(
                                          builder: (BuildContext context,
                                              provider, _) {
                                            return Container(
                                              padding: EdgeInsets.symmetric(
                                                  vertical: 10.h,
                                                  horizontal: 20.w),
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(20.r),
                                                // color: Colors.deepOrangeAccent,
                                                border: Border.all(
                                                    color: ColorConfig
                                                        .lightBoarder),
                                              ),
                                              height: 180,
                                              width: 180,
                                              child: Container(
                                                decoration: BoxDecoration(
                                                  image: DecorationImage(
                                                      //  opacity: 0.5,
                                                      fit: BoxFit.fill,
                                                      image: provider
                                                                      .counter ==
                                                                  49 ||
                                                              provider.counter ==
                                                                  48 ||
                                                              provider.counter ==
                                                                  47 ||
                                                              provider.counter ==
                                                                  46
                                                          ? AssetImage(
                                                              "assets/images/${provider.result["coin"]}.png")
                                                          : AssetImage(
                                                              "assets/images/coin.gif")),
                                                ),
                                              ),
                                            );
                                          },
                                        ),
                                        30.toInt().height,
                                        Text(
                                          "Select Side",
                                          style: TextStyle(
                                            fontSize: 15.sp,
                                            color: ColorConfig.iconColor,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                        5.toInt().height,
                                        Consumer<CoinStateProvider>(
                                          builder: (BuildContext context,
                                              provider, _) {
                                            return Row(
                                              children: [
                                                gameWidget(
                                                  /// indexcolor: ColorConfig.tabincurrentindex,
                                                  backgroundCar: true,
                                                  dym: 60,
                                                  dymW: 15,
                                                  //   dymW: 15,
                                                  ht: 6,
                                                  wt: 30,
                                                  img: "assets/images/H.png",
                                                  currentTab: provider.head,
                                                  function: () {
                                                    provider.setCurrentTab(
                                                      head: !provider.head,
                                                      tail: false,
                                                    );
                                                  },
                                                ),
                                                30.width,
                                                gameWidget(
                                                  backgroundCar: true,
                                                  // indexcolor: ColorConfig.yellow,
                                                  dym: 60,
                                                  dymW: 15,
                                                  ht: 6,
                                                  wt: 30,
                                                  //  newContainer: true,
                                                  img: "assets/images/T.png",
                                                  currentTab: provider.tail,
                                                  function: () {
                                                    provider.setCurrentTab(
                                                      head: false,
                                                      tail: !provider.tail,
                                                    );
                                                  },
                                                ),
                                              ],
                                            );
                                          },
                                        ),
                                        20.toInt().height,
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
                                                    message:
                                                        "Game Session Ended!",
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
                                                final gameState = Provider.of<
                                                        CoinStateProvider>(
                                                    context,
                                                    listen: false);

                                                if (gameState.head ||
                                                    gameState.tail) {
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
                                                      message:
                                                          "Please Select A Coin Side",
                                                      width: 230);
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
                              ],
                            ),
                          ],
                        ),
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

class coinDesktopBody extends StatefulWidget {
  const coinDesktopBody({super.key});

  @override
  State<coinDesktopBody> createState() => _coinDesktopBodyState();
}

class _coinDesktopBodyState extends State<coinDesktopBody> {
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
            final coinOddsData = oddsList.firstWhere(
                (odd) => odd.type == 'coin',
                orElse: () => Odds(
                    id: -1, maxAmount: 0, minAmount: 0, odds: 0, type: 'coin'));
            coinOdds = coinOddsData.odds;

            return Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      // color: Colors.amber,
                      width: SizeConfig.screenWidth! < 1000 ? 850 : 1000,
                      child: SingleChildScrollView(
                        child: Row(
                          // mainAxisAlignment: MainAxisAlignment.start,
                          // crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
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
                                  // CarHistory().launch(context);
                                  CoinHistoryScreen().launch(context);

                                  //       CustomSnackBar(
                                  // context: context,
                                  // message: "Coming Soon!",
                                  // leftColor: ColorConfig.yellow,
                                  // width: 165);
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
                            Consumer<SocketProvider>(
                                builder: (BuildContext context, provider, _) {
                              return provider.gameHistory.isEmpty
                                  ? Lottie.asset(
                                      "assets/images/beiLoader.json",
                                      height: 80,
                                      width: 80,
                                    )
                                  : provider.counter <= 45
                                      ? Column(children: [
                                          Container(
                                            child: Row(
                                              children: List.generate(
                                                provider.gameHistory.length,
                                                (index) => resultContainer(
                                                  // colorImg: true,
                                                  // color: Color(0xffc89e3c),
                                                  height: 50,
                                                  width: 50,
                                                  img: provider.gameHistory[
                                                                  index]['coin']
                                                              .toLowerCase() ==
                                                          'head'
                                                      ? "assets/images/H.png"
                                                      : 'assets/images/T.png',
                                                ),
                                              ),
                                            ),
                                          ),
                                        ])
                                      : Lottie.asset(
                                          "assets/images/beiLoader.json",
                                          height: 60,
                                          width: 60,
                                        );
                            }),
                          ],
                        ),
                      ),
                    ),
                    Container(
                      height: 600, // currentTab: provider.head,
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
                                        "Correct Side Wins:",
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
                                            "$coinOdds" "x",
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
                                  18.toInt().height,
                                  Text(
                                    "Select Side",
                                    style: TextStyle(
                                      fontSize: 15.sp,
                                      color: ColorConfig.iconColor,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  Consumer<CoinStateProvider>(
                                    builder:
                                        (BuildContext context, provider, _) {
                                      return Row(
                                        children: [
                                          gameWidget(
                                            /// indexcolor: ColorConfig.tabincurrentindex,
                                            backgroundCar: true,
                                            dym: 120,
                                            dymW: 15,
                                            //   dymW: 15,
                                            ht: 6,
                                            wt: 30,
                                            img: "assets/images/H.png",
                                            currentTab: provider.head,
                                            function: () {
                                              provider.setCurrentTab(
                                                head: !provider.head,
                                                tail: false,
                                              );
                                            },
                                          ),
                                          30.width,
                                          gameWidget(
                                            backgroundCar: true,
                                            // indexcolor: ColorConfig.yellow,
                                            dym: 120,
                                            dymW: 15,
                                            ht: 6,
                                            wt: 30,
                                            //  newContainer: true,
                                            img: "assets/images/T.png",
                                            currentTab: provider.tail,
                                            function: () {
                                              provider.setCurrentTab(
                                                head: false,
                                                tail: !provider.tail,
                                              );
                                            },
                                          ),
                                        ],
                                      );
                                    },
                                  ),
                                  20.toInt().height,
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
                                              Provider.of<CoinStateProvider>(
                                                  context,
                                                  listen: false);

                                          if (gameState.head ||
                                              gameState.tail) {
                                            showDialog(
                                              useRootNavigator: false,
                                              barrierDismissible: true,
                                              context: context,
                                              builder: (BuildContext context) {
                                                return Dialog(
                                                  // shape: CircleBorder(),
                                                  backgroundColor:
                                                      Colors.transparent,
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
                                                message:
                                                    "Please Select A Coin Side",
                                                width: 230);
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
                              100.width,
                              Column(
                                children: [
                                  5.height,
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
                                  25.toInt().height,
                                  Consumer<SocketProvider>(
                                    builder:
                                        (BuildContext context, provider, _) {
                                      return Container(
                                        padding: EdgeInsets.symmetric(
                                            vertical: 10.h, horizontal: 20.w),
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(20.r),
                                          // color: Colors.deepOrangeAccent,
                                          border: Border.all(
                                              color: ColorConfig.lightBoarder),
                                        ),
                                        height: 180,
                                        width: 180,
                                        child: Container(
                                          decoration: BoxDecoration(
                                            image: DecorationImage(
                                                //  opacity: 0.5,
                                                fit: BoxFit.fill,
                                                image: provider.counter == 49 ||
                                                        provider.counter ==
                                                            48 ||
                                                        provider.counter ==
                                                            47 ||
                                                        provider.counter == 46
                                                    ? AssetImage(
                                                        "assets/images/${provider.result["coin"]}.png")
                                                    : AssetImage(
                                                        "assets/images/coin.gif")),
                                          ),
                                        ),
                                      );
                                    },
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
