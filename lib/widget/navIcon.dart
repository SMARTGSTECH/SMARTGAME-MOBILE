import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:smartbet/utils/config/color.dart';

class NavIcon extends StatelessWidget {
  const NavIcon({
    super.key,
    this.img,
    this.size,
    this.name,
    this.isIcon = false,
    this.isVirtual = false,
    this.isSoccer = false,
    this.position,
  });
  final String? img;
  final int? size;
  final String? name;
  final bool isIcon;
  final bool isVirtual;
  final bool isSoccer;
  final int? position;
  @override
  Widget build(BuildContext context) {
    return isIcon
        ? Column(
            children: [
              position! != 1 ? 12.h.toInt().height : Container(),
              Icon(
                Icons.home,
                color:
                    position! != 1 ? ColorConfig.iconColor : ColorConfig.black,
                size: 30.sp,
              ),
              1.h.toInt().height,
              position != 1
                  ? Text(
                      name!,
                      style: TextStyle(
                          fontSize: 12.sp,
                          color: ColorConfig.iconColor,
                          fontWeight: FontWeight.bold),
                    )
                  : Container()
            ],
          )
        : (position == 0 && isSoccer || position == 2 && isVirtual)
            ? subWidget(name: name, img: img, size: size, removeText: false)
            : subWidget(name: name, img: img, size: size, removeText: true);
  }
}

class subWidget extends StatelessWidget {
  const subWidget(
      {super.key,
      required this.name,
      required this.img,
      required this.size,
      this.removeText = false});

  final String? name;
  final String? img;
  final int? size;
  final bool removeText;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            name!.toLowerCase() == "virtual" ? Container() : 7.h.toInt().height,
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                name!.toLowerCase() == "virtual"
                    ? 4.w.toInt().width
                    : Container(),
                Image.asset(
                  img!,
                  height: size!.h,
                  width: size!.h,
                ),
              ],
            ),
            name!.toLowerCase() == "virtual" ? 0.height : 4.h.toInt().height,
            if (removeText)
              Text(
                name!,
                style: TextStyle(
                    fontSize: 12.sp,
                    color: ColorConfig.iconColor,
                    fontWeight: FontWeight.bold),
              )
          ],
        ),
      ),
    );
  }
}



//  position == 0
//                       ? Text(
//                               name.toString()!,
//                               style: TextStyle(
//                                   fontSize: 12.sp,
//                                   color: ColorConfig.iconColor,
//                                   fontWeight: FontWeight.bold),
//                             )
//                       : position == 2
//                           ? Container()
//                           : Text(
//                               position.toString()!,
//                               style: TextStyle(
//                                   fontSize: 12.sp,
//                                   color: ColorConfig.iconColor,
//                                   fontWeight: FontWeight.bold),
//                             )