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
import 'package:smartbet/screens/liveEvent/liveEvent_view_model.dart';
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

class LiveEventMobileScreen extends StatefulWidget {
  const LiveEventMobileScreen(
      {super.key,
      required this.symbol,
      required this.img,
      required this.option,
      required this.info,
      required this.dates});

  final String symbol;
  final String img;
  final List option;
  final String info;
  final List dates;

  @override
  State<LiveEventMobileScreen> createState() => _LiveEventMobileScreenState();
}

class _LiveEventMobileScreenState extends State<LiveEventMobileScreen> {
  late Future<List<Odds>> futureOdds;
  late List livePredictionOdds;

  @override
  void initState() {
    super.initState();
    futureOdds = fetchOdds();
    //coinOdds = 0.0;
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
              print('THIS IS THE EXPERIEkekwejkwjewjekwjekweNCESS');
              print(oddsList);
              //    final coinOddsData = oddsList.where((e.)=>);
              // Find odds for race type
              final livePredictionData = oddsList
                  .where(
                    (odd) => odd.type == 'dynamic',
                  )
                  .toList()
                  .first;
              livePredictionOdds = [
                livePredictionData.minAmount,
                livePredictionData.maxAmount,
                livePredictionData.odds
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
                          80.w.toInt().width,
                          Text(
                            "Live Prediction",
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
                                      "\$0.0 / \$${livePredictionOdds[2]}",
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
                          Column(
                            children: [
                              Row(
                                children: [
                                  Text(
                                    'Starts:',
                                    style: TextStyle(
                                        fontSize: 12.sp,
                                        color: ColorConfig.white,
                                        fontWeight: FontWeight.w500),
                                  ),
                                  const SizedBox(
                                    height: 15,
                                  ),
                                  Text(
                                    "${DateFormat('dd MM yyyy hh:mm a').format(DateTime.parse(widget.dates[0]).toLocal())} ",
                                    style: TextStyle(
                                        fontSize: 12.sp,
                                        color: ColorConfig.iconColor,
                                        fontWeight: FontWeight.w500),
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  Text(
                                    'Expires:',
                                    style: TextStyle(
                                        fontSize: 12.sp,
                                        color: ColorConfig.white,
                                        fontWeight: FontWeight.w500),
                                  ).onTap(() {
                                    print(widget.dates.first.runtimeType);
                                  }),
                                  Text(
                                    " ${DateFormat('dd MM yyyy hh:mm a').format(DateTime.parse(widget.dates[1]).toLocal())} ",
                                    style: TextStyle(
                                        fontSize: 12.sp,
                                        color: ColorConfig.iconColor,
                                        fontWeight: FontWeight.w500),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          // Consumer<SocketProvider>(
                          //     builder: (BuildContext context, provider, _) {
                          //   return Container(
                          //     decoration: BoxDecoration(color: ColorConfig.appBar),
                          //     child: Padding(
                          //       padding: const EdgeInsets.all(8.0),
                          //       child: Center(
                          //         child: Text(
                          //           "${widget.dates}",
                          //           style: TextStyle(
                          //               fontSize: 16.sp,
                          //               color: ColorConfig.iconColor,
                          //               fontWeight: FontWeight.bold),
                          //         ),
                          //       ),
                          //     ),
                          //   )
                          //       .withWidth(60.w)
                          //       .withHeight(30.h)
                          //       .cornerRadiusWithClipRRect(5.r);
                          // }),
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
                      gameCard(
                        count: 30.toString(),
                        img: widget.img,
                        symbol: '',
                        tp: '30',
                        info: widget.info,
                      ),
                      10.h.toInt().height,
                      Text(
                        widget.info, // example long text
                        style: TextStyle(
                          fontSize: 15.sp,
                          fontWeight: FontWeight.bold,
                        ),
                        softWrap: true, // enable soft wrapping
                        overflow:
                            TextOverflow.visible, // specify overflow behavior
                        maxLines: null, // allow as many lines as needed
                      ).paddingSymmetric(horizontal: 23.w).paddingLeft(2.w),
                      Consumer<LiveEventPredictionProvider>(
                          builder: (BuildContext context, provider, _) {
                        provider.getWalletState();
                        // : provider.isOdd(provider.gameOption.length)
                        //   ? provider.gameOption.length * 30.h
                        //   :

                        return Column(
                          children: [
                            Container(
                              // color: ColorConfig.blue,
                              width: 250.w,
                              height: widget.option.length * 48.h,
                              child: CustomGridView(
                                gridCount: true,
                                useAspectRatio: true,
                                itemCount: widget.option.length,
                                crossAxisCount: 1,
                                crossAxisSpacing: 10.0,
                                mainAxisSpacing: 1.h,
                                itemBuilder: (BuildContext context, int index) {
                                  return Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: CustomAppButton(
                                      text: widget.option[index],
                                      usePadding: true,

                                      ///  shimmer: true,
                                      onPressed: () {
                                        provider
                                            .toggleOption(widget.option[index]);
                                        provider.toggleOptionIndex(widget.option
                                            .indexOf(widget.option[index]));
                                        // print([
                                        //   provider.gameOption[index],
                                        //   provider.gameOption.indexOf(
                                        //     provider.selectedOption,
                                        //   ),
                                        //   provider.gameOption
                                        //           .indexOf(provider.gameOption[index]) ==
                                        //       provider.selectedOptionIndex
                                        // ]);
                                        // provider.setCurrentTab(
                                        //   tail: !provider.tail,
                                        //   head: false,
                                        // );
                                        // Add your onPressed logic here
                                      },
                                      color: provider.gameOption.indexOf(
                                                  provider.gameOption[index]) ==
                                              provider.selectedOptionIndex
                                          ? ColorConfig.yellow
                                          : ColorConfig.tabincurrentindex,
                                      textColor: Colors.white,
                                      borderRadius: 4.r,
                                      height: 0,
                                      width: 0,
                                      size: 14,
                                      //  padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 12.0),
                                    ),
                                  );
                                },
                              ),
                            ),
                            if (provider.status)
                              CustomAppButton(
                                text: 'Play',
                                color: ColorConfig.yellow,
                                textColor: Colors.white,
                                borderRadius: 4.r,
                                height: 22.h,
                                width: 60.w,
                                size: 14,
                                onPressed: () {
                                  print(widget.dates.first.runtimeType);
                                  String date1Str = widget.dates[0];
                                  String date2Str = widget.dates[1];
                                  DateTime date1 = DateTime.parse(date1Str);
                                  DateTime date2 = DateTime.parse(date2Str);

                                  if (date1.isAfter(date2)) {
                                    CustomSnackBar(
                                        context: context,
                                        message:
                                            "Game session Expired at\n${DateFormat('dd MM yyyy hh:mm a').format(DateTime.parse(widget.dates[1]).toLocal())}",
                                        width: 220);
                                    return;
                                  }
                                  final gameState =
                                      Provider.of<CoinStateProvider>(context,
                                          listen: false);
                                  print(provider.selectedOption);
                                  if (provider.selectedOptionIndex != 100) {
                                    showDialog(
                                      useRootNavigator: false,
                                      barrierDismissible: true,
                                      context: context,
                                      builder: (BuildContext context) {
                                        return Dialog(
                                          // shape: CircleBordxer(),
                                          backgroundColor: Colors.transparent,
                                          elevation: 10,
                                          child: StakeContainer(
                                            maxAmount: livePredictionOdds[1],
                                            minAmount: livePredictionOdds[0],
                                            isEvent: true,
                                            prediction: provider.selectedOption,
                                            gameType: 'dynamic',
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
                              ),
                            if (!provider.status)
                              CustomAppButton(
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
                              )
                          ],
                        );
                      }).paddingTop(13.h),
                      //  15.h.toInt().height,

                      // Text(
                      //   "Select Side",
                      //   style: TextStyle(
                      //     fontSize: 13.sp,
                      //     color: ColorConfig.iconColor,
                      //   ),

                      // Consumer<SocketProvider>(
                      //     builder: (BuildContext context, model, _) {
                      //   // if (model.counter <= 10) {
                      //   //   return CustomAppButton(
                      //   //     color: Colors.grey,
                      //   //     textColor: Colors.black,
                      //   //     borderRadius: 4.r,
                      //   //     height: 22.h,
                      //   //     width: 60.w,
                      //   //     size: 14,

                      //   //     ///    shimmer: true,
                      //   //     onPressed: () {
                      //   //       CustomSnackBar(
                      //   //           context: context,
                      //   //           message: "Game Session Ended!",
                      //   //           width: 220);
                      //   //     },

                      //   //     ///  color: Colors.grey,
                      //   //     text: 'Play',
                      //   //   );
                      //   // }
                      //   return CustomAppButton(
                      //     text: 'Play',
                      //     color: ColorConfig.yellow,
                      //     textColor: Colors.white,
                      //     borderRadius: 4.r,
                      //     height: 22.h,
                      //     width: 60.w,
                      //     size: 14,
                      //     onPressed: () {
                      //       final gameState = Provider.of<CoinStateProvider>(context,
                      //           listen: false);

                      //       if (true) {
                      //         showDialog(
                      //           useRootNavigator: false,
                      //           barrierDismissible: true,
                      //           context: context,
                      //           builder: (BuildContext context) {
                      //             return Dialog(
                      //               // shape: CircleBorder(),
                      //               backgroundColor: Colors.transparent,
                      //               elevation: 10,
                      //               child: StakeContainer(
                      //                 isEvent: true,
                      //               ),
                      //             );
                      //           },
                      //         );
                      //       } else {
                      //         CustomSnackBar(
                      //             context: context,
                      //             message: "Please Select A Side",
                      //             width: 220);
                      //       }
                      //     },
                      //   );
                      // }),
                      // ),
                      25.h.toInt().height,
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
    required this.tp,
    required this.info,
  });
  final String img;
  final String info;
  final String symbol;
  final String count;
  final String tp;

  @override
  Widget build(BuildContext context) {
    print(img);
    return Container(
      height: 150.h,
      width: 300.w,
      decoration: symbol == ''
          ? BoxDecoration(
              image: DecorationImage(
                  //  opacity: 0.5,
                  fit: symbol == '' ? BoxFit.cover : BoxFit.fitHeight,
                  image: NetworkImage(img)),
              gradient: LinearGradient(
                colors: symbol == ''
                    ? [
                        Color.fromARGB(0, 0, 0, 0),
                        Colors.transparent,
                      ]
                    : [
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
            )
          : BoxDecoration(
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
            symbol == ''
                ? Row(
                    children: [],
                  )
                : Row(
                    mainAxisAlignment: MainAxisAlignment.center,

                    // mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.network(
                        img,
                        height: 75.h,
                      ).cornerRadiusWithClipRRect(50),
                      15.w.toInt().width,
                      Text(
                        "\$150",
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
                      Container(
                        decoration: BoxDecoration(
                          color: ColorConfig.appBar,
                          borderRadius: BorderRadius.only(
                              topLeft: radiusCircular(10.r),
                              topRight: radiusCircular(10.r),
                              bottomRight: radiusCircular(10.r)),
                        ),
                        height: 30.h,
                        width: (23 * tp.length).w,
                        child: Text(
                          '\$$tp',
                          style: TextStyle(
                            fontSize: 15.sp,
                            // color: ColorConfig.iconColor,
                          ),
                        ).center(),
                      ),
                      //Container(),
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
                    '',
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
                    '',
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
