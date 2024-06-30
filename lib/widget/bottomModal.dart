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
                      (index) =>
                          walletcard(coinP.coinArray, model.chainIMG[index])),
                )),
          ),
        );
      },
    );
  }
}

walletcard(List array, type, Map walletnstance) {
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
      title: Text(
        "${"0x78E0f1CC471885947b13WYD".substring(0, 25)}....",
        style: TextStyle(fontSize: 14.sp),
      ),
      subtitle: type.toLowerCase() == "eth"
          ? Row(children: [
              Text(
                "${type.toUpperCase()}: \$20",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13.sp),
              ),
              3.w.toInt().width,
              Text(
                "${type.toUpperCase()}: \$20",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13.sp),
              )
            ])
          : Text(
              "${type.toUpperCase()}: \$20",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13.sp),
            ),
      trailing: Icon(Icons.power_settings_new_sharp, color: ColorConfig.red),
    ),
  );
}
