import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smartbet/utils/config/color.dart';

class comingSoon extends StatelessWidget {
  const comingSoon({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Coming Soon',
            style: TextStyle(
                fontSize: 18.sp,
                color: ColorConfig.yellow,
                fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}
