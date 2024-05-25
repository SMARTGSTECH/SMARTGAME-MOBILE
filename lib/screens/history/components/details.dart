import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:nb_utils/nb_utils.dart';
import 'package:provider/provider.dart';
import 'package:smartbet/screens/history/provider.dart';
import 'package:logger/logger.dart';

final Logger logger = Logger();

class Details extends StatefulWidget {
  // final String endpoint;

  // const Details({Key? key, required this.endpoint}) : super(key: key);

  @override
  State<Details> createState() => _DetailsState();
}

class _DetailsState extends State<Details> {
  late Future<List<HistoryDataModel>> futureData;
  // late String odds;
  // late String amount;
  // late String side;
  // late String wallet;
  // late String prediction;
  late String gameType;

  @override
  void initState() {
    super.initState();
    futureData = getData();
    gameType = '';
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: SizeConfig.screenWidth! <= 1160
          ? MediaQuery.of(context).size.width
          : 360,
      // padding: EdgeInsets.only(
      //     left: SizeConfig.screenWidth! <= 1160 ? 80 : 0,
      //     right: SizeConfig.screenWidth! <= 1160 ? 80 : 0),
      child: ListView.builder(
        key: const Key('uniqueKey'),
        physics: const AlwaysScrollableScrollPhysics(),
        shrinkWrap: true,
        itemCount: 6,
        itemBuilder: (context, index) {
          return Container(
              width: 10,
              padding: EdgeInsets.only(left: 10),
              decoration: BoxDecoration(
                color: const Color(0xFF001234),
                borderRadius: BorderRadius.circular(10.0),
              ),
              margin: const EdgeInsets.only(bottom: 20.0),
              child: ListTile(
                title: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        //column1
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Text(
                                  'Wallet Address:',
                                  style: TextStyle(
                                      fontSize: 12,
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold),
                                  textAlign: TextAlign.left,
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                Text(
                                  'Side Predicted:',
                                  style: TextStyle(
                                      fontSize: 12,
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold),
                                  textAlign: TextAlign.left,
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                Text(
                                  'Amount Staked:',
                                  style: TextStyle(
                                      fontSize: 12,
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold),
                                  textAlign: TextAlign.left,
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                Text(
                                  'Odds:',
                                  style: TextStyle(
                                      fontSize: 12,
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold),
                                  textAlign: TextAlign.left,
                                ),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Date:',
                                  style: TextStyle(
                                      fontSize: 12,
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold),
                                  // textAlign: TextAlign.left,
                                ),
                              ],
                            ),
                          ],
                        ),
                        Spacer(flex: 4),
                        //column2
                        Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Row(
                              children: [
                                Text(
                                  '0xcynf659mbjbcj.',
                                  style: TextStyle(
                                      fontSize: 12, color: Colors.white),
                                  textAlign: TextAlign.right,
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                Text(
                                  'Head',
                                  // postModel.post?.title ?? "",
                                  style: TextStyle(
                                      fontSize: 12, color: Colors.white),
                                  textAlign: TextAlign.right,
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                Text(
                                  '\$2.35.',
                                  style: TextStyle(
                                      fontSize: 12, color: Colors.white),
                                  textAlign: TextAlign.right,
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                Text(
                                  '1.50',
                                  style: TextStyle(
                                      fontSize: 12, color: Colors.white),
                                  textAlign: TextAlign.right,
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                Text(
                                  '2023-10-12',
                                  style: TextStyle(
                                      fontSize: 12, color: Colors.white),
                                  textAlign: TextAlign.right,
                                ),
                              ],
                            ),
                          ],
                        ),

                        // if(SizeConfig.screenWidth! <= 1160)
                        Spacer(),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Row(
                              children: [
                                Icon(
                                  Icons.account_balance_wallet,
                                  size: 19.0,
                                  color: Colors.white,
                                )
                              ],
                            ),
                            Row(
                              children: [
                                Icon(
                                  Icons.monetization_on,
                                  size: 19.0,
                                  color: Colors.white,
                                )
                              ],
                            ),
                            Row(
                              children: [
                                Icon(
                                  Icons.monetization_on_rounded,
                                  size: 19.0,
                                  color: Colors.white,
                                )
                              ],
                            ),
                            Row(
                              children: [
                                Icon(
                                  Icons.account_balance_wallet,
                                  size: 19.0,
                                  color: Colors.white,
                                )
                              ],
                            ),
                            Row(
                              children: [
                                Icon(
                                  Icons.alarm,
                                  size: 19.0,
                                  color: Colors.white,
                                )
                              ],
                            ),
                          ],
                        )
                      ],
                    )
                  ],
                ),
              ));
        },
      ),
    );
  }
}

class TabletDetails extends StatelessWidget {
  const TabletDetails({super.key});

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}



// FutureBuilder<List<HistoryDataModel>>(
//                 future: futureData,
//                 builder: (context, snapshot) {
//                   if (snapshot.connectionState == ConnectionState.waiting) {
//                     return Center(child: CircularProgressIndicator());
//                   } else if (snapshot.hasError) {
//                     return Text('Error');
//                   } else {
//                     final dataList = snapshot.data!;

//                     final gameDatas = dataList.firstWhere(
//                         (game) => game.type == 'dice',
//                         orElse: () => HistoryDataModel(
//                             amount: '',
//                             prediction: '',
//                             odds: '',
//                             side: '',
//                             wallet: '',
//                             type: 'dice'));
//                    final gameType = gameDatas.wallet;
