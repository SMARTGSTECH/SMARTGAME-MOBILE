import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiClientService {
  static const String getUrl = 'https://server.smartcryptobet.co/v1';
  static const String postUrl = 'https://server.smartcryptobet.co/v1';
  static String gamesession = '';
  // https://server.smartcryptobet.co/v1/game/parameter?key=K10llGN3RB

  static Future<dynamic> get(String path) async {
    final response =
        await http.get(Uri.parse('$getUrl/$path/history?key=K10llGN3RB'));
    return _handleResponse(response);
  }

  static Future<Map<String, dynamic>> post(
      String path, Map<String, dynamic> body) async {
    final response = await http.post(
      Uri.parse('$postUrl$path'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(body),
    );
    return _handleResponse(response);
  }

  static dynamic _handleResponse(http.Response response) {
    if (response.statusCode == 200) {
      final dynamic data = json.decode(response.body);

      // Check if the data is a List<dynamic> or a Map<String, dynamic>
      if (data is List<dynamic>) {
        return data;
      } else if (data is Map<String, dynamic>) {
        return data;
      } else {
        throw Exception('Unexpected response type');
      }
    } else {
      throw Exception(
          'Failed to load data. Status code: ${response.statusCode}');
    }
  }

  static getActiveSession(String type) async {
    final url = Uri.parse(
        'https://server.smartcryptobet.co/v1/$type/activesession?key=K10llGN3RB');

    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        final data = json.decode(response.body)['data'];

        gamesession = data['activesession'];
        print(gamesession);
      } else {
        throw Exception('Failed 1');
      }
    } catch (e) {
      throw Exception('Failed 2: $e');
    }
  }
}
