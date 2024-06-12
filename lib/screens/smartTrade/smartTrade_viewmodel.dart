import 'package:flutter/material.dart';

class SmartTradeProvider extends ChangeNotifier {
  List tabItemHeader = [
    "Smart Trade",
    "Live Event",
  ];

  List stGrid = ['sol', 'eth', 'bnb', 'ton'];

  int selectedOption = 0;

  toggleTab(int index) {
    selectedOption = index;
    notifyListeners();
  }
}
