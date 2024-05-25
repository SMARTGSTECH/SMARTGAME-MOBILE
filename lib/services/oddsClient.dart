import 'dart:convert';
import 'package:http/http.dart' as http;

class Odds {
  final int id;
  final double maxAmount;
  final double minAmount;
  final double odds;
  final String type;

  Odds({
    required this.id,
    required this.maxAmount,
    required this.minAmount,
    required this.odds,
    required this.type,
  });

  factory Odds.fromJson(Map<String, dynamic> json) {
    return Odds(
      id: json['id'],
      maxAmount: json['maxAmount'].toDouble(),
      minAmount: json['minAmount'].toDouble(),
      odds: json['odds'].toDouble(),
      type: json['type'],
    );
  }
}

Future<List<Odds>> fetchOdds() async {
  final url = Uri.parse(
      'https://server.smartcryptobet.co/v1/game/parameter?key=K10llGN3RB');

  try {
    final response = await http.get(url);
    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body)['data'];
      return data.map((item) => Odds.fromJson(item)).toList();
    } else {
      throw Exception('Failed 1');
    }
  } catch (e) {
    throw Exception('Failed 2: $e');
  }
}
