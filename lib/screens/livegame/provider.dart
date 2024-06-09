import 'package:flutter/material.dart';

class LiveEventProvider extends ChangeNotifier {
  List tabItemHeader = [
    "Smart Trade",
    "Live Event",
  ];

  int selectedTab = 0;

  toggleTab(int index) {
    selectedTab = index;
    notifyListeners();
  }
}
