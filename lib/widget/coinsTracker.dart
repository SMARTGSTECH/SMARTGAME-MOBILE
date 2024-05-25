import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:smartbet/utils/config/config.dart';

class coincard extends StatelessWidget {
  coincard({
    required this.name,
    required this.symbol,
    required this.rank,
    required this.imageUrl,
    required this.price,
    required this.change,
    required this.changePercentage,
  });

  String name;
  String symbol;
  int rank;
  String imageUrl;
  double price;
  double change;
  double changePercentage;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Container(
        //width: 600,
        decoration: BoxDecoration(
            color: barcolor,
            border: Border.all(color: customwhitecolor),
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              // BoxShadow(
              //     color: mybackgroundcolor,
              //     offset: Offset(4, -4),
              //     blurRadius: 10,
              //     spreadRadius: 1),
            ]),
        child: Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: Container(
              decoration: BoxDecoration(
                  color: barcolor,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                        color: Color(0xff0A0D28),
                        offset: Offset(4, 4),
                        blurRadius: 10,
                        spreadRadius: 1),
                    BoxShadow(
                        color: Color.fromARGB(255, 78, 92, 13),
                        offset: Offset(-4, -4),
                        blurRadius: 10,
                        spreadRadius: 1),
                  ]),
              height: 60,
              width: 60,
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Image.network(imageUrl),
              ),
            ),
          ),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                FittedBox(
                  fit: BoxFit.scaleDown,
                  child: Text(
                    name,
                    style: TextStyle(
                        color: myiconcolor,
                        //  fontSize: 20,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                Text(
                  symbol,
                  style: TextStyle(
                      color: myiconcolor,
                      // fontSize: 20,
                      fontWeight: FontWeight.bold),
                ),
                Text(
                  'Rank:' + rank.toInt().toString(),
                  style: TextStyle(
                      color: myiconcolor,
                      //// fontSize: 18,
                      fontWeight: FontWeight.bold),
                )
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                FittedBox(
                  child: Text(
                    '\$' + price.toDouble().toString(),
                    style: TextStyle(
                        color: myiconcolor,
                        //fontSize: 18,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                Text(
                  change.toDouble() < 0
                      ? change.toDouble().toStringAsFixed(2) + '%'
                      : '+' + change.toDouble().toStringAsFixed(2) + '%',
                  style: TextStyle(
                      color: change.toDouble() < 0 ? Colors.red : Colors.green,
                      // fontSize: 18,
                      fontWeight: FontWeight.bold),
                ),
                Text(
                  '24hrs',
                  style: TextStyle(
                      color: changePercentage.toDouble() < 0
                          ? Colors.red
                          : Colors.green,
                      //  fontSize: 18,
                      fontWeight: FontWeight.bold),
                ),
              ],
            ),
          )
        ]),
      ).onTap(() {
        print(imageUrl);
      }),
    );
  }
}



// import 'package:flutter/material.dart';

// //import 'package:smartbet/constants/colors.dart';
// import 'dart:async';
// import 'dart:convert';
// //import 'dart:ffi';

// import 'package:carousel_slider/carousel_slider.dart';
// import 'package:flutter/material.dart';
// //import 'package:smart_bet/coinapi.dart';
// import 'package:http/http.dart' as http;
// import 'package:smartbet/model/coinCapModel.dart';

// import 'package:smartbet/utils/config/config.dart';

// //import 'package:smart_bet/mycoinapi.dart';
// //import 'package:smart_bet/coinapi.dart';
// //import 'package:smart_bet/mycoinapi.dart';

// class coincap extends StatefulWidget {  
//   const coincap({Key? key}) : super(key: key);

//   @override
//   _coincapState createState() => _coincapState();
// }

// class _coincapState extends State<coincap> {
//   List<coinCapModel> myarray = [];
//   Future<List<coinCapModel>> _fetchCoin() async {
//     final apidata = await http.get(Uri.parse(
//         'https://api.coingecko.com/api/v3/coins/markets?vs_currency=usd&order=market_cap_desc&per_page=100&page=1&sparkline=false'));
//     print(apidata.statusCode);
//     if (apidata.statusCode == 200) {
//       List<dynamic> values = [];
//       values = json.decode(apidata.body);

//       if (values.length > 0) {
//         for (int i = 0; i < values.length; i++) {
//           if (values[i] != null) {
//             Map<String, dynamic> map = values[i];
//             myarray.add(coinCapModel.fromJson(map));
//           }
//         }
//       }
//       print("array");
//       print(myarray[0].name);
//       return myarray;
//     } else {
//       throw Exception('Failed to load coins');
//     }
//   }

//   @override
//   void initState() {
//     _fetchCoin();
//   }

//   //Initialize state variables
//   double sWidth = 0;
//   double sHeight = 0;
//   @override
//   Widget build(BuildContext context) {
//     print(myarray);
//     sWidth = MediaQuery.of(context).size.width;
//     sHeight = MediaQuery.of(context).size.height;
//     return Scaffold(
//         body: myarray.isEmpty
//             ? Center(
//                 child: CircularProgressIndicator(
//                   backgroundColor: Colors.amber,
//                   color: Color.fromARGB(255, 0, 0, 0),
//                 ),
//               )
//             : SizedBox(
//                 //height: sHeight * double.infinity,
//                 child: CarouselSlider(
//                   items: [
//                     ...List.generate(
//                       myarray.length,
//                       (index) => coincard(
//                         name: myarray[index].name,
//                         symbol: myarray[index].symbol,
//                         rank: myarray[index].rank.toInt(),
//                         imageUrl: myarray[index].imageUrl,
//                         price: myarray[index].price.toDouble(),
//                         change: myarray[index].changePercentage.toDouble(),
//                         changePercentage:
//                             myarray[index].changePercentage.toDouble(),
//                       ),
//                     )
//                   ],
//                   options: CarouselOptions(
//                     autoPlay: true,
//                     height: sHeight * double.infinity,
//                     autoPlayInterval: const Duration(seconds: 4),
//                     enableInfiniteScroll: true,
//                   ),
//                 ),
//               ));
//   }
// }


// class coincard extends StatelessWidget {
//   coincard({
//     required this.name,
//     required this.symbol,
//     required this.rank,
//     required this.imageUrl,
//     required this.price,
//     required this.change,
//     required this.changePercentage,
//   });

//   String name;
//   String symbol;
//   int rank;
//   String imageUrl;
//   double price;
//   double change;
//   double changePercentage;

//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.all(10.0),
//       child: Container(
//         //  width: 50,
//         decoration: BoxDecoration(
//             color: barcolor,
//             border: Border.all(color: customwhitecolor),
//             borderRadius: BorderRadius.circular(20),
//             boxShadow: [
//               // BoxShadow(
//               //     color: mybackgroundcolor,
//               //     offset: Offset(4, -4),
//               //     blurRadius: 10,
//               //     spreadRadius: 1),
//             ]),
//         child: Row(children: [
//           Padding(
//             padding: const EdgeInsets.all(15.0),
//             child: Container(
//               decoration: BoxDecoration(
//                   color: barcolor,
//                   borderRadius: BorderRadius.circular(20),
//                   boxShadow: [
//                     BoxShadow(
//                         color: Color(0xff0A0D28),
//                         offset: Offset(4, 4),
//                         blurRadius: 10,
//                         spreadRadius: 1),
//                     BoxShadow(
//                         color: Color.fromARGB(255, 78, 92, 13),
//                         offset: Offset(-4, -4),
//                         blurRadius: 10,
//                         spreadRadius: 1),
//                   ]),
//               height: 60,
//               width: 60,
//               child: Padding(
//                 padding: const EdgeInsets.all(10.0),
//                 child: Image.network(imageUrl),
//               ),
//             ),
//           ),
//           Expanded(
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.center,
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 FittedBox(
//                   fit: BoxFit.scaleDown,
//                   child: Text(
//                     name,
//                     style: TextStyle(
//                         color: myiconcolor,
//                         //  fontSize: 20,
//                         fontWeight: FontWeight.bold),
//                   ),
//                 ),
//                 Text(
//                   symbol,
//                   style: TextStyle(
//                       color: myiconcolor,
//                       // fontSize: 20,
//                       fontWeight: FontWeight.bold),
//                 ),
//                 Text(
//                   'Rank:' + rank.toInt().toString(),
//                   style: TextStyle(
//                       color: myiconcolor,
//                       //// fontSize: 18,
//                       fontWeight: FontWeight.bold),
//                 )
//               ],
//             ),
//           ),
//           Padding(
//             padding: const EdgeInsets.all(10.0),
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.center,
//               crossAxisAlignment: CrossAxisAlignment.end,
//               children: [
//                 FittedBox(
//                   child: Text(
//                     '\$' + price.toDouble().toString(),
//                     style: TextStyle(
//                         color: myiconcolor,
//                         //fontSize: 18,
//                         fontWeight: FontWeight.bold),
//                   ),
//                 ),
//                 Text(
//                   change.toDouble() < 0
//                       ? change.toDouble().toStringAsFixed(2) + '%'
//                       : '+' + change.toDouble().toStringAsFixed(2) + '%',
//                   style: TextStyle(
//                       color: change.toDouble() < 0 ? Colors.red : Colors.green,
//                       // fontSize: 18,
//                       fontWeight: FontWeight.bold),
//                 ),
//                 Text(
//                   '24hrs',
//                   style: TextStyle(
//                       color: changePercentage.toDouble() < 0
//                           ? Colors.red
//                           : Colors.green,
//                       //  fontSize: 18,
//                       fontWeight: FontWeight.bold),
//                 ),
//               ],
//             ),
//           )
//         ]),
//       ),
//     );
//   }
// }
