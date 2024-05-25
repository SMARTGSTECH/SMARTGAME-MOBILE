import 'package:flutter/material.dart';

class Extrude extends StatelessWidget {
  final Widget child;
  final double radius;
  final bool pressed;
  final double inset;
  final bool primary;
  final Function()? onPress;
  const Extrude(
      {super.key,
      this.inset = 5,
      this.child = const SizedBox(),
      this.radius = 10,
      this.pressed = false,
      this.onPress,
      this.primary = false});

  @override
  Widget build(BuildContext context) {
    Color? scaffoldL = const Color(0xFFE0E0E0);
    Color scaffoldLL = const Color(0xFFEEEEEE);
    Color? shadowL = const Color(0xFF9E9E9E);
    Color? backgroundL = const Color(0xFFFFFF);

    double extrudeBlurRadius = 5;
    Offset extrueDistance = const Offset(4, 4);
    Offset insertDistance = const Offset(1, 4);

    return Column(
      children: [
        !pressed
            ? GestureDetector(
                onTap: onPress,
                child: Center(
                  child: Container(
                    decoration: BoxDecoration(
                        color: primary
                            ? null
                            : Theme.of(context).scaffoldBackgroundColor,
                        borderRadius: BorderRadius.circular(radius),
                        gradient: primary
                            ? LinearGradient(
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter,
                                colors: [
                                    // AppColors.primaryDark,
                                    //  AppColors.primaryDark,

                                    // AppColors.primary,
                                  ])
                            : null,
                        boxShadow: [
                          //top region
                          BoxShadow(
                            offset: -extrueDistance,
                            color: Theme.of(context).secondaryHeaderColor,
                            blurRadius: extrudeBlurRadius,
                          ),
                          //bottom region
                          BoxShadow(
                            offset: extrueDistance,
                            color: Theme.of(context).shadowColor,
                            blurRadius: extrudeBlurRadius,
                          ),
                        ]),
                    child: child,
                  ),
                ),
              )

            //intrude
            : GestureDetector(
                onTap: onPress,
                child: Container(
                  decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                          color: primary
                              ? const Color(0xFF04794B)
                              : Theme.of(context).shadowColor,
                          offset: const Offset(1, 2)),
                      BoxShadow(
                        offset: insertDistance,
                        blurRadius: inset,
                        // color: primary ? AppColors.primary : Theme.of(context)
                        //     .scaffoldBackgroundColor // background color
                        // ),
                      )
                    ],
                    borderRadius: BorderRadius.circular(radius),
                  ),
                  child: child,
                ),
              ),
      ],
    );
  }
}
