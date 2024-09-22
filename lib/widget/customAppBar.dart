import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:provider/provider.dart';
import 'package:smartbet/constants/strings.dart';
import 'package:smartbet/screens/car/provider.dart';
import 'package:smartbet/screens/fruit/provider.dart';
import 'package:smartbet/screens/wallet_modals/create_wallet.dart';
import 'package:smartbet/screens/wallet_modals/wallet.dart';
import 'package:smartbet/services/storage.dart';
import 'package:smartbet/shared/modal_sheet.dart';
import 'package:smartbet/utils/config/color.dart';
import 'package:smartbet/walletConnect/wallet_provider.dart';
import 'package:smartbet/widget/connectWallet.dart';





AppBar customAppbar(BuildContext context) {
  Web3Provider web3provider = Provider.of<Web3Provider>(context, listen: false);
  return AppBar(
    elevation: 10,
    actions: [
      Icon(
        Icons.account_balance_wallet_rounded,
        color: ColorConfig.iconColor,
      ).paddingRight(35.w).onTap(() async {
        web3provider.setContext(context);
        String data = await Storage.readData(WALLET_MNEMONICS) ?? "";
        if (data.isNotEmpty) {
          modalSetup(
            context,
            modalPercentageHeight: 0.9,
            createPage: const UserWallet(),
            showBarrierColor: true,
          );
        } else {
          modalSetup(
            context,
            modalPercentageHeight: 0.6,
            createPage: const CreateWallet(),
            showBarrierColor: true,
          );
        }
        // showDialog(
        //   context: context,
        //   barrierDismissible: false,
        //   builder: (BuildContext context) {
        //     return Dialog(
        //       shadowColor: ColorConfig.blue,
        //       // shape: CircleBorder(),
        //       backgroundColor: Colors.transparent,
        //       elevation: 10,
        //       child: walletContainer(),
        //     );
        //   },
        // );
      }),
    ],
    centerTitle: true,
    title: Text(
      "SmartGame",
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
      "SmartGame",
      style: TextStyle(
        color: ColorConfig.iconColor,
        fontSize: 18.sp,
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
