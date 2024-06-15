import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:provider/provider.dart';
import 'package:smartbet/model/coinCapModel.dart';
import 'package:http/http.dart' as http;
import 'package:smartbet/socket/provider.dart';

class CoinCapProvider extends ChangeNotifier {
  List<coinCapModel> _coinArray = [];

  List<coinCapModel> get coinArray => _coinArray;

  Future<void> fetchCoin() async {
    print("logging");
    final apiData = await http.get(Uri.parse(
        'https://api.coingecko.com/api/v3/coins/markets?vs_currency=usd&order=market_cap_desc&per_page=100&page=1&sparkline=false'));

    if (apiData.statusCode == 200) {
      List<dynamic> values = json.decode(apiData.body);

      if (values.length > 0) {
        _coinArray = values
            .where((element) => element != null)
            .map((map) => coinCapModel.fromJson(map))
            .toList();
      }

      notifyListeners();
    } else {
      throw Exception('Failed to load coins');
    }
  }

  Future<Map> fetchInitialdata(context) async {
    final url = Uri.parse(
        'https://server.smartcryptobet.co/v1/game/coinsessionprices?key=K10llGN3RB');
    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        final Map data = json.decode(response.body)['data'];
        print(data);
        print("This is the data gotten from the api");
        Provider.of<SocketProvider>(context, listen: false)
            .setInitGameVale(data);

        return data;
      } else {
        throw Exception('Failed 1');
      }
    } catch (e) {
      throw Exception('Failed 2: $e');
    }
  }
}
