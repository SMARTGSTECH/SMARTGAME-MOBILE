import 'package:flutter/foundation.dart';

class CoinStateProvider extends ChangeNotifier {
  int _counter = 0;

  int get counter => _counter;

  void increment() {
    _counter++;
    notifyListeners(); // Notify listeners about the change
  }

  bool head = false;
  bool tail = false;

  void setCurrentTab({
    required bool head,
    required bool tail,
  }) {
    this.head = head;
    this.tail = tail;
    notifyListeners();
  }
}
