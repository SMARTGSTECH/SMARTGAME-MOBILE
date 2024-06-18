import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:smartbet/socket/provider.dart';

class LiveEventProvider extends ChangeNotifier {
  List tabItemHeader = [
    "Smart Trade",
    "Live Event",
  ];

  List stGrid = ['btc', 'eth', 'sol', 'bnb'];

  int selectedTab = 0;

  List activeLiveGame = [];

  toggleTab(int index) {
    selectedTab = index;
    notifyListeners();
  }

  Future<List> fetchLiveEvent(context) async {
    final url = Uri.parse(
        'https://server.smartcryptobet.co/v1/games/active?key=K10llGN3RB');
    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        final List data = json.decode(response.body)['data'];
        print(data);
        print("This is the data gotten from the live event api");

        return data;
      } else {
        throw Exception('Failed 1');
      }
    } catch (e) {
      throw Exception('Failed 2: $e');
    }
  }
}
