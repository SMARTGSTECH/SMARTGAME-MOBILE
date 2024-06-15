import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smartbet/socket/provider.dart';

class SmartTradeProvider extends ChangeNotifier {
  List gameOption = ['\$30 - \$209', '\$10 - \$500', '\$30 - \$204', '\$30'];

  int selectedOptionIndex = 100;
  String selectedOption = '';

  toggleOptionIndex(int index) {
    selectedOptionIndex = index == selectedOptionIndex ? 100 : index;
    print(selectedOptionIndex);
    notifyListeners();
  }

  List gameOptions(context, symbol) {
    Map val = Provider.of<SocketProvider>(context, listen: false)
        .smartTradeOptionValue;
    double option1 = 0;
    double option2 = 0;
    double option3 = 0;
    double option4 = 0;
    return [option1, option2, option3, option4];
  }

  toggleOption(String option) {
    selectedOption = option;
    print(selectedOption);
    notifyListeners();
  }
}
