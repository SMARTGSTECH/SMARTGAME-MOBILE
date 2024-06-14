import 'package:flutter/material.dart';

class LiveEventPredictionProvider extends ChangeNotifier {
  List gameOption = [
    '\$30 - \$209',
    '\$10 - \$500',
    '\$30 - \$204',
    '\$30',
    '\$30 - \$219',
    // '\$10 - \$510',
    // '\$30 - \$214',
    // '\$310',
    // 'Option1',
    // 'Option2',
  ];

  bool isOdd(int number) {
    return number % 2 != 0;
  }

  int selectedOptionIndex = 100;
  String selectedOption = '';

  toggleOptionIndex(int index) {
    selectedOptionIndex = index == selectedOptionIndex ? 100 : index;
    print(selectedOptionIndex);
    notifyListeners();
  }

  toggleOption(String option) {
    selectedOption = option;
    print(selectedOption);
    notifyListeners();
  }
}
