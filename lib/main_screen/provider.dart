import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:smartbet/utils/config/color.dart';
import 'package:smartbet/widget/navIcon.dart';

class MainScreenProvider extends ChangeNotifier {
  int _currentIndex = 1;

  int get currentIndex => _currentIndex;

  List<Widget> getItems() {
    return [
      NavIcon(
        img: "assets/images/football.png",
        position: currentIndex,
        name: 'Live',
        size: 20,
        isSoccer: true,
      ),
      NavIcon(
        isIcon: true,
        position: currentIndex,
        name: "Home",
      ),
      NavIcon(
        position: currentIndex,
        img: "assets/images/virtual.png",
        name: 'Virtual',
        size: 30,
        isVirtual: true,
      ),
    ];
  }

  void setPageIndex(int index) {
    _currentIndex = index;
    notifyListeners();
  }
}
