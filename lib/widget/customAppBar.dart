import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:provider/provider.dart';
import 'package:smartbet/screens/car/provider.dart';
import 'package:smartbet/screens/fruit/provider.dart';
import 'package:smartbet/utils/config/color.dart';
import 'package:smartbet/widget/connectWallet.dart';

AppBar customAppbar(BuildContext context) {
  return AppBar(
    elevation: 10,
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
    leading: Consumer2<FruitStateProvider, CarStateProvider>(
      builder: (BuildContext context, fruit, car, _) {
        return Icon(
          Icons.arrow_back,
          color: ColorConfig.iconColor,
        ).onTap(() {
          fruit.audioPlayer.pause();
          car.audioPlayer.pause();
          car.togglePlayPauseButton(false);
          fruit.togglePlayPauseButton(false, context);
          finish(context);
        });
      },
    ),
    backgroundColor: ColorConfig.appBar,
  );
}

AppBar customAppbarNOWallet(BuildContext context) {
  return AppBar(
    elevation: 10,
    actions: [
      // Icon(
      //   Icons.account_balance_wallet_rounded,
      //   color: ColorConfig.iconColor,
      // ).paddingRight(35.w).onTap(() {
      //   showDialog(
      //     context: context,
      //     barrierDismissible: false,
      //     builder: (BuildContext context) {
      //       return Dialog(
      //         shadowColor: ColorConfig.blue,
      //         // shape: CircleBorder(),
      //         backgroundColor: Colors.transparent,
      //         elevation: 10,
      //         child: walletContainer(),
      //       );
      //     },
      //   );
      // }),
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
    leading: Consumer2<FruitStateProvider, CarStateProvider>(
      builder: (BuildContext context, fruit, car, _) {
        return Icon(
          Icons.arrow_back,
          color: ColorConfig.iconColor,
        ).onTap(() {
          fruit.audioPlayer.pause();
          car.audioPlayer.pause();
          car.togglePlayPauseButton(false);
          fruit.togglePlayPauseButton(false, context);
          finish(context);
        });
      },
    ),
    backgroundColor: ColorConfig.appBar,
  );
}
