import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:provider/provider.dart';
import 'package:smartbet/screens/dice/dicehistory/desktop.dart';
import 'package:smartbet/screens/dice/provider.dart';
import 'package:smartbet/screens/history/desktop.dart';
import 'package:smartbet/services/oddsClient.dart';
import 'package:smartbet/socket/provider.dart';
import 'package:smartbet/utils/config/color.dart';
import 'package:smartbet/utils/config/size.dart';
import 'package:smartbet/widget/alertSnackBar.dart';
import 'package:smartbet/widget/button.dart';
import 'package:smartbet/widget/connectWallet.dart';
import 'package:smartbet/widget/gameWidget.dart';
import 'package:smartbet/widget/resultWidget.dart';
import 'package:smartbet/widget/stakeContainer.dart';

class DiceDesktopScreen extends StatefulWidget {
  const DiceDesktopScreen({super.key, this.directLaunch = false});
  final bool? directLaunch;
  @override
  State<DiceDesktopScreen> createState() => _DiceDesktopScreenState();
}

class _DiceDesktopScreenState extends State<DiceDesktopScreen> {
  @override
  Widget build(BuildContext context) {
    if (widget.directLaunch!) {
      return Scaffold(
        backgroundColor: ColorConfig.scaffold,
        appBar: AppBar(
          actions: [
            Icon(
              Icons.account_balance_wallet_rounded,
              color: ColorConfig.iconColor,
            ).paddingRight(35.w).onTap(() {
              showDialog(
                context: context,
                barrierDismissible: false,
                builder: (BuildContext context) {
                  return Dialog(
                    shadowColor: ColorConfig.blue,
                    // shape: CircleBorder(),
                    backgroundColor: Colors.transparent,
                    elevation: 10,
                    child: walletContainer(),
                  );
                },
              );
            }),
          ],
          centerTitle: true,
          title: Text(
            "SmartBet",
            style: TextStyle(
              color: ColorConfig.iconColor,
              fontSize: 20.sp,
              fontWeight: FontWeight.w500,
            ),
          ),
          leading: Icon(
            Icons.arrow_back,
            color: ColorConfig.iconColor,
          ).onTap(() {
            finish(context);
          }),
          backgroundColor: ColorConfig.appBar,
        ),
        body: SizeConfig.screenWidth! <= 850
            ? diceTabletBody()
            : diceDesktopBody(),
      );
    } else {
      return Scaffold(
        backgroundColor: ColorConfig.scaffold,
        body: SizeConfig.screenWidth! <= 850
            ? diceTabletBody()
            : diceDesktopBody(),
      );
    }
  }
}

class diceTabletBody extends StatefulWidget {
  const diceTabletBody({super.key});

  @override
  State<diceTabletBody> createState() => _diceTabletBodyState();
}

class _diceTabletBodyState extends State<diceTabletBody> {
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
            final diceOddsData = oddsList.firstWhere(
                (odd) => odd.type == 'dice',
                orElse: () => Odds(
                    id: -1, maxAmount: 0, minAmount: 0, odds: 0, type: 'dice'));
            diceOdds = diceOddsData.odds;

            return Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      // color: Colors.amber,
                      // padding: EdgeInsets.only(top: 5),

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
                                CarHistory().launch(context);
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
                                DiceHistoryScreen().launch(context);

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
                                              //color: ColorConfig.redCar.withOpacity(0.9),
                                              img: provider.firstFiveHistory[index]
                                                          ['dice'] ==
                                                      '1'
                                                  ? "assets/images/1.png"
                                                  : provider.firstFiveHistory[
                                                              index]['dice'] ==
                                                          '2'
                                                      ? "assets/images/2.png"
                                                      : provider.firstFiveHistory[index]
                                                                  ['dice'] ==
                                                              '3'
                                                          ? "assets/images/3.png"
                                                          : provider.firstFiveHistory[
                                                                          index][
                                                                      'dice'] ==
                                                                  '4'
                                                              ? "assets/images/4.png"
                                                              : provider.firstFiveHistory[index]
                                                                          ['dice'] ==
                                                                      '5'
                                                                  ? "assets/images/5.png"
                                                                  : "assets/images/6.png",

                                              height: 50,
                                              width: 50,
                                            ),
                                          ),
                                        ),
                                        Row(
                                          children: List.generate(
                                            provider.lastFiveHistory.length,
                                            (index) => resultContainer(
                                              // colorImg: true,
                                              //color: ColorConfig.redCar.withOpacity(0.9),
                                              img: provider.lastFiveHistory[index]
                                                          ['dice'] ==
                                                      "1"
                                                  ? "assets/images/1.png"
                                                  : provider.lastFiveHistory[index]
                                                              ['dice'] ==
                                                          "2"
                                                      ? "assets/images/2.png"
                                                      : provider.lastFiveHistory[
                                                                      index]
                                                                  ['dice'] ==
                                                              "3"
                                                          ? "assets/images/3.png"
                                                          : provider.lastFiveHistory[
                                                                          index][
                                                                      'dice'] ==
                                                                  "4"
                                                              ? "assets/images/4.png"
                                                              : provider.lastFiveHistory[index]
                                                                          ['dice'] ==
                                                                      "5"
                                                                  ? "assets/images/5.png"
                                                                  : "assets/images/6.png",

                                              height: 50,
                                              width: 50,
                                            ),
                                          ),
                                        ),
                                      ],
                                    );
                            }),
                          ),
                        ],
                      ),
                    ),
                    // 5.toInt().height,
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
                                      width: 325,
                                      child: Row(children: [
                                        11.width,
                                        Text(
                                          "Correct Number Wins:",
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
                                              "$diceOdds" 'x',
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
                                    // 20.toInt().width,
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
                                              // padding: EdgeInsets.symmetric(
                                              //     vertical: 10.h, horizontal: 20.w),
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
                                                              "assets/images/d${provider.result["dice"]}.png")
                                                          : AssetImage(
                                                              "assets/images/loader.gif")),
                                                ),
                                              ),
                                            );
                                          },
                                        ),
                                        30.toInt().height,
                                        Text(
                                          "Select Number",
                                          style: TextStyle(
                                            fontSize: 15.sp,
                                            color: ColorConfig.iconColor,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                        5.toInt().height,
                                        Consumer<DiceStateProvider>(
                                          builder: (BuildContext context,
                                              provider, _) {
                                            return Column(
                                              children: [
                                                Row(
                                                  children: [
                                                    gameWidget(
                                                      newContainer: true,
                                                      //indexcolor: ColorConfig.tabincurrentindex,
                                                      dym: 60,
                                                      ht: 6,
                                                      wt: 30,
                                                      img:
                                                          "assets/images/1.png",
                                                      currentTab: provider.one,
                                                      function: () {
                                                        provider.setCurrentTab(
                                                            one: !provider.one,
                                                            two: false,
                                                            three: false,
                                                            four: false,
                                                            five: false,
                                                            six: false);
                                                      },
                                                    ),
                                                    7.width,
                                                    gameWidget(
                                                      //    indexcolor: ColorConfig.yellow,
                                                      newContainer: true,
                                                      dym: 60,
                                                      ht: 6,
                                                      wt: 30,
                                                      img:
                                                          "assets/images/2.png",
                                                      currentTab: provider.two,
                                                      function: () {
                                                        provider.setCurrentTab(
                                                            one: false,
                                                            two: !provider.two,
                                                            three: false,
                                                            four: false,
                                                            five: false,
                                                            six: false);
                                                      },
                                                    ),
                                                    7.width,
                                                    gameWidget(
                                                      //    indexcolor: ColorConfig.tabincurrentindex,
                                                      dym: 60,
                                                      ht: 6,
                                                      wt: 30,
                                                      newContainer: true,
                                                      img:
                                                          "assets/images/3.png",
                                                      currentTab:
                                                          provider.three,
                                                      function: () {
                                                        provider.setCurrentTab(
                                                            one: false,
                                                            two: false,
                                                            three:
                                                                !provider.three,
                                                            four: false,
                                                            five: false,
                                                            six: false);
                                                      },
                                                    ),
                                                    7.width,
                                                    gameWidget(
                                                      ///    indexcolor: ColorConfig.tabincurrentindex,
                                                      dym: 60,
                                                      ht: 6,
                                                      wt: 30,
                                                      img:
                                                          "assets/images/4.png",
                                                      currentTab: provider.four,
                                                      newContainer: true,
                                                      function: () {
                                                        provider.setCurrentTab(
                                                            one: false,
                                                            two: false,
                                                            three: false,
                                                            four:
                                                                !provider.four,
                                                            five: false,
                                                            six: false);
                                                      },
                                                    ),
                                                    7.width,
                                                    gameWidget(
                                                      //    indexcolor: ColorConfig.tabincurrentindex,
                                                      dym: 60,
                                                      ht: 6,
                                                      wt: 30,
                                                      img:
                                                          "assets/images/5.png",
                                                      newContainer: true,
                                                      currentTab: provider.five,
                                                      function: () {
                                                        provider.setCurrentTab(
                                                            one: false,
                                                            two: false,
                                                            three: false,
                                                            four: false,
                                                            five:
                                                                !provider.five,
                                                            six: false);
                                                      },
                                                    ),
                                                    7.width,
                                                    gameWidget(
                                                      //  indexcolor: ColorConfig.tabincurrentindex,
                                                      dym: 60,
                                                      ht: 6,
                                                      wt: 30,
                                                      img:
                                                          "assets/images/6.png",
                                                      newContainer: true,
                                                      currentTab: provider.six,
                                                      function: () {
                                                        provider.setCurrentTab(
                                                            one: false,
                                                            two: false,
                                                            three: false,
                                                            four: false,
                                                            five: false,
                                                            six: !provider.six);
                                                      },
                                                    ),
                                                  ],
                                                ),
                                                25.toInt().height,
                                                Consumer<SocketProvider>(
                                                    builder:
                                                        (BuildContext context,
                                                            model, _) {
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
                                                        final gameState = Provider
                                                            .of<DiceStateProvider>(
                                                                context,
                                                                listen: false);

                                                        if (gameState.one ||
                                                            gameState.two ||
                                                            gameState.three ||
                                                            gameState.four ||
                                                            gameState.five ||
                                                            gameState.six) {
                                                          showDialog(
                                                            useRootNavigator:
                                                                false,
                                                            barrierDismissible:
                                                                true,
                                                            context: context,
                                                            builder:
                                                                (BuildContext
                                                                    context) {
                                                              return Dialog(
                                                                // shape: CircleBorder(),
                                                                backgroundColor:
                                                                    Colors
                                                                        .transparent,
                                                                elevation: 10,
                                                                child:
                                                                    StakeContainer(
                                                                  fruit: false,
                                                                  car: false,
                                                                  coin: false,
                                                                  dice: true,
                                                                  maxAmount: 2,
                                                                  minAmount:
                                                                      0.000005,
                                                                ),
                                                              );
                                                            },
                                                          );
                                                        } else {
                                                          CustomSnackBar(
                                                              context: context,
                                                              message:
                                                                  "Please Select Dice",
                                                              width: 185);
                                                        }
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
                                            );
                                          },
                                        ),
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
    ;
  }
}

class diceDesktopBody extends StatefulWidget {
  const diceDesktopBody({super.key});

  @override
  State<diceDesktopBody> createState() => _diceDesktopBodyState();
}

class _diceDesktopBodyState extends State<diceDesktopBody> {
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
            final diceOddsData = oddsList.firstWhere(
                (odd) => odd.type == 'dice',
                orElse: () => Odds(
                    id: -1, maxAmount: 0, minAmount: 0, odds: 0, type: 'dice'));
            diceOdds = diceOddsData.odds;
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
                                DiceHistoryScreen().launch(context);

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
                                            Container(
                                              child: Row(
                                                children: List.generate(
                                                  provider.gameHistory.length,
                                                  (index) => resultContainer(
                                                    // colorImg: true,
                                                    //color: ColorConfig.redCar.withOpacity(0.9),
                                                    img: provider.gameHistory[index]
                                                                ['dice'] ==
                                                            "1"
                                                        ? "assets/images/1.png"
                                                        : provider.gameHistory[
                                                                        index]
                                                                    ['dice'] ==
                                                                "2"
                                                            ? "assets/images/2.png"
                                                            : provider.gameHistory[
                                                                            index]
                                                                        [
                                                                        'dice'] ==
                                                                    "3"
                                                                ? "assets/images/3.png"
                                                                : provider.gameHistory[index]
                                                                            ['dice'] ==
                                                                        "4"
                                                                    ? "assets/images/4.png"
                                                                    : provider.gameHistory[index]['dice'] == "5"
                                                                        ? "assets/images/5.png"
                                                                        : "assets/images/6.png",
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
                            }),
                          // if (SizeConfig.screenWidth! < 999) Spacer(),
                          // if (SizeConfig.screenWidth! < 999)
                          //   Container(
                          //     child: Row(
                          //       children: List.generate(
                          //         10,
                          //         (index) => resultContainer(
                          //           colorImg: true,
                          //           color: ColorConfig.redCar.withOpacity(0.9),
                          //           img: "assets/images/tesla.png",
                          //           height: 30,
                          //           width: 30,
                          //         ),
                          //       ),
                          //     ),
                          //   ),
                        ],
                      ),
                    ),
                    Container(
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
                                    width: 325,
                                    child: Row(children: [
                                      11.width,
                                      Text(
                                        "Correct Number Wins:",
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
                                            "$diceOdds" "x",
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
                                  Consumer<DiceStateProvider>(
                                    builder:
                                        (BuildContext context, provider, _) {
                                      return Column(
                                        children: [
                                          Row(
                                            children: [
                                              gameWidget(
                                                newContainer: true,
                                                //indexcolor: ColorConfig.tabincurrentindex,
                                                dym: 100,
                                                ht: 6,
                                                wt: 30,
                                                img: "assets/images/1.png",
                                                currentTab: provider.one,
                                                function: () {
                                                  provider.setCurrentTab(
                                                      one: !provider.one,
                                                      two: false,
                                                      three: false,
                                                      four: false,
                                                      five: false,
                                                      six: false);
                                                },
                                              ),
                                              7.width,
                                              gameWidget(
                                                //    indexcolor: ColorConfig.yellow,
                                                newContainer: true,
                                                dym: 100,
                                                ht: 6,
                                                wt: 30,
                                                img: "assets/images/2.png",
                                                currentTab: provider.two,
                                                function: () {
                                                  provider.setCurrentTab(
                                                      one: false,
                                                      two: !provider.two,
                                                      three: false,
                                                      four: false,
                                                      five: false,
                                                      six: false);
                                                },
                                              ),
                                              7.width,
                                              gameWidget(
                                                //    indexcolor: ColorConfig.tabincurrentindex,
                                                dym: 100,
                                                ht: 6,
                                                wt: 30,
                                                newContainer: true,
                                                img: "assets/images/3.png",
                                                currentTab: provider.three,
                                                function: () {
                                                  provider.setCurrentTab(
                                                      one: false,
                                                      two: false,
                                                      three: !provider.three,
                                                      four: false,
                                                      five: false,
                                                      six: false);
                                                },
                                              ),
                                            ],
                                          ),
                                          Row(
                                            children: [
                                              gameWidget(
                                                ///    indexcolor: ColorConfig.tabincurrentindex,
                                                dym: 100,
                                                ht: 6,
                                                wt: 30,
                                                img: "assets/images/4.png",
                                                currentTab: provider.four,
                                                newContainer: true,
                                                function: () {
                                                  provider.setCurrentTab(
                                                      one: false,
                                                      two: false,
                                                      three: false,
                                                      four: !provider.four,
                                                      five: false,
                                                      six: false);
                                                },
                                              ),
                                              7.width,
                                              gameWidget(
                                                //    indexcolor: ColorConfig.tabincurrentindex,
                                                dym: 100,
                                                ht: 6,
                                                wt: 30,
                                                img: "assets/images/5.png",
                                                newContainer: true,
                                                currentTab: provider.five,
                                                function: () {
                                                  provider.setCurrentTab(
                                                      one: false,
                                                      two: false,
                                                      three: false,
                                                      four: false,
                                                      five: !provider.five,
                                                      six: false);
                                                },
                                              ),
                                              7.width,
                                              gameWidget(
                                                //  indexcolor: ColorConfig.tabincurrentindex,
                                                dym: 100,
                                                ht: 6,
                                                wt: 30,
                                                img: "assets/images/6.png",
                                                newContainer: true,
                                                currentTab: provider.six,

                                                function: () {
                                                  provider.setCurrentTab(
                                                      one: false,
                                                      two: false,
                                                      three: false,
                                                      four: false,
                                                      five: false,
                                                      six: !provider.six);
                                                },
                                              ),
                                            ],
                                          ),
                                        ],
                                      );
                                    },
                                  )
                                ],
                              ),
                              100.width,
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
                                  25.toInt().height,
                                  Consumer<SocketProvider>(
                                    builder:
                                        (BuildContext context, provider, _) {
                                      return Container(
                                        // padding: EdgeInsets.symmetric(
                                        //     vertical: 10.h, horizontal: 20.w),
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
                                                        "assets/images/d${provider.result["dice"]}.png")
                                                    : AssetImage(
                                                        "assets/images/loader.gif")),
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                                  18.toInt().height,
                                  Text(
                                    "Select Number",
                                    style: TextStyle(
                                      fontSize: 15.sp,
                                      color: ColorConfig.iconColor,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  13.toInt().height,
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
                                              Provider.of<DiceStateProvider>(
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
                                                  backgroundColor:
                                                      Colors.transparent,
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
                    ).cornerRadiusWithClipRRect(18).paddingTop(15),
                  ],
                )
              ],
            );
          }
        });
  }
}

void _showAlertDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text('Alert'),
        content: Text('This is an alert dialog.'),
        actions: <Widget>[
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Text('OK'),
          ),
        ],
      );
    },
  );
}
