import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'color.dart';

class ThemeClass {
  static final ValueNotifier<ThemeMode> themeNotifier =
      ValueNotifier(ThemeMode.light);

  static ThemeData mainTheme = ThemeData(
    fontFamily: 'Poppins',
    scaffoldBackgroundColor: ColorConfig.scaffold,
    secondaryHeaderColor: Colors.white,
    // primarySwatch:  Color(0xFF050913),
    //primaryColor: Colors.lightBlue[800],
    appBarTheme: const AppBarTheme(
      backgroundColor: Colors.transparent,
      foregroundColor: Colors.transparent,
      elevation: 0,
      iconTheme: IconThemeData(color: Colors.black),
      systemOverlayStyle: SystemUiOverlayStyle(
          statusBarColor: Colors.black,
          statusBarIconBrightness: Brightness.light,
          statusBarBrightness: Brightness.light,
          systemNavigationBarColor: Colors.black),
    ),
    brightness: Brightness.dark,
    textTheme: TextTheme(
      bodyLarge: TextStyle(color: Colors.black.withOpacity(0.5)),
      titleLarge: const TextStyle(
          color: Colors.black, fontWeight: FontWeight.bold, fontSize: 16),
    ),
  );
}
