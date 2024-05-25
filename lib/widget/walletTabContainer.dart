import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:smartbet/utils/config/color.dart';
import 'package:smartbet/widget/connectWallet.dart';

class walletTabContainer extends StatelessWidget {
  const walletTabContainer(
      {super.key,
      this.wallet,
      this.width,
      this.height,
      this.imgSize,
      this.ellipsisWidth,
      this.inputcontroller,
      required this.isConnected});
  final String? wallet;
  final double? width;
  final double? height;
  final double? imgSize;
  final double? ellipsisWidth;
  final bool isConnected;
  final TextEditingController? inputcontroller;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: height ?? 45,
      width: SizeConfig.screenWidth! <= 450 ? 300.w : 400,
      decoration: BoxDecoration(
        color: Color.fromARGB(255, 19, 27, 93).withOpacity(0.4),
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Row(children: [
        9.width,
        Icon(
          Icons.wallet,
          color: ColorConfig.iconColor,
        ),
        9.width,
        Container(
          width: SizeConfig.screenWidth! <= 375
              ? 190.w
              : SizeConfig.screenWidth! <= 450
                  ? 200.w
                  : 300,
          child: Text(
            wallet ?? 'Connect your wallet address',
            style: TextStyle(
              //  fontFamily: AppFont.euclidCircularARegular,
              fontSize: 14.sp,
              color: const Color(0xFF9FA4BC),
            ),
            overflow: TextOverflow.ellipsis,
          ),
        ),
        0.width.expand(),
        isConnected
            ? Image.network(
                "https://assets.coingecko.com/coins/images/825/large/bnb-icon2_2x.png?1696501970",
                //   color: imgcolor,
                width: imgSize ?? 35,
                height: imgSize ?? 35,
              )
            : Icon(
                Icons.account_balance_wallet_rounded,
                color: ColorConfig.iconColor,
              ).onTap(() {
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
        SizeConfig.screenWidth! <= 450 ? 10.w.toInt().width : 10.width,
      ]),
    );
  }
}
