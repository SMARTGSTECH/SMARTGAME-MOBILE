// import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:smartbet/services/apiClient.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';

class CoinTable extends StatefulWidget {
  const CoinTable({super.key});

  @override
  _CoinTableState createState() => _CoinTableState();
}

class _CoinTableState extends State<CoinTable> {
  List<String> headers = [];
  List<dynamic> dataList = [];

  Future<void> fetchData() async {
    try {
      final dynamic response = await ApiClientService.get('/race');

      if (response is Map<String, dynamic> &&
          response['data'] is List<dynamic>) {
        print(response['data']);
        List value = response['data'];
        for (var map in value) {
          String createdAtString = map['createdAt'];
          DateTime createdAt = DateTime.parse(createdAtString);
          String formattedDate =
              DateFormat('yyyy-MM-dd hh:mm:ss a').format(createdAt);
          map['createdAt'] = formattedDate;
          map['odds'] = '${map['odds']}x';
          map.removeWhere((key, value) => key == 'key' || key == 'id');
          if (map.containsKey('createdAt')) {
            map['date'] = map['createdAt'];
            map.remove('createdAt');
          }
        }
        // for (var map in value) {
        //   if (map.containsKey('createdAt')) {
        //     map['date'] = map['createdAt'];
        //     map.remove('createdAt');
        //   }
        // }
        List<dynamic> data = value;

        if (data.isNotEmpty && data[0] is Map<String, dynamic>) {
          headers = data[0].keys.toList();

          dataList = data
              .map((item) => headers.map((header) => item[header]).toList())
              .toList();

          print('GET Data (Headers): $headers');
          print('GET Data (List): $dataList');
        } else {
          print('Unexpected data structure in the response.');
        }
      } else {
        print('Unexpected response type or missing "data" field.');
      }
    } catch (e) {
      print('GET Request failed: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: fetchData(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          return SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: SingleChildScrollView(
              child: DataTable(
                horizontalMargin: 8.0,
                columnSpacing: 55.0,
                columns: [
                  for (var header in headers)
                    DataColumn(
                      label: Text(
                        header,
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                ],
                rows: [
                  for (var rowData in dataList)
                    DataRow(
                      color: MaterialStateColor.resolveWith(
                        (Set<MaterialState> states) {
                          if (states.contains(MaterialState.selected)) {
                            return Color(0xFF001234); // Selected color
                          }
                          return Color(0xFF001234); // Default color
                        },
                      ),
                      cells: [
                        for (var data in rowData)
                          DataCell(
                            Container(
                              width: 100.0,
                              child: Text(
                                data?.toString() ?? '',
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                          ),
                      ],
                    ),
                ],
              ),
            ),
          );
        } else {
          return Center(
            child: Lottie.asset(
              "assets/images/beiLoader.json",
              height: 80,
              width: 80,
            ),
          );
        }
      },
    );
  }
}
