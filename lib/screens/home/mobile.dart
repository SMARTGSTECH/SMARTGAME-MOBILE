import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:provider/provider.dart';
import 'package:smartbet/screens/car/mobile.dart';
import 'package:smartbet/screens/coin/mobile.dart';
import 'package:smartbet/screens/dice/mobile.dart';
import 'package:smartbet/screens/fruit/mobile.dart';
import 'package:smartbet/screens/home/components/imageCarousel.dart';
import 'package:smartbet/screens/home/provider.dart';
import 'package:smartbet/utils/config/color.dart';
import 'package:smartbet/utils/config/size.dart';
import 'package:smartbet/widget/alertSnackBar.dart';
import 'package:smartbet/widget/coinsTracker.dart';
import 'package:smartbet/widget/homeBox.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class HomeMobileScreen extends StatefulWidget {
  const HomeMobileScreen({super.key});

  @override
  State<HomeMobileScreen> createState() => _HomeMobileScreenState();
}

class _HomeMobileScreenState extends State<HomeMobileScreen> {
  @override
  void initState() {
    // TODO: implement initState

    Provider.of<CoinCapProvider>(context, listen: false).fetchCoin();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  //     color: Colors.amber,
                  height: 190.h,
                  width: 347.w,
                  // decoration: BoxDecoration(
                  //   border: Border.all(color: ColorConfig.lightBoarder),
                  //   color: Colors.transparent,
                  //   borderRadius: BorderRadius.circular(7.r),
                  // ),
                  child: HomeImageCarousel(),
                ).paddingTop(11.h),
              ],
            ),
            //4.h.toInt().height,
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
                                price:
                                    provider.coinArray[index].price.toDouble(),
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
                            // height: 150,
                            autoPlayInterval: const Duration(seconds: 4),
                            enableInfiniteScroll: true,
                          ),
                        ),
                      );
              },
            ),
            8.h.toInt().height,
            HomeContainerBox(
              // isFitted: true,
              name: AppImageDetails.footballname,
              img: AppImageDetails.pitch2,
              onTap: () {
                CustomSnackBar(
                    leftColor: ColorConfig.yellow,
                    //  icon: Icon(),
                    context: context,
                    message: "Coming Soon",
                    width: SizeConfigs.getPercentageWidth(38));
                print("m");
              },
            ),
            HomeContainerBox(
              isFitted: true,
              name: AppImageDetails.coinname,
              img: AppImageDetails.coin,
              onTap: () {
                CoinMobileScreen().launch(context);
              },
            ),
            HomeContainerBox(
              name: AppImageDetails.carname,
              img: AppImageDetails.car,
              onTap: () {
                print("m");
                CarMobileScreen().launch(context);
              },
            ),
            HomeContainerBox(
              isFitted: true,
              name: AppImageDetails.dicename,
              img: AppImageDetails.dice,
              onTap: () {
                DiceMobileScreen().launch(context);
                print("m");
              },
            ),
            HomeContainerBox(
              // isFitted: true,
              name: AppImageDetails.fruitname,
              img: AppImageDetails.fruit,
              onTap: () {
                FruitMobileScreen().launch(context);
                print("m");
              },
            ),
            90.h.toInt().height,
          ],
        ),
      ),
    );
  }
}
