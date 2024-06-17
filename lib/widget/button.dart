import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:shimmer/shimmer.dart';
import 'package:smartbet/utils/config/color.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final Color color;
  final Color textColor;
  final double borderRadius;
  final EdgeInsetsGeometry padding;
  final double elevation;
  final double height;
  final double width;
  final int size;
  final bool shimmer;

  const CustomButton(
      {required this.text,
      required this.onPressed,
      this.color = Colors.blue,
      this.textColor = Colors.white,
      this.borderRadius = 8.0,
      this.padding =
          const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      this.elevation = 10,
      this.height = 40.0,
      this.width = double.infinity,
      this.shimmer = false,
      this.size = 13});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      width: width,
      child: Material(
        elevation: elevation,
        borderRadius: BorderRadius.circular(borderRadius),
        color: color,
        child: InkWell(
          splashColor: ColorConfig.black.withOpacity(0.3),
          borderRadius: BorderRadius.circular(borderRadius),
          onTap: onPressed,
          child: Center(
            child: shimmer
                ? Shimmer.fromColors(
                    highlightColor: Colors.grey[300]!,
                    baseColor: const Color.fromARGB(255, 25, 19, 19),
                    period: Duration(milliseconds: 1500),
                    child: Center(
                      child: Text(
                        text,
                        style: primaryTextStyle(
                            color: ColorConfig.black,
                            size: size.sp.toInt(),
                            weight: FontWeight.bold),
                      ),
                    ),
                  )
                : Text(
                    text,
                    style: primaryTextStyle(
                        color: ColorConfig.black,
                        size: size.sp.toInt(),
                        weight: FontWeight.bold),
                  ),
          ),
        ),
      ),
    );
  }
}

class CustomAppButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final Color color;
  final Color textColor;
  final double borderRadius;
  final EdgeInsetsGeometry padding;
  final double elevation;
  final double height;
  final double width;
  final int size;
  final bool shimmer;
  final bool usePadding;

  const CustomAppButton(
      {required this.text,
      required this.onPressed,
      this.color = Colors.blue,
      this.textColor = Colors.white,
      this.borderRadius = 8.0,
      this.padding =
          const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      this.elevation = 10,
      this.height = 40.0,
      this.width = double.infinity,
      this.shimmer = false,
      this.size = 13,
      this.usePadding = false});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: text.toLowerCase() == "play" ? 22.h : height,
      width: text.toLowerCase() == "play" ? 60.w : width,
      child: Material(
        elevation: elevation,
        borderRadius: BorderRadius.circular(borderRadius),
        color: color,
        child: InkWell(
          splashColor: ColorConfig.black.withOpacity(0.3),
          borderRadius: BorderRadius.circular(borderRadius),
          onTap: onPressed,
          child: Center(
            child: shimmer
                ? Shimmer.fromColors(
                    highlightColor: Colors.grey[300]!,
                    baseColor: const Color.fromARGB(255, 25, 19, 19),
                    period: Duration(milliseconds: 1500),
                    child: Center(
                      child: Text(
                        text,
                        style: primaryTextStyle(
                            color: ColorConfig.black,
                            size: size.sp.toInt(),
                            weight: FontWeight.bold),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  )
                : Text(
                    text,
                    style: primaryTextStyle(
                        color: ColorConfig.black,
                        size: text.toLowerCase() == "play"
                            ? 14.sp.toInt()
                            : size.sp.toInt(),
                        weight: FontWeight.bold),
                    textAlign: TextAlign.center,
                  ),
          ),
        ),
      ),
    ).onTap(() {
      onPressed();
    }, borderRadius: BorderRadius.circular(10)).paddingTop(usePadding ? 0 : 20);
  }
}
