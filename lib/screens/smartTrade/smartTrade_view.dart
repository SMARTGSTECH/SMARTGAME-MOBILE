import 'package:avatar_glow/avatar_glow.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';
import 'package:smartbet/screens/coin/coinhistory/historyMobile.dart';
import 'package:smartbet/screens/coin/provider.dart';
import 'package:smartbet/screens/history/mobile.dart';
import 'package:smartbet/screens/home/provider.dart';
import 'package:smartbet/screens/smartTrade/smartTrade_viewmodel.dart';
import 'package:smartbet/services/apiClient.dart';
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
  late List liveGameodds;

  @override
  void initState() {
    super.initState();
    futureOdds = fetchOdds();
    ApiClientService.getActiveSession('currency');
    // coinOdds = 0.0;
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
              }
              final oddsList = snapshot.data!;
              final coinOddsData = oddsList
                  .where(
                    (odd) => odd.type == 'currency',
                  )
                  .toList()
                  .first;
              liveGameodds = [
                coinOddsData.minAmount,
                coinOddsData.maxAmount,
                coinOddsData.odds
              ];
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
                                      "\$${0.0}/ \$${liveGameodds[2]}",
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
                              // ),e
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
                            provider.counter == 300
                                ? ApiClientService.getActiveSession('currency')
                                : print('Data is null new');
                            log(provider);
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
                                const CoinHistoryMobile(
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
                      Consumer<SocketProvider>(
                          builder: (BuildContext context, provider, _) {
                        var formatter = NumberFormat('#,###');
                        print(widget);
                        return gameCard(
                            count: 30.toString(),
                            img: widget.img,
                            symbol: widget.symbol,
                            rate: provider.coin[widget.symbol] == null
                                ? 0.00.toString()
                                : provider.coin[widget.symbol]
                                    .toStringAsFixed(2));
                      }),

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

                      Consumer2<SmartTradeProvider, SocketProvider>(builder:
                          (BuildContext context, smartTradeProvider,
                              socketTradeProvider, _) {
                        return Container(
                          // color: Colors.amber,
                          width: 230.w,
                          height: 180.h,
                          child: CustomGridView(
                            gridCount: true,
                            useAspectRatio: true,
                            itemCount: 4,
                            crossAxisCount: 1,
                            crossAxisSpacing: 10.0,
                            mainAxisSpacing: 1.h,
                            itemBuilder: (BuildContext context, int index) {
                              String indexname = socketTradeProvider
                                  .gameSocketOption(widget.symbol)[index];
                              String selectedOption = socketTradeProvider
                                  .gameSocketOptionForBackend(
                                      widget.symbol)[index];
                              return Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: CustomAppButton(
                                  text: socketTradeProvider
                                      .gameSocketOption(widget.symbol)[index],
                                  usePadding: true,

                                  ///  shimmer: true,
                                  onPressed: () {
                                    print(selectedOption);
                                    print(indexname);
                                    smartTradeProvider.setOption(
                                        selectedOption, indexname);
                                    smartTradeProvider.toggleOptionIndex(
                                        socketTradeProvider
                                            .gameSocketOption(widget.symbol)
                                            .indexOf(indexname));

                                    // print([
                                    //   socketTradeProvider.gameSocketOption(
                                    //       widget.symbol)[index],
                                    //   socketTradeProvider
                                    //       .gameSocketOption(widget.symbol)
                                    //       .indexOf(
                                    //         smartTradeProvider.selectedOption,
                                    //       ),
                                    //   socketTradeProvider
                                    //           .gameSocketOption(widget.symbol)
                                    //           .indexOf(smartTradeProvider
                                    //               .gameOptions[index]) ==
                                    //       smartTradeProvider.selectedOptionIndex
                                    // ]);
                                    // provider.setCurrentTab(
                                    //   tail: !provider.tail,
                                    //   head: false,
                                    // );
                                    // Add your onPressed logic here
                                  },
                                  color: socketTradeProvider
                                              .gameSocketOption(widget.symbol)
                                              .indexOf(indexname) ==
                                          smartTradeProvider.selectedOptionIndex
                                      ? ColorConfig.yellow
                                      : ColorConfig.tabincurrentindex,
                                  textColor: Colors.white,
                                  borderRadius: 4.r,
                                  height: 0,
                                  width: 0,
                                  size: 15,
                                  //  padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 12.0),
                                ),
                              );
                            },
                          ),
                        ).paddingTop(20.h);
                      }),

                      //15.h.toInt().height,

                      // Text(
                      //   "Select Side",
                      //   style: TextStyle(
                      //     fontSize: 13.sp,
                      //     color: ColorConfig.iconColor,
                      //   ),
                      // ),
                      // 1.h.toInt().height,

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
                        if (model.counter >= 60) {
                          // if (!true) {
                          return CustomAppButton(
                            color: Colors.grey,
                            textColor: Colors.black,
                            borderRadius: 4.r,
                            height: 22.h,
                            width: 55.w,
                            size: 14,

                            ///    shimmer: true,
                            onPressed: () {
                              CustomSnackBar(
                                  context: context,
                                  message: "Next Session Starts from 60sec",
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
                            final gameState = Provider.of<SmartTradeProvider>(
                                context,
                                listen: false);
                            final gameStateSocket = Provider.of<SocketProvider>(
                                context,
                                listen: false);
                            // String selectedOption = gameStateSocket
                            //     .gameSocketOptionForBackend(widget.symbol)[index];
                            if (gameState.selectedOptionIndex != 100) {
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
                                      useSession: true,
                                      minAmount: liveGameodds[0],
                                      maxAmount: liveGameodds[1],
                                      // isEvent: !true,
                                      prediction:
                                          gameState.selectedOptionToDisplay,
                                      gameType: widget.symbol,
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

                      //10.h.toInt().height,
                    ],
                  ),
                ),
              );
            }));
  }
}

class gameCard extends StatelessWidget {
  const gameCard({
    super.key,
    required this.img,
    required this.symbol,
    required this.count,
    required this.rate,
  });
  final String img;
  final String symbol;
  final String count;
  final String rate;

  @override
  Widget build(BuildContext context) {
    var formatter = NumberFormat('#,###');
    return Container(
      height: 150.h,
      width: 300.w,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            //fromARGB(0, 75, 71, 71),
            Colors.transparent,
            ColorConfig.appBar.withOpacity(0.5),

            // ColorConfig.iconColor.withOpacity(0.2),
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

              // mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.network(
                  img,
                  height: 75.h,
                ).cornerRadiusWithClipRRect(50),
                15.w.toInt().width,
                Text(
                  "\$${formatter.format(double.tryParse(rate))}" +
                      '.${rate.toString().split('.')[1]}',
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
