import 'package:flutter/material.dart';

class SmartTradeProvider extends ChangeNotifier {
  List gameOption = ['\$30 - \$200', '\$10 - \$500', '\$30 - \$200', '\$30'];

  int selectedOptionIndex = 0;
  String selectedOption = '';

  toggleOptionIndex(int index) {
    selectedOptionIndex = index;
    notifyListeners();
  }

  toggleOption(String option) {
    selectedOption = option;
    print(selectedOption);
    notifyListeners();
  }
}
