import 'package:flutter/foundation.dart';

class DiceStateProvider extends ChangeNotifier {
  int _counter = 0;

  int get counter => _counter;

  void increment() {
    _counter++;
    notifyListeners(); // Notify listeners about the change
  }

  bool one = false;
  bool two = false;
  bool three = false;
  bool four = false;
  bool five = false;
  bool six = false;

  void setCurrentTab({
    required bool one,
    required bool two,
    required bool three,
    required bool four,
    required bool five,
    required bool six,
  }) {
    this.one = one;
    this.two = two;
    this.three = three;
    this.four = four;
    this.five = five;
    this.six = six;
    notifyListeners();
  }
}
