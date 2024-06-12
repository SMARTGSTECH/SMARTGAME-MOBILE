import 'package:flutter/material.dart';

class SmartTradeProvider extends ChangeNotifier {
  List gameOption = ['\$30 - \$200', '\$10 - \$500', '\$30 - \$200', '\$30'];

  int selectedOption = 0;

  toggleTab(int index) {
    selectedOption = index;
    notifyListeners();
  }
}
