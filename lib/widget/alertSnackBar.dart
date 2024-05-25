import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:smartbet/utils/config/color.dart';

Future CustomSnackBar(
    {required context,
    required String? message,
    IconData? icon,
    Color? leftColor,
    Color? iconColor,
    double? width}) {
  return Flushbar(
          flushbarStyle: FlushbarStyle.FLOATING,
          reverseAnimationCurve: Curves.decelerate,
          forwardAnimationCurve: Curves.elasticOut,
          backgroundColor: ColorConfig.scaffold,
          boxShadows: [
            BoxShadow(
                color: Colors.blue[800]!,
                offset: Offset(0.0, 2.0),
                blurRadius: 3.0)
          ],
          flushbarPosition: FlushbarPosition.TOP,
          borderRadius: BorderRadius.circular(8),
          // flushbarStyle: FlushbarStyle.FLOATING,
          // showProgressIndicator: true,
          message: message,
          icon: Icon(
            icon ?? Icons.warning_amber,
            size: 28.0,
            color: iconColor ?? ColorConfig.yellow,
          ),
          duration: const Duration(seconds: 4),
          maxWidth: width ?? 300,
          leftBarIndicatorColor: leftColor ?? Colors.red)
      .show(context);
}
