import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nb_utils/nb_utils.dart';

class ColorConfig {
  static Color buttonBorder = const Color(0xFFbbc0c5);
  static Color iconColor = const Color(0xffDFDEDE);
  static Color redCar = const Color(0xffe91d25);
  static Color yellowCar = const Color(0xffe6b40e);
  static Color greenCar = const Color(0xff0ff908);
  static Color blueCar = const Color(0xff0523f1);
  static Color blueButton = const Color(0xFF0376c9);
  static Color blue = const Color(0xFF0260a4);
  static Color containerBorder = const Color(0xFFd6d9dc);
  static Color scaffold = const Color(0xFF001234);
  static Color secondary = const Color(0xff034F96);
  static Color primary = const Color(0xFF003A31);
  static Color white = const Color(0xffffffff);
  static Color red = const Color(0xFFFF0523);
  static Color appBar = const Color(0xff034F96);
  static Color desktopGameappBar = const Color(0xff034F96);
  static Color desktopShadeGameappBar = const Color(0xff034F96);
  static Color black = Color(0xFF24272a);
  static Color splash = const Color(0xFF5B49CC);
  static Color dotColor = const Color(0xFFD9D9D9);
  static Color formColor = const Color(0xFF2E3850);
  static Color inputBorderColor = const Color(0xFF5B49CC);
  static Color inputIconColor = const Color(0xFF8E92A1);
  static Color containerColor = const Color(0xFFE4E4E4);
  static Color seedContainer = const Color(0xFF5B49CC);
  static Color statusBarColor = const Color(0xFF111827);
  static Color yellow = const Color(0xFFFFC700);
  static Color tabpurple = const Color(0xFF4A3BA6);
  static Color tabcurrentindex = const Color(0xFF5B49CC);
  static Color tabincurrentindex = const Color(0xFF999999);
  static Color coindollars = const Color(0xFF777777);
  static Color green = const Color(0xFF299927);
  static Color lightBoarder =
      const Color.fromARGB(255, 237, 237, 237).withOpacity(0.24);
}

class StyleConfig {
  static TextStyle primaryStyle = primaryTextStyle(
      color: ColorConfig.iconColor,
      size: 16.sp.toInt(),
      weight: FontWeight.bold);

  static TextStyle defaultWhiteTextStyle = primaryTextStyle(
      color: ColorConfig.iconColor,
      size: 13.sp.toInt(),
      weight: FontWeight.bold);

  static TextStyle defaultBlackTextStyle = primaryTextStyle(
      color: ColorConfig.black, size: 13.sp.toInt(), weight: FontWeight.bold);

  static TextStyle unicodeStyle = primaryTextStyle(
      color: ColorConfig.red, size: 16.sp.toInt(), weight: FontWeight.bold);
}

class AppImageDetails {
  static const String pitch = 'assets/images/ball.png';
  static const String pitch2 = 'assets/images/pitch2.png';
  static const String dice = 'assets/images/dice.png';
  static const String coin = 'assets/images/coin.png';
  static const String fruit = 'assets/images/fruits.png';
  static const String car = 'assets/images/car.png';
  static const String padLottie = 'assets/images/newpad.json';
  static const String eventLottie = 'assets/images/chart.json';

  static const String footballname = "FOOTBALL MATCH";
  static const String liveEvents = "LIVE PREDICTION";
  static const String snartTrades = "VIRTUAL GAME";
  static const String dicename = "THROW DICE";
  static const String coinname = "TOSS COIN";
  static const String carname = "CAR RACING";
  static const String fruitname = "FRUITS";
}
