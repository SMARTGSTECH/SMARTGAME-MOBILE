import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:smartbet/utils/config/color.dart';

class DataContainer extends StatelessWidget {
  const DataContainer(
      {super.key,
      this.clubName = "",
      this.logo = "",
      this.odds = "",
      this.state = "",
      this.isCenter = false,
      this.date = "23-03-2023",
      this.time = "20:45:00"});
  final String clubName;
  final String logo;
  final String odds;
  final String state;
  final bool isCenter;
  final String date;
  final String time;

  @override
  Widget build(BuildContext context) {
    return isCenter
        ? Container(
            decoration: BoxDecoration(
              color: ColorConfig.appBar,
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(20.0), // Curved top left corner
                bottomRight:
                    Radius.circular(20.0), // Curved bottom right corner
              ),
            ),
            child: Column(
              ///mainAxisAlignment: MainAxisAlignment.center,
              children: [
                40.height,
                Icon(
                  Icons.sports_soccer,
                  size: 35,
                ),
                10.height,
                Text(
                  time,
                  style: TextStyle(
                    color: ColorConfig.iconColor,
                    fontSize: 15.sp,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                10.height,
                Text(
                  "VS",
                  style: TextStyle(
                    color: ColorConfig.iconColor,
                    fontSize: 20.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                10.height,
                Text(
                  date,
                  style: TextStyle(
                    color: ColorConfig.iconColor,
                    fontSize: 15.sp,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                0.height.expand(),
                OddsContainer(
                  odds: odds,
                  state: state,
                ),
              ],
            ),
          ).withHeight(250).withWidth(200)
        : Container(
            decoration: BoxDecoration(
              color: ColorConfig.appBar,
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(20.0), // Curved top left corner
                bottomRight:
                    Radius.circular(20.0), // Curved bottom right corner
              ),
            ),
            //Button Container
            child: Stack(alignment: Alignment.bottomCenter, children: [
              Column(
                children: [
                  10.height,
                  Container(
                    height: 130,
                    width: 130,
                    decoration: BoxDecoration(
                        border: Border.all(color: ColorConfig.lightBoarder),
                        color: Colors.transparent,
                        borderRadius: BorderRadius.circular(100),
                        image: DecorationImage(
                            image: NetworkImage(logo), fit: BoxFit.cover)),
                  ).paddingTop(11),
                  13.height,
                  Text(
                    clubName,
                    style: TextStyle(
                      color: ColorConfig.iconColor,
                      fontSize: 15.sp,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  0.height.expand(),
                  OddsContainer(
                    odds: odds,
                    state: state,
                  ),
                ],
              )
            ]),
          );
  }
}

class OddsContainer extends StatelessWidget {
  const OddsContainer({
    super.key,
    required this.odds,
    required this.state,
  });
  final String odds;
  final String state;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      width: 200,
      decoration: BoxDecoration(
        color: ColorConfig.yellow,
        borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(20.0), // Curved top left corner
          bottomRight: Radius.circular(20.0), // Curved bottom right corner
        ),
      ),
      child: Column(
        //  mainAxisAlignment:
        children: [
          13.height,
          Text(
            state.toUpperCase(),
            style: TextStyle(
              color: Colors.black87,
              fontSize: 13.sp,
              fontWeight: FontWeight.w600,
            ),
          ),
          3.height,
          Text(
            odds,
            style: TextStyle(
              color: Colors.black,
              fontSize: 19.sp,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
