import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class CryptoData extends StatefulWidget {
  const CryptoData({Key? key}) : super(key: key);

  @override
  State<CryptoData> createState() => _CryptoDataState();
}

class _CryptoDataState extends State<CryptoData> {
  List<dynamic> dataList = [];

  Future<void> fetchData() async {
    try {
      final response = await http.get(Uri.parse(
          'https://api.coingecko.com/api/v3/coins/markets?vs_currency=usd&order=market_cap_desc&per_page=100&page=1&sparkline=false'));

      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);

        if (data.isNotEmpty && data[0] is Map<String, dynamic>) {
          // Assign the list of objects to dataList
          setState(() {
            dataList = data;
          });
        } else {
          print('Unexpected data structure in the response.');
        }
      } else {
        print('Failed to fetch data. Status code: ${response.statusCode}');
      }
    } catch (e) {
      print('GET Request failed: $e');
    }
  }

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  String shrinkText(String text, int maxLength) {
    if (text.length <= maxLength) {
      return text;
    } else {
      return text.substring(0, maxLength);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: CarouselSlider.builder(
        itemCount: dataList.length,
        itemBuilder: (BuildContext context, int index, int realIndex) {
          // Check if index is within the valid range
          if (index >= 0 && index < dataList.length) {
            // Access specific properties like id andn symbol from each object
            final id = dataList[index]['id'];
            final symbol = dataList[index]['symbol'];
            final imageUrl = dataList[index]['image'];
            final rank = dataList[index]['market_cap_rank'];
            final priceChangeKey = 'price_change_24h';
            final rawPriceChange = dataList[index][priceChangeKey];

            // Truncate the rawPriceChange value to a maximum length of 5 characters
            final truncatedPriceChange =
                shrinkText(rawPriceChange.toString(), 7);

            return Container(
                height: 130,
                width: 400,
                padding:
                    EdgeInsets.only(bottom: 20, top: 20, left: 10, right: 15),
                margin: EdgeInsets.all(10),
                decoration: BoxDecoration(
                    color: Colors.black,
                    border: Border.all(style: BorderStyle.none),
                    borderRadius: BorderRadius.circular(18)),
                child: Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            height: 4,
                            width: 45,
                            margin: EdgeInsets.only(left: 15),
                            padding: EdgeInsets.all(18),

                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                                color: const Color.fromARGB(255, 10, 10, 10),
                                boxShadow: const [
                                  BoxShadow(
                                    color: Color(0xFF7A8929),
                                    offset: Offset(-6.4, -6.4),
                                    blurRadius: 18,
                                    spreadRadius: 0.0,
                                  ),
                                  BoxShadow(
                                    color: Color(0xFF7A8929),
                                    offset: Offset(1.4, 1.4),
                                    blurRadius: 1,
                                    spreadRadius: 0.0,
                                  ),
                                ]),
                            child: Image.network(
                              imageUrl,
                              // "https://assets.coingecko.com/coins/images/825/large/bnb-icon2_2x.png?1696501970",
                              //   color: imgcolor,
                              width: 25,
                              height: 15,
                            ),
                            // Image.network(imageUrl),
                            //     NetImageWidget()
                          )
                        ],
                      ),
                      Spacer(),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                              width: 200,
                              child: Row(
                                children: [
                                  Column(
                                    children: [
                                      Text(
                                        '$id \n$symbol \nRank: $rank',
                                        style: TextStyle(
                                            color: Colors.white, fontSize: 10),
                                      )
                                    ],
                                  ),
                                  Spacer(),
                                  Column(
                                    children: [
                                      Text(
                                        '\$$truncatedPriceChange \n0.38% \n24hrs',
                                        style: TextStyle(
                                            color: Colors.white, fontSize: 10),
                                        textAlign: TextAlign.end,
                                      )
                                    ],
                                  )
                                ],
                              )),
                        ],
                      ),
                    ],
                  ),
                ));
          } else {
            // Return a placeholder widget or handle the out-of-range case
            return Container(
              width: 0, // Set to 0 to make it invisible
            );
          }
        },
        options: CarouselOptions(
          height: 130,
          // enlargeCenterPage: true,
          // aspectRatio: 16 / 9,
          autoPlay: true,
          autoPlayCurve: Curves.fastOutSlowIn,
          enableInfiniteScroll: true,
          autoPlayAnimationDuration: Duration(milliseconds: 800),
          viewportFraction: 0.8,
          scrollDirection: Axis.horizontal,
        ),
      ),
    ));
  }
}

// class NetImageWidget extends StatelessWidget {
//   const NetImageWidget({
//     super.key,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Image.network(
//                                     ' Image.network(imageUrl)',
//                                     loadingBuilder: (BuildContext context,
//       Widget child,
//       ImageChunkEvent? loadingProgress) {
//     if (loadingProgress == null) {
//       return child;
//     } else {
//       return Center(
//         child: CircularProgressIndicator(
//           value: loadingProgress
//                       .expectedTotalBytes !=
//                   null
//               ? loadingProgress
//                       .cumulativeBytesLoaded /
//                   (loadingProgress
//                           .expectedTotalBytes ??
//                       1)
//               : null,
//         ),
//       );
//     }
//                                     },
//                                     errorBuilder: (BuildContext context,
//       Object error, StackTrace? stackTrace) {
//     print('Error loading image: $error');
//     return Center(
//       child: Text('Error loading image'),
//     );
//                                     },
//                                   );
//   }
// }







