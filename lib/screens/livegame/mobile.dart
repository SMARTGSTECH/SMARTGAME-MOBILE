import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:provider/provider.dart';
import 'package:smartbet/screens/coin/mobile.dart';
import 'package:smartbet/screens/home/provider.dart';
import 'package:smartbet/screens/liveEvent/liveEvent_view.dart';
import 'package:smartbet/screens/livegame/provider.dart';
import 'package:smartbet/screens/smartTrade/smartTrade_view.dart';
import 'package:smartbet/utils/config/color.dart';
import 'package:smartbet/widget/comingSoon.dart';
import 'package:smartbet/widget/customGridview.dart';
import 'package:smartbet/widget/gridContainer.dart';

class LiveGameMobileScreen extends StatefulWidget {
  const LiveGameMobileScreen({super.key});

  @override
  State<LiveGameMobileScreen> createState() => _LiveGameMobileScreenState();
}

class _LiveGameMobileScreenState extends State<LiveGameMobileScreen> {
  @override
  Widget build(BuildContext context) {
    return Consumer<LiveEventProvider>(
      builder: (BuildContext context, model, _) {
        return SingleChildScrollView(
          physics: model.selectedTab == 0
              ? NeverScrollableScrollPhysics()
              : BouncingScrollPhysics(),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(11.0),
                child: Column(
                  children: [
                    Container(
                      padding: EdgeInsetsDirectional.all(4),
                      height: 40.h,
                      width: 340.w,
                      decoration: BoxDecoration(
                          color: ColorConfig.appBar,
                          borderRadius: BorderRadius.circular(10)),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          ...List.generate(
                              model.tabItemHeader.length,
                              (index) => TabCard(
                                    isActive: model.selectedTab == index
                                        ? true
                                        : false,
                                    title: model.tabItemHeader[index],
                                    action: () {
                                      index == 2
                                          ? toast("COMING SOON",
                                              bgColor: ColorConfig.yellow)
                                          : model.toggleTab(index);
                                    },
                                  )),
                        ],
                      ),
                    ),
                    // QuadrantBox(),
                    model.selectedTab == 0 ? 70.h.toInt().height : Container(),
                    SizedBox(
                      height: SizeConfig.screenHeight! * 0.75,
                      width: double.infinity,
                      child: model.selectedTab == 0
                          ? CustomGridView(
                              itemCount: model.selectedTab == 0 ? 4 : 30,
                              crossAxisCount: 2,
                              crossAxisSpacing: 10.0,
                              mainAxisSpacing: 10.0,
                              itemBuilder: (context, index) {
                                final coinP = Provider.of<CoinCapProvider>(
                                  context,
                                  listen: false,
                                );
                                // print(coinP.coinArray
                                //     .where((element) =>
                                //         element.symbol.toLowerCase() == "ton")
                                //     .first
                                //     .imageUrl);
                                // String dataImg = coinP.coinArray
                                //     .where((element) =>
                                //         element.symbol.toLowerCase() == "sol")
                                //     .first
                                //     .imageUrl;
                                return ExpandedWidget(
                                  symbol: coinP.coinArray
                                      .where((element) =>
                                          element.symbol.toLowerCase() ==
                                          model.stGrid[index])
                                      .first
                                      .symbol
                                      .toUpperCase(),
                                  img: coinP.coinArray
                                      .where((element) =>
                                          element.symbol.toLowerCase() ==
                                          model.stGrid[index])
                                      .first
                                      .imageUrl,
                                  text: "\$106.85 Available",
                                  onTapFuntion: () {
                                    SmartTradeMobileScreen(
                                      symbol: coinP.coinArray
                                          .where((element) =>
                                              element.symbol.toLowerCase() ==
                                              model.stGrid[index])
                                          .first
                                          .symbol
                                          .toUpperCase(),
                                      img: coinP.coinArray
                                          .where((element) =>
                                              element.symbol.toLowerCase() ==
                                              model.stGrid[index])
                                          .first
                                          .imageUrl,
                                    ).launch(context,
                                        pageRouteAnimation:
                                            PageRouteAnimation.Fade);
                                    // text2.toLowerCase() == "Dice".toLowerCase()
                                    //     ? DiceMobileScreen().launch(context,
                                    //         pageRouteAnimation: PageRouteAnimation.Fade)
                                    //     : FruitMobileScreen().launch(context,
                                    //         pageRouteAnimation: PageRouteAnimation.Fade);
                                  },
                                  count: index.toString(),
                                );
                              },
                            )
                          : model.activeLiveGame == []
                              ? Center(child: Text("No game active"))
                              : CustomGridView(
                                  itemCount: model.selectedTab == 0
                                      ? 4
                                      : model.activeLiveGame.length,
                                  crossAxisCount: 2,
                                  crossAxisSpacing: 10.0,
                                  mainAxisSpacing: 10.0,
                                  itemBuilder: (context, index) {
                                    final coinP = Provider.of<CoinCapProvider>(
                                        context,
                                        listen: false);
                                    print(coinP.coinArray
                                        .where((element) =>
                                            element.symbol.toLowerCase() ==
                                            "ton")
                                        .first
                                        .imageUrl);
                                    String dataImg = coinP.coinArray
                                        .where((element) =>
                                            element.symbol.toLowerCase() ==
                                            "sol")
                                        .first
                                        .imageUrl;
                                    return ExpandedWidget(
                                      img: model.activeLiveGame[index]['image'],
                                      text: model.activeLiveGame[index]
                                          ['title'],
                                      onTapFuntion: () {
                                        final data =
                                            model.activeLiveGame[index];

                                        /// List activeOptionList =  model.activeLiveGame[index]
                                        List options = [
                                          data['optionone'],
                                          data['optiontwo'],
                                          data['optionthree'],
                                          data['optionfour'],
                                          data['optionfive'],
                                          data['optionsix'],
                                          data['optionseven'],
                                          data['optioneight'],
                                          data['optionnine'],
                                          data['optionten']
                                        ]
                                            .where(
                                                (option) => option.isNotEmpty)
                                            .toList();

                                        print(options);
                                        print(options.runtimeType);
                                        LiveEventMobileScreen(
                                          info: model.activeLiveGame[index]
                                              ['description'],
                                          symbol: '',
                                          img: model.activeLiveGame[index]
                                              ['image'],
                                          option: options,
                                          // img: coinP.coinArray
                                          //     .where((element) =>
                                          //         element.symbol
                                          //             .toLowerCase() ==
                                          //         model.stGrid[index])
                                          //     .first
                                          //     .imageUrl,
                                        ).launch(context);
                                        // text2.toLowerCase() == "Dice".toLowerCase()
                                        //     ? DiceMobileScreen().launch(context,
                                        //         pageRouteAnimation: PageRouteAnimation.Fade)
                                        //     : FruitMobileScreen().launch(context,
                                        //         pageRouteAnimation: PageRouteAnimation.Fade);
                                      },
                                      count: '03',
                                    );
                                  },
                                ),
                    ),
                    // 100.height
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

class TabCard extends StatelessWidget {
  final Function()? action;
  final bool isActive;
  final String title;
  const TabCard(
      {super.key, this.action, required this.isActive, required this.title});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: action,
        child: Container(
          height: 35.h,
          decoration: BoxDecoration(
              color: isActive ? ColorConfig.yellow : Colors.transparent,
              borderRadius: BorderRadius.circular(10)),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                textAlign: TextAlign.center,
                title,
                style: TextStyle(
                    color: isActive ? Colors.black : Colors.white,
                    fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
