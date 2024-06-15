import 'package:flutter/material.dart';

class SmartTradeProvider extends ChangeNotifier {
  List gameOption = ['\$30 - \$209', '\$10 - \$500', '\$30 - \$204', '\$30'];

  int selectedOptionIndex = 100;
  String selectedOption = '';

  toggleOptionIndex(int index) {
    selectedOptionIndex = index == selectedOptionIndex ? 100 : index;
    print(selectedOptionIndex);
    notifyListeners();
  }

  List get gameOptions {
    List dataVal = [];

    return [];
  }

  toggleOption(String option) {
    selectedOption = option;
    print(selectedOption);
    notifyListeners();
  }
}
