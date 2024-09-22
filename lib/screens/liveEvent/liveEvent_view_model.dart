import 'package:flutter/material.dart';
import 'package:smartbet/constants/strings.dart';
import 'package:smartbet/services/storage.dart';

class LiveEventPredictionProvider extends ChangeNotifier {
  List gameOption = [
    '\$30 - \$209',
    '\$10 - \$500',
    '\$30 - \$204',
    '\$30',
    '\$30 - \$219',
    '\$10 - \$510',
    '\$30 - \$214',
    '\$310',
    'Option1',
    'Option2',
  ];
  bool status = false;

  bool isOdd(int number) {
    return number % 2 != 0;
  }

  getWalletState() async {
    String data = await Storage.readData(WALLET_MNEMONICS) ?? "";
    print('GEETING WALLET STATE');

    ///print(data);
    status = data.isNotEmpty;
    return status;
  }

  int selectedOptionIndex = 100;
  String selectedOption = '';

  toggleOptionIndex(int index) {
    selectedOptionIndex = index == selectedOptionIndex ? 100 : index;
    // selectedOption = '';
    print([selectedOptionIndex, selectedOption]);
    notifyListeners();
  }

  toggleOption(String option) {
    selectedOption = option;
    print(selectedOption);
    notifyListeners();
  }
}
