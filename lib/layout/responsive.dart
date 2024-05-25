import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/foundation.dart' show kIsMobile;

class ResponsiveLayout extends StatelessWidget {
  // const ResponsiveLayout({super.key});

  final Widget mobileScreen;
  final Widget desktopScreen;

  ResponsiveLayout({required this.mobileScreen, required this.desktopScreen});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      if (constraints.maxWidth <= 450) {
        return mobileScreen;
      } else {
        return desktopScreen;
      }
    });
  }
}
