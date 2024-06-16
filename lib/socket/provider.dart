import 'package:flutter/foundation.dart';
import 'package:nb_utils/nb_utils.dart';

class SocketProvider extends ChangeNotifier {
  int _counter = 0;
  Map _result = {};
  Map _coin = {};
  Map smartTradeOptionValue = {};
  List _gameHistory = [];

  int get counter => _counter;
  Map get coin => _coin;
  Map get result => _result;
  List get gameHistory => _gameHistory;

  void setCounter(counter) {
    _counter = counter;
    notifyListeners();
  }

  void setGameOutput(value) {
    _result = value;

    notifyListeners();
  }

  void setCoin(value) {
    _coin = value ?? _coin;
    //print("thi is the ${_coin}");
    notifyListeners();
  }

  void setInitGameVale(value) {
    smartTradeOptionValue = value;
    print("thi is the ${smartTradeOptionValue}");
    notifyListeners();
  }

  gameSocketOption(sym) {
    // print(object)
    //print(smartTradeOptionValue[sym].runtimeType);

    double val = sym == "BTC"
        ? 20.25
        : sym == "SOL"
            ? 0.2
            : sym == "BNB"
                ? 2.2
                : 2.8;

    print(val);
    double option1 =
        double.parse((smartTradeOptionValue[sym] + val).toStringAsFixed(2));
    // print(double.parse((smartTradeOptionValue[sym] + 0.2).toString()));
    int option2 = 10;
    int option3 = 20;
    double option4 =
        double.parse((smartTradeOptionValue[sym] - val).toStringAsFixed(2));
//'\$${option1} \u2014 ∞',
    return [
      '\$${option1} > ∞',
      option2.toString(),
      option3.toString(),
      '\$${option4} < ∞'
    ];
  }

  Map get getsmartTradeOptionValue {
    // notifyListeners();
    return smartTradeOptionValue;
  }

  void setGameHistory(value) {
    _gameHistory = value;
    print("hrdjksjdksjdksdksdjksjdksjdsker");

    // print(getGameHistory("fruit"));
    notifyListeners();
  }

  List getGameHistory(gameType) {
    var mapGameResult = [];
    _gameHistory.map((item) => item[gameType]).toList();
    return mapGameResult;
  }

  List get firstFiveHistory {
    return gameHistory.sublist(0, 5);
  }

  List get lastFiveHistory {
    //thistryurns the last 5 games
    return gameHistory.sublist(5);
  }
}



// DecorationImage(
//                                         //  opacity: 0.5,
//                                         fit: BoxFit.fill,
//                                         image: provider.counter == 49 ||
//                                                 provider.counter == 48 ||
//                                                 provider.counter == 47 ||
//                                                 provider.counter == 46
//                                             ? AssetImage(
//                                                 "assets/images/d${provider.result["dice"]}.gif")
//                                             : AssetImage(
//                                                 "assets/images/dice.gif")),
