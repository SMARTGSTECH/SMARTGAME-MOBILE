import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class HistoryDataModel {
  final String wallet;
  final String side;
  final String amount;
  final String prediction;
  final String odds;
  final String type;

  HistoryDataModel(
      {required this.side,
      required this.wallet,
      required this.amount,
      required this.prediction,
      required this.odds,
      required this.type});

  factory HistoryDataModel.fromJson(Map<String, dynamic> json) {
    return HistoryDataModel(
      side: json['side'],
      wallet: json['wallet'],
      amount: json['amount'],
      prediction: json['prediction'],
      odds: json['odds'],
      type: json['type'],
    );
  }
}

Future<List<HistoryDataModel>> getData() async {
  final url = Uri.parse(
      'https://server.smartcryptobet.co/v1/history?key=VIm3rPgfk9');
  try {
    final response = await http.get(url);
    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body)['data'];
      return data.map((item) => HistoryDataModel.fromJson(item)).toList();
    } else {
      throw Exception('Failed 1');
    }
  } catch (e) {
    throw Exception('Failed 2: $e');
  }
}

// Future<List<HistoryDataModel>> getData() async {
//   final url = Uri.parse(
//       'https://server.smartcryptobet.co/v1/$endpoint/history?key=abc');
//       try {
//     final response = await http.get(url);
//     if (response.statusCode == 200) {
//       final List<dynamic> data = json.decode(response.body)['data'];
//       return data.map((item) => HistoryDataModel.fromJson(item)).toList();
//     } else {
//       throw Exception('Failed 1');
//     }
//   } catch (e) {
//     throw Exception('Failed 2: $e');
//   }
// }










  // @override
  // String toString() {
  //   return 'HistoryDataModel{wallet: $wallet, side: $side, amount: $amount, prediction: $prediction}';
  // }

// Future<dynamic> getData(String endpoint) async {
//   dynamic result;

//   try {
//     final response = await http.get(
//       Uri.parse("https://server.smartcryptobet.co/v1/$endpoint/history?key=VIm3rPgfk9"),
//       headers: {
//         HttpHeaders.contentTypeHeader: "application/json",
//       },
//     );

//     if (response.statusCode == 200) {
//       final dynamic data = json.decode(response.body);

//       if (data is List) {
//         // If the response is a List, create a list of HistoryDataModel instances
//         result = data.map((item) => HistoryDataModel.fromJson(item)).toList();
//       } else if (data is Map<String, dynamic>) {
//         // If the response is a Map, create a single instance of HistoryDataModel
//         result = HistoryDataModel.fromJson(data);
//       } else {
//         print('Unexpected response format');
//       }
//     } else {
//       print('Error: ${response.statusCode}');
//     }
//   } catch (e) {
//     log(e.toString());
//     print('Fetch error');
//   }

//   return result;
// }

// class HistoryDataClass extends ChangeNotifier {
//   dynamic data; // Use dynamic to handle both List and single instances
//   bool loading = false;

//   Future<void> getPostData(String endpoint) async {
//     loading = true;
//     data = await getData(endpoint);
//     loading = false;

//     notifyListeners();
//   }
// }
