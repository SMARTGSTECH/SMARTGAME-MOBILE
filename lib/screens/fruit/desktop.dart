import 'package:avatar_glow/avatar_glow.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:just_audio/just_audio.dart';
import 'package:lottie/lottie.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:provider/provider.dart';
import 'package:smartbet/screens/car/provider.dart';
import 'package:smartbet/screens/fruit/fruitHistory/desktop.dart';
import 'package:smartbet/screens/history/desktop.dart';
import 'package:smartbet/services/oddsClient.dart';
import 'package:smartbet/utils/config/size.dart';
import 'package:smartbet/screens/fruit/provider.dart';
import 'package:smartbet/socket/provider.dart';
import 'package:smartbet/utils/config/color.dart';
import 'package:smartbet/widget/alertSnackBar.dart';
import 'package:smartbet/widget/button.dart';
import 'package:smartbet/widget/customAppBar.dart';
import 'package:smartbet/widget/gameWidget.dart';
import 'package:smartbet/widget/resultWidget.dart';
import 'package:smartbet/widget/stakeContainer.dart';

class FruitDesktopScreen extends StatefulWidget {
  const FruitDesktopScreen({super.key, this.directLaunch = false});
  final bool directLaunch;
  @override
  State<FruitDesktopScreen> createState() => _FruitDesktopScreenState();
}

class _FruitDesktopScreenState extends State<FruitDesktopScreen> {
  @override
  Widget build(BuildContext context) {
    print("object");

    if (widget.directLaunch) {
      return Scaffold(
        appBar: customAppbar(context),
        backgroundColor: ColorConfig.scaffold,
        body: SizeConfig.screenWidth! <= 850
            ? _TabletRowBody()
            : DesktopRowBody(),
      );
    } else {
      return Scaffold(
        backgroundColor: ColorConfig.scaffold,
        body: SizeConfig.screenWidth! <= 850
            ? _TabletRowBody()
            : DesktopRowBody(),
      );
    }
  }
}

class _TabletRowBody extends StatefulWidget {
  const _TabletRowBody({super.key});

  @override
  State<_TabletRowBody> createState() => __TabletRowBodyState();
}

class __TabletRowBodyState extends State<_TabletRowBody> {
  late Future<List<Odds>> futureOdds;
  late double fruitOdds;

  @override
  void initState() {
    super.initState();
    futureOdds = fetchOdds();
    fruitOdds = 0.0;
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
            final fruitOddsData = oddsList.firstWhere(
                (odd) => odd.type == 'friut',
                orElse: () => Odds(
                    id: -1,
                    maxAmount: 0,
                    minAmount: 0,
                    odds: 0,
                    type: 'friut'));
            fruitOdds = fruitOddsData.odds;

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
                      width: SizeConfigs.getPercentageWidth(97),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
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
                                      size: 25,
                                      color: ColorConfig.iconColor,
                                    ),
                                  )).onTap(() {
                                FruitHistoryScreen().launch(context);
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
                                              colorImg: provider
                                                      .firstFiveHistory[index]
                                                          ['fruit']
                                                      .toLowerCase() ==
                                                  'p',
                                              // colorImg: true,
                                              //color: ColorConfig.redCar.withOpacity(0.9),
                                              img: provider.firstFiveHistory[
                                                              index]['fruit']
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
                                                                      ['fruit']
                                                                  .toLowerCase() ==
                                                              'o'
                                                          ? "assets/images/orange.png"
                                                          : "assets/images/pine.png",

                                              height: 50,
                                              width: 50,
                                            ),
                                          ),
                                        ),
                                        Row(
                                          children: List.generate(
                                            provider.lastFiveHistory.length,
                                            (index) => resultContainer(
                                              colorImg: provider
                                                      .lastFiveHistory[index]
                                                          ['fruit']
                                                      .toLowerCase() ==
                                                  'p',
                                              // colorImg: true,
                                              //color: ColorConfig.redCar.withOpacity(0.9),
                                              img: provider.lastFiveHistory[
                                                              index]['fruit']
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
                                                                      ['fruit']
                                                                  .toLowerCase() ==
                                                              'p'
                                                          ? "assets/images/pine.png"
                                                          : "assets/images/orange.png",

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
                    Container(
                      padding: EdgeInsets.only(
                        right: SizeConfigs.getPercentageWidth(2),
                      ),

                      height: 600,

                      width: SizeConfigs.screenWidth <= 465
                          ? SizeConfigs.getPercentageWidth(98)
                          : SizeConfigs.getPercentageWidth(98),
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
                                      width: 340,
                                      child: Row(children: [
                                        11.width,
                                        Text(
                                          "Correct Fruit Wins:",
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
                                              "$fruitOdds" 'x',
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
                                    // 35.toInt().height,
                                    // 30.toInt().height,
                                    20.toInt().height,
                                    Consumer<SocketProvider>(
                                      builder:
                                          (BuildContext context, provider, _) {
                                        return Container(
                                          decoration: BoxDecoration(
                                              color: ColorConfig
                                                  .desktopGameappBar),
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
                                    Stack(
                                      alignment: Alignment.center,
                                      children: [
                                        Container(
                                          //   color: ColorConfig.red,
                                          width: 410,
                                          // SizeConfig.screenWidth! > 999
                                          //     ? 410
                                          //     : 280,
                                          height: 275,
                                        ),
                                        fruitContainerWidget(),
                                        // Consumer<SocketProvider>(
                                        //   builder: (BuildContext context,
                                        //       provider, _) {
                                        //     return Container(
                                        //       decoration: BoxDecoration(
                                        //         // color: Colors.deepOrangeAccent,
                                        //         border: Border.all(
                                        //             color: ColorConfig
                                        //                 .lightBoarder),
                                        //         image: DecorationImage(
                                        //             //  opacity: 0.5,
                                        //             fit: BoxFit.fill,
                                        //             image:
                                        //                 // provider.counter == 49 ||
                                        //                 //         provider.counter == 48 ||
                                        //                 //         provider.counter == 47 ||
                                        //                 //         provider.counter == 46
                                        //                 //     ? AssetImage(
                                        //                 //         "assets/images/${provider.result["fruit"]}.gif")
                                        //                 //     :
                                        //                 AssetImage(
                                        //                     "assets/images/847myv.gif")),
                                        //       ),
                                        //       height: 220,
                                        //       width: 340,
                                        //     ).cornerRadiusWithClipRRect(5);
                                        //   },
                                        // ),
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
                                                glowColor:
                                                    ColorConfig.iconColor,
                                                duration: Duration(
                                                    milliseconds: 2000),
                                                child: CircleAvatar(
                                                  radius: 20,
                                                  backgroundColor:
                                                      ColorConfig.yellow,
                                                  child: FruitGameMusic(),
                                                ))),
                                      ],
                                    ),
                                    Text(
                                      "Select Fruit",
                                      style: TextStyle(
                                        fontSize: 16.sp,
                                        color: ColorConfig.iconColor,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                    8.toInt().height,

                                    Consumer<FruitStateProvider>(
                                      builder:
                                          (BuildContext context, provider, _) {
                                        return Row(
                                          children: [
                                            gameWidget(
                                              //  indexcolor: ColorConfig.tabincurrentindex,
                                              dym: 70,
                                              ht: 6,
                                              wt: 30,
                                              img: "assets/images/pine.png",
                                              imgcolor: Color(0xfffbd604),
                                              colorImg: true,
                                              backgroundCar: true,
                                              currentTab: provider.pineapple,
                                              function: () {
                                                provider.setCurrentTab(
                                                    pine: !provider.pineapple,
                                                    orange: false,
                                                    banana: false,
                                                    straw: false);
                                              },
                                            ),
                                            7.width,
                                            gameWidget(
                                              //  indexcolor: ColorConfig.tabincurrentindex,
                                              dym: 70,
                                              ht: 6,
                                              wt: 30,
                                              img: "assets/images/orange.png",
                                              imgcolor: ColorConfig.yellowCar,
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
                                            7.width,
                                            gameWidget(
                                              //  indexcolor: ColorConfig.tabincurrentindex,
                                              dym: 70,
                                              ht: 6,
                                              wt: 30,
                                              img: "assets/images/banana.png",
                                              imgcolor: ColorConfig.yellowCar,

                                              // colorImg: true,
                                              backgroundCar: true,
                                              currentTab: provider.banana,
                                              function: () {
                                                provider.setCurrentTab(
                                                    pine: false,
                                                    orange: false,
                                                    banana: !provider.banana,
                                                    straw: false);
                                              },
                                            ),
                                            7.width,
                                            gameWidget(
                                              // indexcolor: ColorConfig.tabincurrentindex,
                                              dym: 70,
                                              ht: 6,
                                              wt: 30,
                                              img: "assets/images/straw.png",

                                              currentTab: provider.starwberry,
                                              function: () {
                                                provider.setCurrentTab(
                                                    pine: false,
                                                    orange: false,
                                                    banana: false,
                                                    straw:
                                                        !provider.starwberry);
                                              },
                                              backgroundCar: true,
                                            ),
                                          ],
                                        );
                                      },
                                    ),

                                    10.toInt().height,

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
                                                Provider.of<FruitStateProvider>(
                                                    context,
                                                    listen: false);

                                            // Add your onPressed logic here
                                            if (gameState.orange ||
                                                gameState.pineapple ||
                                                gameState.banana ||
                                                gameState.starwberry) {
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
                                                  message:
                                                      "Please Select A Fruit",
                                                  width: 205);
                                            }
                                            ;
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

                                    20.toInt().height,
                                  ],
                                ),
                                // 50.width,
                              ],
                            ),
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

class DesktopRowBody extends StatefulWidget {
  const DesktopRowBody({Key? key}) : super(key: key);

  @override
  __DesktopRowBodyState createState() => __DesktopRowBodyState();
}

class __DesktopRowBodyState extends State<DesktopRowBody> {
  late Future<List<Odds>> futureOdds;
  late double fruitOdds;

  @override
  void initState() {
    super.initState();
    futureOdds = fetchOdds();
    fruitOdds = 0.0;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
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
                                FruitHistoryScreen().launch(context);
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
                          // Spacer(),
                          if (SizeConfig.screenWidth! > 850)
                            Container(
                              padding: EdgeInsets.only(right: 30),
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
                                              Container(
                                                child: Row(
                                                  children: List.generate(
                                                    provider.gameHistory.length,
                                                    (index) => resultContainer(
                                                      colorImg: provider
                                                              .gameHistory[
                                                                  index]
                                                                  ['fruit']
                                                              .toLowerCase() ==
                                                          'p',
                                                      //color: ColorConfig.redCar.withOpacity(0.9),
                                                      img: provider.gameHistory[
                                                                      index]
                                                                      ['fruit']
                                                                  .toLowerCase() ==
                                                              's'
                                                          ? "assets/images/straw.png"
                                                          : provider.gameHistory[
                                                                          index]
                                                                          [
                                                                          'fruit']
                                                                      .toLowerCase() ==
                                                                  'b'
                                                              ? "assets/images/banana.png"
                                                              : provider.gameHistory[
                                                                              index]
                                                                              [
                                                                              'fruit']
                                                                          .toLowerCase() ==
                                                                      'p'
                                                                  ? "assets/images/pine.png"
                                                                  : "assets/images/orange.png",

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
                            ),
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
                                    width: 340,
                                    child: Row(children: [
                                      11.width,
                                      Text(
                                        "Correct Fruit Wins:",
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
                                            "$fruitOdds" 'x',
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
                                    "Select Fruit",
                                    style: TextStyle(
                                      fontSize: 16.sp,
                                      color: ColorConfig.iconColor,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  8.toInt().height,
                                  Consumer<FruitStateProvider>(
                                    builder:
                                        (BuildContext context, provider, _) {
                                      return Row(
                                        children: [
                                          gameWidget(
                                            //  indexcolor: ColorConfig.tabincurrentindex,
                                            dym: 70,
                                            ht: 6,
                                            wt: 30,
                                            img: "assets/images/pine.png",
                                            imgcolor: Color(0xfffbd604),
                                            colorImg: true,
                                            backgroundCar: true,
                                            currentTab: provider.pineapple,
                                            function: () {
                                              provider.setCurrentTab(
                                                  pine: !provider.pineapple,
                                                  orange: false,
                                                  banana: false,
                                                  straw: false);
                                            },
                                          ),
                                          7.width,
                                          gameWidget(
                                            //  indexcolor: ColorConfig.tabincurrentindex,
                                            dym: 70,
                                            ht: 6,
                                            wt: 30,
                                            img: "assets/images/orange.png",
                                            imgcolor: ColorConfig.yellowCar,
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
                                          7.width,
                                          gameWidget(
                                            //  indexcolor: ColorConfig.tabincurrentindex,
                                            dym: 70,
                                            ht: 6,
                                            wt: 30,
                                            img: "assets/images/banana.png",

                                            // colorImg: true,
                                            backgroundCar: true,
                                            currentTab: provider.banana,
                                            function: () {
                                              provider.setCurrentTab(
                                                  pine: false,
                                                  orange: false,
                                                  banana: !provider.banana,
                                                  straw: false);
                                            },
                                          ),
                                          7.width,
                                          gameWidget(
                                            // indexcolor: ColorConfig.tabincurrentindex,
                                            dym: 70,
                                            ht: 6,
                                            wt: 30,
                                            img: "assets/images/straw.png",

                                            currentTab: provider.starwberry,
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
                                      );
                                    },
                                  ),

                                  35.toInt().height,

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
                                              Provider.of<FruitStateProvider>(
                                                  context,
                                                  listen: false);
                                          // Add your onPressed logic here
                                          if (gameState.orange ||
                                              gameState.pineapple ||
                                              gameState.banana ||
                                              gameState.starwberry) {
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
                                                message:
                                                    "Please Select A Fruit",
                                                width: 205);
                                          }
                                          ;
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
                                        //   color: ColorConfig.red,
                                        width: 410,
                                        // SizeConfig.screenWidth! > 999
                                        //     ? 410
                                        //     : 280,
                                        height: 275,
                                      ),

                                      fruitContainerWidget(),
                                      // Consumer<SocketProvider>(
                                      //   builder: (BuildContext context,
                                      //       provider, _) {
                                      //     return Container(
                                      //       decoration: BoxDecoration(
                                      //         // color: Colors.deepOrangeAccent,
                                      //         border: Border.all(
                                      //             color:
                                      //                 ColorConfig.lightBoarder),
                                      //         image: DecorationImage(
                                      //             //  opacity: 0.5,
                                      //             fit: BoxFit.fill,
                                      //             image:
                                      //                 // provider.counter == 49 ||
                                      //                 //         provider.counter == 48 ||
                                      //                 //         provider.counter == 47 ||
                                      //                 //         provider.counter == 46
                                      //                 //     ? AssetImage(
                                      //                 //         "assets/images/${provider.result["fruit"]}.gif")
                                      //                 //     :
                                      //                 AssetImage(
                                      //                     "assets/images/847myv.gif")),
                                      //       ),
                                      //       height: 220,
                                      //       width: 340,
                                      //     ).cornerRadiusWithClipRRect(5);
                                      //   },
                                      // ),
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
                                                child: FruitGameMusic(),
                                              ))),
                                    ],
                                  ),
                                  //  30.toInt().height,

                                  // CustomButtonDesktop(
                                  //     text: 'Stake',
                                  //     shimmer: true,
                                  //     onPressed: () {
                                  //       // Add your onPressed logic here
                                  //     },
                                  //     color: ColorConfig.yellow,
                                  //     textColor: Colors.white,
                                  //     borderRadius: 5,
                                  //     height: 24,
                                  //     width: 60,
                                  //     size: 16
                                  //     //  padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 12.0),
                                  //     ),
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

class fruitContainerWidget extends StatelessWidget {
  const fruitContainerWidget({
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
          height: 220,
          width: 340,
        ).cornerRadiusWithClipRRect(5);
      },
    );
  }
}

class FruitGameMusic extends StatelessWidget {
  const FruitGameMusic({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Center(child:
        Consumer3<FruitStateProvider, CarStateProvider, SocketProvider>(builder:
            (context, fruitStateProvider, carStateProvider, socketProvider, _) {
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
