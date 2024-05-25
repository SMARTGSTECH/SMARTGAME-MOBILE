import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:smartbet/utils/config/color.dart';

class balanceContainer extends StatelessWidget {
  const balanceContainer({
    super.key,
    required this.size,
    required this.balance,
    required this.currency,
  });

  final double? size;
  final String balance;
  final String currency;

  @override
  Widget build(BuildContext context) {
    print("this isnthe valeu");
    // print(double.parse("${}").toStringAsFixed(4));
    return Container(
      width: size != null ? size! / 2 : 240 / 2,
      height: 40,
      decoration: BoxDecoration(
        color: Color.fromARGB(255, 19, 29, 122).withOpacity(0.4),
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Row(
        children: [
          currency == "BNB" ? 9.width : 9.width,
          currency == "BNB"
              ? Image.network(
                  "https://assets.coingecko.com/coins/images/825/large/bnb-icon2_2x.png?1696501970",
                  //   color: imgcolor,
                  width: 20,
                  height: 20,
                ).paddingRight(4)
              : Image.network(
                  "https://assets.coingecko.com/coins/images/325/large/Tether.png?1696501661",
                  //   color: imgcolor,
                  width: 20,
                  height: 20,
                ).paddingRight(4),
          //currency == "BNB" ? 2.width : Container(),
          Container(
            child: Tooltip(
              message: currency == "BNB" ? '$balance BNB' : '$balance USD',
              child: Text(
                balance.length <= 2
                    ? '$balance.00'
                    : balance.length <= 3
                        ? '$balance.0'
                        : balance.length <= 4
                            ? '$balance'
                            : balance.substring(0, 5),
                style: TextStyle(
                  //  fontFamily: AppFont.euclidCircularARegular,
                  fontSize: 14.sp,
                  color: const Color(0xFF9FA4BC),
                ),
                // maxLines: 4,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ),
          0.width.expand(),
          Text(
            currency,
            style: TextStyle(
                //  fontFamily: AppFont.euclidCircularARegular,
                fontSize: 14.sp,
                color: ColorConfig.yellow,
                fontWeight: FontWeight.bold),
          ),
          currency == "BNB" ? 6.width : 6.width,
        ],
      ),
    );
  }
}
