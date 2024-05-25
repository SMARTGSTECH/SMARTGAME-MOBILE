import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:smartbet/utils/config/color.dart';

class gameWidget extends StatelessWidget {
  gameWidget(
      {super.key,
      this.currentTab = false,
      this.imgcolor = Colors.black,
      this.indexcolor = const Color(0xFF999999),
      this.colorImg = false,
      this.backgroundCar = false,
      this.dymW = 5,
      this.ht = 10,
      this.wt = 10,
      this.img = "",
      this.spacer = 1,
      this.dym = 0,
      this.imgW = 0,
      this.function,
      this.newContainer = false,
      this.isMobileScreen = false,
      this.text = ""});
  final Color imgcolor;
  final Color indexcolor;
  final double ht;
  final double wt;
  final double spacer;
  final String img;
  final double dym;
  final double dymW;
  final double imgW;
  final bool colorImg;
  final bool currentTab;
  final VoidCallback? function;
  final bool backgroundCar;
  final bool? newContainer;
  final bool? isMobileScreen;
  final String text;

  @override
  Widget build(BuildContext context) {
    double extrudeBlurRadius = 5;
    Offset extrueDistance = const Offset(4, 4);
    Offset insertDistance = const Offset(1, 4);
    var darkColors = Color.fromARGB(255, 200, 205, 216);
    var lightColors = Color.fromARGB(255, 102, 104, 111);
    return Column(
      children: [
        // 20.toInt().height,
        if (!isMobileScreen!)
          Container(
                  decoration: (backgroundCar || newContainer!)
                      ? BoxDecoration(
                          color: newContainer!
                              ? ColorConfig.iconColor.withOpacity(0.1)
                              : Colors.black38,
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(color: ColorConfig.lightBoarder))
                      : BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                        ),
                  height: dym,
                  width: backgroundCar ? dym + dymW : dym,
                  child: colorImg
                      ? Image.asset(
                          img,
                          color: imgcolor,
                          // width: 100,
                        )
                      : Image.asset(
                          img,
                          // width: 100,
                        ))
              .onTap(() {
            function!();
          }, borderRadius: BorderRadius.circular(10)).paddingTop(20)
        else
          colorImg
              ? Image.asset(
                  img,
                  color: imgcolor,
                  width: 50,
                  height: 50,
                  // width: 100,
                ).onTap(() {
                  function!();
                }, borderRadius: BorderRadius.circular(10))
              : Image.asset(
                  img,
                  width: 50,
                  height: 50,
                  // width: 100,
                ).onTap(() {
                  function!();
                }, borderRadius: BorderRadius.circular(10)),
        isMobileScreen! ? spacer.h.toInt().height : 8.toInt().height,
        Container(
          decoration: BoxDecoration(
              color: currentTab ? ColorConfig.yellow : indexcolor),
          height: ht,
          width: wt,
        ).cornerRadiusWithClipRRect(20),
      ],
    );
  }
}

class MobileGameWidget extends StatelessWidget {
  MobileGameWidget(
      {super.key,
      this.currentTab = false,
      this.imgcolor = Colors.black,
      this.indexcolor = const Color(0xFF999999),
      this.colorImg = false,
      this.backgroundCar = false,
      this.size = 13,
      this.ht = 10,
      this.wt = 10,
      this.dym = 0,
      this.imgW = 0,
      this.function,
      this.newContainer = false,
      this.isMobileScreen = false,
      this.txtButton = ""});
  final Color imgcolor;
  final Color indexcolor;
  final double ht;
  final double wt;
  final double dym;
  final double size;
  final double imgW;
  final bool colorImg;
  final bool currentTab;
  final VoidCallback? function;
  final bool backgroundCar;
  final bool? newContainer;
  final bool? isMobileScreen;
  final String txtButton;

  @override
  Widget build(BuildContext context) {
    double extrudeBlurRadius = 5;
    Offset extrueDistance = const Offset(4, 4);
    Offset insertDistance = const Offset(1, 4);
    var darkColors = Color.fromARGB(255, 200, 205, 216);
    var lightColors = Color.fromARGB(255, 102, 104, 111);

    return Column(
      children: [
        Container(
            decoration: (backgroundCar || newContainer!)
                ? BoxDecoration(
                    color: newContainer!
                        ? ColorConfig.iconColor.withOpacity(0.1)
                        : ColorConfig.iconColor,
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: ColorConfig.lightBoarder))
                : BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                  ),
            // height: dym,
            // width: backgroundCar ? dym + dymW : dym,
            height: dym,
            width: dym * 2.5,
            child: Center(
              child: Text(
                txtButton,
                style: primaryTextStyle(
                    color: ColorConfig.black,
                    size: size.sp.toInt(),
                    weight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
            )).onTap(() {
          function!();
        }, borderRadius: BorderRadius.circular(10)).paddingTop(20)
      ],
    );
  }
}
