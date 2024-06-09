import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:provider/provider.dart';
import 'package:smartbet/utils/config/color.dart';
import 'package:smartbet/widget/comingSoon.dart';

class FootBallMobileScreen extends StatefulWidget {
  const FootBallMobileScreen({super.key});

  @override
  State<FootBallMobileScreen> createState() => _FootBallMobileScreenState();
}

class _FootBallMobileScreenState extends State<FootBallMobileScreen> {
  @override
  Widget build(BuildContext context) {

    return Consumer(
      builder: (BuildContext context, model, _) { 
        return 
       Column(
        children: [
          Container(
            padding: EdgeInsetsDirectional.all(3),
            height: 32.h,
            //width: 340.w,
            decoration: BoxDecoration(
                // color: ColorConfig.scaffold,
                borderRadius: BorderRadius.circular(10)),
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  ...List.generate(
                      model.tabItemHeader.length,
                      (index) => Container(
                            decoration: BoxDecoration(
                                color: model.tabItemHeader[index] == '1D'
                                    ? ColorConfig.primary
                                    : Colors.transparent,
                                borderRadius: BorderRadius.circular(20)),
                            width: 45.w,
                            //height: 55.h,
                            child: Text(
                              model.tabItemHeader[index],
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontSize: 15.sp,
                                  color:true
                                      ? Colors.white
                                      : ColorConfig.red,
                                  fontWeight: FontWeight.w600),
                            ).center(),
                          )),
                ],
              ),
            ),
          ),
        ],
      ),
    
      },
      child:
      
    );
 
  }
}
