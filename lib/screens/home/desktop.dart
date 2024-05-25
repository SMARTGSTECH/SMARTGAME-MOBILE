import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:provider/provider.dart';
import 'package:smartbet/screens/car/desktop.dart';
import 'package:smartbet/screens/coin/desktop.dart';
import 'package:smartbet/screens/dice/desktop.dart';
import 'package:smartbet/screens/fruit/desktop.dart';
import 'package:smartbet/screens/home/components/cryptodata.dart';
import 'package:smartbet/screens/home/components/imageCarousel.dart';
import 'package:smartbet/screens/home/provider.dart';
import 'package:smartbet/utils/config/color.dart';
import 'package:smartbet/utils/config/size.dart';
import 'package:smartbet/widget/alertSnackBar.dart';
import 'package:smartbet/widget/button.dart';
import 'package:smartbet/widget/coinsTracker.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class DesktopHomeScreen extends StatefulWidget {
  const DesktopHomeScreen({super.key});

  @override
  State<DesktopHomeScreen> createState() => _DesktopHomeScreenState();
}

// const boxH = 22;
// const boxW = 50;

const boxH = 17;
const boxW = 40;

const colboxH = 15;
const colBoxW = 25;
const cBoxH = 34;
const cBoxW = 25;

class _DesktopHomeScreenState extends State<DesktopHomeScreen> {
  @override
  void initState() {
    // TODO: implement initState

    Provider.of<CoinCapProvider>(context, listen: false).fetchCoin();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorConfig.scaffold,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Responsive(mobile: mobile)
                  Container(
                    height: SizeConfigs.screenWidth >= 650
                        ? 355
                        : SizeConfigs.screenWidth >= 800
                            ? 350
                            : SizeConfigs.getPercentageHeight(35),
                    width: (SizeConfigs.screenWidth >= 650 &&
                            SizeConfigs.screenWidth < 800)
                        ? 630
                        : SizeConfigs.screenWidth >= 800
                            ? 680
                            : SizeConfigs.getPercentageWidth(93),

                    // decoration: BoxDecoration(
                    //   border: Border.all(color: ColorConfig.lightBoarder),
                    //   color: Colors.transparent,
                    //   borderRadius: BorderRadius.circular(4),
                    //   // image: DecorationImage(
                    //   //     image: NetworkImage(
                    //   //         "https://webadmin.smartcryptobet.co/images/ads/20231211090836.png"),
                    //   //     fit: BoxFit.cover)
                    // ),
                    // ).

                    child: HomeImageCarousel(),
                  ),
                ],
              ),
              15.height,
              // false
              //     ? Container()
              //     : AnimatedSmoothIndicator(
              //         activeIndex: 0,
              //         count: 0,
              //         effect: WormEffect(
              //           activeDotColor: Colors.yellow,
              //           dotColor: Colors.grey,
              //           dotHeight: 10,
              //           dotWidth: 10,
              //         ),
              //       ),
              17.height,
              //this s the container
              Consumer<CoinCapProvider>(
                builder: (BuildContext context, provider, _) {
                  return provider.coinArray.isEmpty
                      ? Lottie.asset(
                          "assets/images/beiLoader.json",
                          height: 80,
                          width: 80,
                        )
                      : Container(
                          // decoration: BoxDecoration(
                          //   border: Border.all(
                          //       //  color: ColorConfig.lightBoarder //made a change here
                          //       ),
                          //   // color: Colors.red,
                          //   borderRadius: BorderRadius.circular(8),
                          // ),
                          height: SizeConfigs.getPercentageHeight(
                              12), //made a change here, changed from 12 to 9
                          width: SizeConfig.screenWidth! <= 700
                              ? SizeConfigs.getPercentageWidth(93)
                              : SizeConfig.screenWidth! < 800
                                  ? SizeConfigs.getPercentageWidth(94)
                                  : 790,
                          //   width: SizeConfigs.getPercentageHeight(98),
                          child: CarouselSlider(
                            items: [
                              ...List.generate(
                                provider.coinArray.length,
                                (index) => coincard(
                                  name: provider.coinArray[index].name,
                                  symbol: provider.coinArray[index].symbol,
                                  rank: provider.coinArray[index].rank.toInt(),
                                  imageUrl: provider.coinArray[index].imageUrl,
                                  price: provider.coinArray[index].price
                                      .toDouble(),
                                  change: provider
                                      .coinArray[index].changePercentage
                                      .toDouble(),
                                  changePercentage: provider
                                      .coinArray[index].changePercentage
                                      .toDouble(),
                                ),
                              )
                            ],
                            options: CarouselOptions(
                              autoPlay: true,
                              height: 200,
                              autoPlayInterval: const Duration(seconds: 4),
                              enableInfiniteScroll: true,
                            ),
                          ),
                        );
                },
              ),
              SizeConfig.screenWidth! < 1000 ? 18.height : 14.height,
              (SizeConfig.screenWidth! >= 800)
                  ? Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Column(
                          children: [
                            Hcontainer(
                              routeFunction: () {
                                print("here");
                                CarDesktopScreen(
                                  directLaunch: true,
                                ).launch(context,
                                    pageRouteAnimation:
                                        PageRouteAnimation.Fade);
                              },
                              isDesktop: true,
                              name: AppImageDetails.carname,
                              width: 285,
                              height: 125,

                              // imgHeight: 120,
                              // imgWidth: 135,
                              padding: 8,
                            ),
                            Hcontainer(
                              routeFunction: () {
                                DiceDesktopScreen(
                                  directLaunch: true,
                                ).launch(context,
                                    pageRouteAnimation:
                                        PageRouteAnimation.Fade);
                              },
                              isDesktop: true,
                              name: AppImageDetails.dicename,
                              img: AppImageDetails.dice,
                              width: 285,
                              height: 125,
                              // imgHeight: 120,
                              // imgWidth: 135,
                            ),
                          ],
                        ),
                        7.width,
                        Column(
                          children: [
                            Hcontainer(
                              routeFunction: () {
                                CustomSnackBar(
                                    leftColor: ColorConfig.yellow,
                                    //  icon: Icon(),
                                    context: context,
                                    message: "Coming Soon",
                                    width: 165);
                              },
                              isColumn: true,
                              isDesktop: true,
                              name: AppImageDetails.footballname,
                              img: AppImageDetails.pitch2,
                              width: 199,
                              height: 259,
                              // imgHeight: 120,
                              imgWidth: 199,
                            ),
                          ],
                        ),
                        7.width,
                        Column(
                          children: [
                            Hcontainer(
                              routeFunction: () {
                                FruitDesktopScreen(
                                  directLaunch: true,
                                ).launch(context,
                                    pageRouteAnimation:
                                        PageRouteAnimation.Fade);
                              },
                              arrange: true,
                              isDesktop: true,
                              name: AppImageDetails.fruitname,
                              img: AppImageDetails.fruit,
                              width: 285,
                              height: 125,
                              // imgHeight: 120,
                              // imgWidth: 145,
                              padding: 8,
                            ),
                            Hcontainer(
                              isDesktop: true,
                              arrange: true,
                              routeFunction: () {
                                CoinDesktopScreen(
                                  directLaunch: true,
                                ).launch(context,
                                    pageRouteAnimation:
                                        PageRouteAnimation.Fade);
                              },
                              name: AppImageDetails.coinname,
                              img: AppImageDetails.coin,
                              width: 285,
                              height: 125,
                              // imgHeight: 120,
                              // imgWidth: 135,
                            ),
                          ],
                        ),
                      ],
                    )
                  : TabletHomeContainer(),
            ],
          ),
        ).paddingTop(8),
      ),
      // appBar: AppBar(
      //   backgroundColor: ColorConfig.appBar,
      //   l
      // ),
    );
  }
}

class TabletHomeContainer extends StatelessWidget {
  const TabletHomeContainer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Hcontainer(
          img: AppImageDetails.pitch2,
          name: AppImageDetails.footballname,
        ),
        Hcontainer(
          img: AppImageDetails.coin,
          name: AppImageDetails.coinname,
        ),
        Hcontainer(
          img: AppImageDetails.car,
          name: AppImageDetails.carname,
        ),
        Hcontainer(
          img: AppImageDetails.dice,
          name: AppImageDetails.dicename,
        ),
        Hcontainer(
          name: AppImageDetails.fruitname,
          img: AppImageDetails.fruit,
        ),
      ],
    );
  }
}

class Hcontainer extends StatelessWidget {
  Hcontainer(
      {super.key,
      this.height = 18,
      this.width = 93,
      this.img = AppImageDetails.car,
      this.isDesktop = false,
      required this.name,
      this.imgHeight = 125,
      this.imgWidth = 153,
      this.isColumn = false,
      this.padding = 15,
      this.arrange = false,
      this.routeFunction});
  final int height;
  final int width;
  final int imgHeight;
  final int imgWidth;
  final String img;
  final String name;
  final bool isDesktop;
  final bool isColumn;
  final double padding;
  final bool arrange;
  final VoidCallback? routeFunction;
  @override
  Widget build(BuildContext context) {
    if (arrange) {
      return Container(
        decoration: boxDecorationWithRoundedCorners(
            backgroundColor: Colors.black12,
            border: Border.all(color: ColorConfig.lightBoarder),
            borderRadius: BorderRadius.circular(4)),
        height: isDesktop
            ? height.toDouble()
            : SizeConfigs.getPercentageHeight(height),
        width: isDesktop
            ? width.toDouble()
            : SizeConfigs.getPercentageWidth(width),
        child: Row(
          children: [
            Container(
              color: Colors.transparent,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    name,
                    style: primaryTextStyle(
                        color: ColorConfig.iconColor,
                        size: 17.sp.toInt(),
                        weight: FontWeight.bold),
                  ),
                  10.h.toInt().height,
                  CustomAppButton(
                    text: 'Play Now',
                    onPressed: routeFunction ??
                        () {
                          print(name);
                        },
                    color: ColorConfig.yellow,
                    textColor: Colors.white,
                    borderRadius: 4.r,
                    height: SizeConfigs.screenWidth >= 800 ? 23 : 30,
                    size: 14,
                    width: 80,
                    padding: EdgeInsets.symmetric(
                        horizontal: SizeConfigs.getPercentageWidth(2),
                        vertical: SizeConfigs.getPercentageHeight(2)),
                  )
                ],
              ),
            ).expand(),
            Container(
                height: imgHeight.toDouble(),
                width: imgWidth.toDouble(),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(4),
                    gradient: LinearGradient(
                      colors: [
                        (img == AppImageDetails.coin ||
                                img == AppImageDetails.dice)
                            ? Colors.red
                            : Colors.transparent,
                        (img == AppImageDetails.coin ||
                                img == AppImageDetails.dice)
                            ? Colors.orange
                            : Colors.transparent,
                      ],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                    ),
                    image: DecorationImage(
                        fit: img == AppImageDetails.coin
                            ? BoxFit.fitHeight
                            : BoxFit.cover,
                        image: AssetImage(img)))),
          ],
        ),
      ).paddingBottom(padding);
    }
    return Container(
      decoration: boxDecorationWithRoundedCorners(
          backgroundColor: Colors.black12,
          border: Border.all(color: ColorConfig.lightBoarder),
          borderRadius: BorderRadius.circular(4)),
      height: isDesktop
          ? height.toDouble()
          : SizeConfigs.getPercentageHeight(height),
      width:
          isDesktop ? width.toDouble() : SizeConfigs.getPercentageWidth(width),
      child: isColumn
          ? Column(
              children: [
                Container(
                        height: imgHeight.toDouble(),
                        width: imgWidth.toDouble(),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(4),
                            gradient: LinearGradient(
                              colors: [
                                (img == AppImageDetails.coin ||
                                        img == AppImageDetails.dice)
                                    ? Colors.red
                                    : Colors.transparent,
                                (img == AppImageDetails.coin ||
                                        img == AppImageDetails.dice)
                                    ? Colors.orange
                                    : Colors.transparent,
                              ],
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                            ),
                            image: DecorationImage(
                                fit: img == AppImageDetails.coin
                                    ? BoxFit.fitHeight
                                    : BoxFit.cover,
                                image: AssetImage(img))))
                    .expand(),
                Expanded(
                    child: Container(
                  color: Colors.transparent,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        name,
                        style: primaryTextStyle(
                            color: ColorConfig.iconColor,
                            size: 17.sp.toInt(),
                            weight: FontWeight.bold),
                      ),
                      10.h.toInt().height,
                      CustomAppButton(
                        text: 'Play Now',
                        onPressed: routeFunction ??
                            () {
                              print(name);
                            },
                        color: ColorConfig.yellow,
                        textColor: Colors.white,
                        borderRadius: 4.r,
                        height: 23,
                        size: 14,
                        width: 80,
                        padding: EdgeInsets.symmetric(
                            horizontal: SizeConfigs.getPercentageWidth(2),
                            vertical: SizeConfigs.getPercentageHeight(2)),
                      )
                    ],
                  ),
                ))
              ],
            )
          : Row(
              children: [
                isDesktop
                    ? Container(
                        height: imgHeight.toDouble(),
                        width: imgWidth.toDouble(),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(4),
                            gradient: LinearGradient(
                              colors: [
                                (img == AppImageDetails.coin ||
                                        img == AppImageDetails.dice)
                                    ? Colors.red
                                    : Colors.transparent,
                                (img == AppImageDetails.coin ||
                                        img == AppImageDetails.dice)
                                    ? Colors.orange
                                    : Colors.transparent,
                              ],
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                            ),
                            image: DecorationImage(
                                fit: img == AppImageDetails.coin
                                    ? BoxFit.fitHeight
                                    : BoxFit.cover,
                                image: AssetImage(img))))
                    : Container(
                        height: SizeConfigs.getPercentageHeight(20),
                        width: SizeConfigs.screenWidth < 500
                            ? SizeConfigs.getPercentageHeight(27)
                            : SizeConfigs.getPercentageHeight(30),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(4),
                            gradient: LinearGradient(
                              colors: [
                                (img == AppImageDetails.coin ||
                                        img == AppImageDetails.dice)
                                    ? Colors.red
                                    : Colors.transparent,
                                (img == AppImageDetails.coin ||
                                        img == AppImageDetails.dice)
                                    ? Colors.orange
                                    : Colors.transparent,
                              ],
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                            ),
                            image: DecorationImage(
                                fit: img == AppImageDetails.coin
                                    ? BoxFit.fitHeight
                                    : BoxFit.cover,
                                image: AssetImage(img)))),
                Expanded(
                    child: Container(
                  color: Colors.transparent,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        name,
                        style: primaryTextStyle(
                            color: ColorConfig.iconColor,
                            size: 17.sp.toInt(),
                            weight: FontWeight.bold),
                      ),
                      10.h.toInt().height,
                      CustomAppButton(
                        text: 'Play Now',
                        onPressed: routeFunction ??
                            () {
                              print(name);
                            },
                        color: ColorConfig.yellow,
                        textColor: Colors.white,
                        borderRadius: 4.r,
                        height: SizeConfigs.screenWidth >= 800 ? 23 : 30,
                        size: 14,
                        width: 80,
                        padding: EdgeInsets.symmetric(
                            horizontal: SizeConfigs.getPercentageWidth(2),
                            vertical: SizeConfigs.getPercentageHeight(2)),
                      )
                    ],
                  ),
                ))
              ],
            ),
    ).paddingBottom(padding);
  }
}

// Row(
//               children: [
//                 Container(
//                   decoration: boxDecorationWithRoundedCorners(
//                       borderRadius: BorderRadius.circular(3)),
//                   height: 220.w,
//                   width: 600.w,
//                 ),
//                 Container(
//                   decoration: boxDecorationWithRoundedCorners(
//                       borderRadius: BorderRadius.circular(3)),
//                   height: 220.w,
//                   width: 600.w,
//                 )
//               ],
//             ),
//             8.height,
//             Row(
//               children: [
//                 Container(
//                   decoration: boxDecorationWithRoundedCorners(
//                       borderRadius: BorderRadius.circular(3)),
//                   height: 220.w,
//                   width: 600.w,
//                 ),
//                 Container(
//                   decoration: boxDecorationWithRoundedCorners(
//                       borderRadius: BorderRadius.circular(3)),
//                   height: 220.w,
//                   width: 600.w,
//                 )
//               ],
//             )
