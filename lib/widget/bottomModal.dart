import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:provider/provider.dart';
import 'package:smartbet/screens/home/provider.dart';
import 'package:smartbet/utils/config/color.dart';
import 'package:smartbet/walletConnect/provider.dart';

class ReusableBottomModal extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final coinP = Provider.of<CoinCapProvider>(context, listen: false);
    return Consumer<UserWeb3Provider>(
      builder: (BuildContext context, model, _) {
        return Container(
          decoration: BoxDecoration(
            // borderRadius: BorderRadius.circular(20.r),
            color: ColorConfig.scaffold,
          ),
          height: 220.h,
          width: double.infinity,
          child: SingleChildScrollView(
            child: Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: 13.toInt().w, vertical: 10.h),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(
                      model.chainIMG.length,
                      (index) => walletcard(
                          coinP.coinArray, model.chainIMG[index], model)),
                )),
          ),
        );
      },
    );
  }
}

walletcard(List array, type, UserWeb3Provider walletnstance) {
  return Card(
    color: ColorConfig.appBar.withOpacity(0.5),
    elevation: 1,
    child: ListTile(
      leading: Stack(
        children: [
          CircleAvatar(
              backgroundColor: Colors.transparent,
              backgroundImage: NetworkImage(array
                  .where((element) => element.symbol.toLowerCase() == type)
                  .first
                  .imageUrl
                  .toString())),
          type.toLowerCase() == "eth"
              ? Container(
                  width: 30.w,
                  // color: Colors.red,
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        CircleAvatar(
                            radius: 7.5.r,
                            backgroundColor: Colors.transparent,
                            backgroundImage: NetworkImage(
                                'https://static.particle.network/token-list/base/native.png')),
                        CircleAvatar(
                            radius: 7.5.r,
                            backgroundColor: Colors.transparent,
                            backgroundImage: NetworkImage(
                                'https://static.particle.network/token-list/bsc/native.png'))
                      ]),
                )
              : Text("")
        ],
      ),
      title: walletnstance.walletInstanceMap[type.toLowerCase()]!['isConnected']
          ? Text(
              "${"${walletnstance.walletInstanceMap[type.toLowerCase()]!['address']}".substring(0, 25)}....",
              style: TextStyle(fontSize: 14.sp),
            )
          : Text(
              "Connect Wallet",
              style: TextStyle(fontSize: 14.sp),
            ),
      subtitle: walletnstance
              .walletInstanceMap[type.toLowerCase()]!['isConnected']
          ? type.toLowerCase() == "eth"
              ? Row(children: [
                  Text(
                    "${type.toUpperCase()}: \$20",
                    style:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 13.sp),
                  ),
                  3.w.toInt().width,
                  Text(
                    "${type.toUpperCase()}: \$20",
                    style:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 13.sp),
                  )
                ])
              : Text(
                  "${type.toUpperCase()}: \$20",
                  style:
                      TextStyle(fontWeight: FontWeight.bold, fontSize: 13.sp),
                )
          : Text(
              "${type.toUpperCase()}: \$N/A",
              style: TextStyle(fontSize: 14.sp),
            ),
      trailing: Icon(
              walletnstance
                      .walletInstanceMap[type.toLowerCase()]!['isConnected']
                  ? Icons.power_settings_new_sharp
                  : Icons.wallet,
              color: walletnstance
                      .walletInstanceMap[type.toLowerCase()]!['isConnected']
                  ? ColorConfig.red
                  : ColorConfig.iconColor)
          .onTap(
              walletnstance.walletInstanceMap[type.toLowerCase()]!['method']),
    ),
  );
}
//      trailing: Icon(type.toLowerCase() == "eth" ? walletnstance.evm["isConnected"]? Icons.power_settings_new_sharp :Icons.power_settings_new_sharp , color: ColorConfig.red),
