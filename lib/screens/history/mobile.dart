import 'package:avatar_glow/avatar_glow.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:provider/provider.dart';
import 'package:smartbet/screens/car/provider.dart';
import 'package:smartbet/screens/fruit/provider.dart';
import 'package:smartbet/screens/history/components/details.dart';
import 'package:smartbet/socket/provider.dart';
import 'package:smartbet/utils/config/color.dart';
import 'package:smartbet/widget/alertSnackBar.dart';
import 'package:smartbet/widget/button.dart';
import 'package:smartbet/widget/customAppBar.dart';
import 'package:smartbet/widget/gameWidget.dart';
import 'package:smartbet/widget/resultWidget.dart';
import 'package:smartbet/widget/stakeContainer.dart';

class HistoryMobile extends StatefulWidget {
  const HistoryMobile({super.key});

  @override
  State<HistoryMobile> createState() => _HistoryMobileState();
}

class _HistoryMobileState extends State<HistoryMobile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: customAppbar(context),
        body: SingleChildScrollView(
          child: Container(
            decoration: BoxDecoration(color: Color(0xFF034F96)),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      padding: const EdgeInsets.only(left: 10),
                      margin: EdgeInsets.only(bottom: 10),
                      decoration: const BoxDecoration(color: Color(0xFF034F96)),
                      child: const Text(
                        '',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 15,
                            decoration: TextDecoration.none),
                        textAlign: TextAlign.center,
                        // if (SizeConfig.screenWidth! >= 1137)
                      ),
                    ),
                  ],
                ),
                Container(
                  padding: EdgeInsets.only(
                    left: 5,
                  ),
                  decoration: BoxDecoration(color: Color(0xFF034F96)),
                  child: Text('safdsf'),
                  //Details(),
                )
              ],
            ),
          ),
        ));
  }
}
