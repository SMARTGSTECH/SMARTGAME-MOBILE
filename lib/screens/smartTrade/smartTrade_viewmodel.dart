import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smartbet/socket/provider.dart';

class SmartTradeProvider extends ChangeNotifier {
  List gameOptions = ['\$30 - \$209', '\$10 - \$500', '\$30 - \$204', '\$30'];

  int selectedOptionIndex = 100;
  String selectedOption = '';

  toggleOptionIndex(int index) {
    selectedOptionIndex = index == selectedOptionIndex ? 100 : index;
    print(selectedOptionIndex);
    notifyListeners();
  }

  // gameOption({required BuildContext context, symbol}) {
  //   Map val = Provider.of<SocketProvider>(context, listen: false)
  //       .getsmartTradeOptionValue;
  //   double option1 = val[symbol];
  //   double option2 = 10;
  //   double option3 = 20;
  //   double option4 = 30;
  //   // notifyListeners();
  //   gameOptions = [
  //     option1.toString(),
  //     option2.toString(),
  //     option3.toString(),
  //     option4.toString()
  //   ];
  //   notifyListeners();

  //   // return [
  //   //   option1.toString(),
  //   //   option2.toString(),
  //   //   option3.toString(),
  //   //   option4.toString()
  //   // ];
  // }

  toggleOption(String option) {
    selectedOption = option;
    print(selectedOption);
    notifyListeners();
  }
}
