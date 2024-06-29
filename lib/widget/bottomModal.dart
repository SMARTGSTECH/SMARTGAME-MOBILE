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
          height: 400.h,
          width: double.infinity,
          child: SingleChildScrollView(
            child: Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: 13.toInt().w, vertical: 10.h),
                child: Column(
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

walletcard(List array, type) {
  return Card(
    color: ColorConfig.appBar.withOpacity(0.5),
    elevation: 1,
    child: ListTile(
      leading: CircleAvatar(
          backgroundColor: Colors.transparent,
          backgroundImage: NetworkImage(array
              .where((element) => element.symbol.toLowerCase() == type)
              .first
              .imageUrl
              .toString())),
      title: Text("${"0x78E0f1CC471885947b13WYD".substring(0, 25)}...."),
      subtitle: const Text(
        "SOL: \$20",
        style: TextStyle(fontWeight: FontWeight.bold),
      ),
      trailing: Icon(Icons.wallet, color: ColorConfig.iconColor),
    ),
  );
}
