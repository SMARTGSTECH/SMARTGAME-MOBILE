import 'dart:convert';
import 'package:http/http.dart' as http;

class CoinData {
  final String wallet;
  final double amount;
  final double side;
  final String prediction;
  final double odds;
  final String type;
  final DateTime createdAt;

  CoinData({
    required this.wallet,
    required this.amount,
    required this.side,
    required this.prediction,
    required this.odds,
    required this.type,
    required this.createdAt,
  });

  factory CoinData.fromJson(Map<String, dynamic> json) {
    String createdAtString = json['createdAt'] ?? '';
    if (createdAtString.isNotEmpty) {
      createdAtString = createdAtString.replaceFirst('.000Z', '');
      DateTime createdAt = DateTime.parse(createdAtString);

      return CoinData(
        wallet: shortenWalletAddress(json['wallet'] ?? ''),
        amount: json['amount'] != null
            ? double.tryParse(json['amount'].toString()) ?? 0.0
            : 0.0,
        prediction: json['prediction'] ?? '',
        odds: json['odds'] != null
            ? double.tryParse(json['odds'].toString()) ?? 0.0
            : 0.0,
        side: json['side'] != null
            ? double.tryParse(json['side'].toString()) ?? 0.0
            : 0.0,
        type: json['type'] ?? '',
        createdAt: createdAt,
      );
    } else {
      return CoinData(
        wallet: '',
        amount: 0.0,
        prediction: '',
        odds: 0.0,
        side: 0.0,
        type: '',
        createdAt: DateTime.now(),
      );
    }
  }
}
//https://server.smartcryptobet.co/v1/game/coinsessionprices
//K10llGN3RB

Future<List<CoinData>> fetchCoinOdds() async {
  final url = Uri.parse(
      'https://server.smartcryptobet.co/v1/coin/history?key=K10llGN3RB');

  try {
    final response = await http.get(url);
    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body)['data'];
      return data.map((item) => CoinData.fromJson(item)).toList();
    } else {
      throw Exception('Failed 1');
    }
  } catch (e) {
    throw Exception('Failed 2: $e');
  }
}

// K10llGN3RB

String shortenWalletAddress(String address,
    {int prefixLength = 6, int suffixLength = 6}) {
  if (address.length <= prefixLength + suffixLength) {
    return address;
  } else {
    final String prefix = address.substring(0, prefixLength);
    final String suffix = address.substring(address.length - suffixLength);
    return '$prefix.....$suffix';
  }
}
