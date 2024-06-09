import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:smartbet/utils/config/color.dart';
import 'package:smartbet/utils/config/size.dart';
import 'package:smartbet/widget/comingSoon.dart';
import 'package:smartbet/widget/soccerWidget.dart';

class FootBallDesktopScreen extends StatefulWidget {
  const FootBallDesktopScreen({super.key});

  @override
  State<FootBallDesktopScreen> createState() => _FootBallDesktopScreenState();
}

class _FootBallDesktopScreenState extends State<FootBallDesktopScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorConfig.scaffold,
      body: false
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Lottie.asset(
                    "assets/images/baller.json",
                    // height: 160,
                    // width: 160,
                  ),
                  comingSoon()
                ],
              ),
            )
          : Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
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
                      "TV",
                      style: TextStyle(
                          fontSize: 16.sp,
                          color: ColorConfig.iconColor,
                          fontWeight: FontWeight.w500),
                    ),
                    45.height,
                    CircleAvatar(
                        radius: 30,
                        backgroundColor: ColorConfig.appBar,
                        child: Center(
                          child: Icon(
                            Icons.history,
                            size: 25,
                            color: ColorConfig.iconColor,
                          ),
                        )),
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
                40.width,
                SingleChildScrollView(
                  child: Column(
                    children: [
                      ...List.generate(
                        6,
                        (index) => soccerConatainer(
                          homeclubName: 'Chelsea',
                          homeLogo:
                              "https://www.edigitalagency.com.au/wp-content/uploads/Chelsea-Football-Club-logo-png.png",
                          homeOdds: '1.35x',
                          drawOdds: "1.35x",
                          awayclubName: 'Manchester City',
                          awayLogo:
                              "https://www.edigitalagency.com.au/wp-content/uploads/Manchester-City-FC-logo-png-badge.png",
                          awayOdds: "1.35x",
                        ),
                      )
                    ],
                  ).paddingTop(20).paddingRight(SizeConfigs.screenWidth == 800
                      ? 50
                      : SizeConfigs.screenWidth <= 1000
                          ? 45
                          : 100),
                )
              ],
            ),
    );
  }
}

class soccerConatainer extends StatelessWidget {
  soccerConatainer(
      {super.key,
      this.homeclubName = "",
      this.awayclubName = "",
      this.awayLogo = "",
      this.homeLogo = "",
      this.homeOdds = "",
      this.awayOdds = "",
      this.drawOdds = "",
      this.isCenter = false,
      this.date = "23-03-2023",
      this.time = "20:45:00",
      this.homeState = ''});

  final String homeclubName;
  final String homeState;
  final String homeLogo;
  final String homeOdds;
  final String awayLogo;
  final String awayclubName;
  final String awayOdds;
  final String drawOdds;

  final bool isCenter;
  final String date;
  final String time;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 606,
      height: 250,
      color: Colors.transparent,
      child: Row(
        children: [
          DataContainer(
            clubName: homeclubName,
            logo: homeLogo,
            odds: homeOdds,
            state: "home",
          ).withHeight(250).withWidth(200).paddingRight(3),
          DataContainer(
            odds: drawOdds,
            state: "draw",
            isCenter: true,
          ).paddingRight(3),
          DataContainer(
            clubName: awayclubName,
            logo: awayLogo,
            odds: awayOdds,
            state: "away",
          ).withHeight(250).withWidth(200),
          // Container(
          //   decoration: BoxDecoration(color: ColorConfig.appBar),
          // ).withHeight(250).withWidth(200)
        ],
      ),
    ).paddingBottom(20);
  }
}
