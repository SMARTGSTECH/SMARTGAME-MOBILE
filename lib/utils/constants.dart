import 'package:flutter/material.dart';

TextEditingController carGameController = TextEditingController();
TextEditingController diceGameController = TextEditingController();
TextEditingController fruitGamecontroller = TextEditingController();
TextEditingController coinGameController = TextEditingController();
TextEditingController predictionContoller = TextEditingController();

Map contractLive = {
  "ETH": "0x6C6D8FefD85487A514B376a722570fcdFac511fF",
  "TON": "EQDNVnl7p5QYwMTzrQGvYHL9-wb_xbsT7rTnC_RrpJNcpXyz",
  "USDT": "0x6C6D8FefD85487A514B376a722570fcdFac511fF",
  "SOL": "9QGjbdoK1AtS7BMbt4F8m6i8zCPXx8PsW6e4A2xR6L5j"
};

//  car
//                                                     ? carProvider.blue
//                                                         ? "blue"
//                                                         : carProvider.green
//                                                             ? "green"
//                                                             : carProvider.yellow
//                                                                 ? "yellow"
//                                                                 : "red"
//                                                     : dice
//                                                         ? diceProvider.one
//                                                             ? "1"
//                                                             : diceProvider.two
//                                                                 ? "2"
//                                                                 : diceProvider
//                                                                         .three
//                                                                     ? "3"
//                                                                     : diceProvider
//                                                                             .four
//                                                                         ? "4"
//                                                                         : diceProvider.five
//                                                                             ? "5"
//                                                                             : diceProvider.six
//                                                         ? "6" : fruit ? fruitProvider.banana ? "banana":,