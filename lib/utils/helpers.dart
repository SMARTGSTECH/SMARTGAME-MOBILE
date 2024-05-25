import 'dart:convert';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;

const _ethUsdRate = 3000.00;
const _bnbrate = 447;
const chainId = 4;
const explorerAddressUrl = 'https://rinkeby.etherscan.io/address';
const explorerTxUrl = 'https://rinkeby.etherscan.io/tx';
dynamic rates;

String weiToEth(BigInt wei) {
  final result = wei / BigInt.from(pow(10, 18));
  var f = NumberFormat("#,###.#####");
  return f.format(result);
}

Future<String> weiToUsd(BigInt wei) async {
  //await getallprices().whenComplete(() => print(getPrice("BNBUSDT")));
  final result = wei / BigInt.from(pow(10, 18));
  var f = NumberFormat("#,###");
  // final value = (result * double.parse(getPrice("BNBUSDT")));
  final value = (result * 392.3);

  String formattedNumber = f.format(value);
  print(value);
  print(formattedNumber);
  return formattedNumber;
}

String bnbcal(BigInt wei) {
  final result = wei / BigInt.from(pow(10, 18));
  var f = NumberFormat("#,###.##");
  return f.format(result * _bnbrate);
}

String ethereumException(ex) {
  final str = ex.toString();
  if (str == "[object Object]") return 'User Rejected';
  final index = str.indexOf("\"message\"") + 11 + 20;
  final index2 = str.indexOf("\"", index);
  return str.substring(index, index2);
}

Future getallprices() async {
  if (true) {
    var _url = "https://api1.binance.com/api/v3/ticker/price";
    http.Response response = await http.get(Uri.parse(_url));
    print('api has come');

    rates = jsonDecode(response.body);

    //.Map decodedresponse = jsonDecode(utf8.decode(response.bodyBytes)) as Map;

    return response.body;
  } else {
    throw Exception('Failed to load coins');
  }
}

String getPrice(String pair) {
  List getRatePair =
      rates.where((element) => element['symbol'] == pair).toList();

  return getRatePair.length != 0
      ? double.parse(getRatePair[0]['price']).toStringAsFixed(2)
      : " 0";
}
