import 'package:avatar_glow/avatar_glow.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:provider/provider.dart';
import 'package:smartbet/screens/car/carhistory/carapi.dart' as helper;
import 'package:smartbet/screens/car/provider.dart';
import 'package:smartbet/screens/coin/coinhistory/coinapi.dart';
import 'package:smartbet/screens/fruit/provider.dart';
import 'package:smartbet/screens/history/components/details.dart';
import 'package:smartbet/screens/history/desktop.dart';
import 'package:smartbet/socket/provider.dart';
import 'package:smartbet/utils/config/color.dart';
import 'package:smartbet/utils/config/size.dart';
import 'package:smartbet/walletConnect/provider.dart';
import 'package:smartbet/widget/alertSnackBar.dart';
import 'package:smartbet/widget/button.dart';
import 'package:smartbet/widget/customAppBar.dart';
import 'package:smartbet/widget/gameWidget.dart';
import 'package:smartbet/widget/resultWidget.dart';
import 'package:smartbet/widget/stakeContainer.dart';

class CoinHistoryMobile extends StatefulWidget {
  const CoinHistoryMobile({super.key, required this.isStake});
  final bool isStake;

  @override
  State<CoinHistoryMobile> createState() => _CoinHistoryMobileState();
}

class _CoinHistoryMobileState extends State<CoinHistoryMobile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: ColorConfig.appBar,
        appBar: customAppbarNOWallet(context),
        body: SingleChildScrollView(
          child: widget.isStake
              ? myStakeWidget(
                  isStake: widget.isStake,
                )
              : Container(
                  decoration: BoxDecoration(color: Color(0xFF034F96)),
                  child: myStakeWidget(
                    isStake: widget.isStake,
                  ).paddingSymmetric(vertical: 20, horizontal: 10),
                ),
        ));
  }
}

class myStakeWidget extends StatefulWidget {
  const myStakeWidget({super.key, required this.isStake});
  final isStake;

  @override
  State<myStakeWidget> createState() => _myStakeWidgetState();
}

class _myStakeWidgetState extends State<myStakeWidget> {
  late Future<List<CoinData>> futureData;
  late String wallet;
  late String prediction;
  late String amount;
  late String odds;
  late String side;
  late String createAt;

  @override
  void initState() {
    super.initState();
    futureData = fetchCoinOdds();

    wallet = '';
    prediction = '';
    amount = '';
    odds = '';
    side = '';
    createAt = '';
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<CoinData>>(
      future: futureData,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
              child: CircularProgressIndicator()
                  .paddingSymmetric(vertical: SizeConfigs.screenHeight / 2));
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        } else {
          UserWeb3Provider userWallet =
              Provider.of<UserWeb3Provider>(context, listen: false);
          print(userWallet.currentAddress ?? "0xde");
          print(userWallet.currentAddress ?? "0xde");
          print(widget.isStake);
          print(snapshot.data!.first.wallet);

          final dataList = widget.isStake
              ? snapshot.data!
                  .where((element) =>
                      element.wallet.toLowerCase() ==
                      shortenWalletAddress(userWallet.currentAddress ?? "0xde")
                          .toLowerCase())
                  .toList()
              : snapshot.data!;
          print(dataList);
          if (dataList.isEmpty && userWallet.currentAddress == null) {
            return const Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Center(child: Text("Please Connect wallet")),
              ],
            ).paddingSymmetric(vertical: SizeConfigs.screenHeight / 2);
          }
          if (dataList.isEmpty) {
            return const Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Center(child: Text("You have not made any transaction")),
              ],
            ).paddingSymmetric(vertical: SizeConfigs.screenHeight / 2);
          }

          return ListView.builder(
            key: const Key('uniqueKey'),
            physics: const AlwaysScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: dataList.length,
            itemBuilder: (context, index) {
              final raceData = dataList[index];
              final wallet = raceData.wallet;
              final prediction = raceData.prediction.toString();
              final amount = raceData.amount.toString();
              final odds = raceData.odds.toString();
              // final side = raceData.side.toString();
              final createAt = raceData.createdAt.toString();

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
                          children: [
                            Text("wallet address :"),
                            SizedBox(width: 10),
                            Expanded(
                              child: Text(
                                wallet,
                                overflow: TextOverflow.ellipsis,
                                textAlign: TextAlign.right,
                              ),
                            ),
                            SizedBox(width: 10),
                            Icon(Icons.wallet),
                          ],
                        ),
                        Row(
                          children: [
                            Text("prediction :"),
                            SizedBox(width: 10),
                            Expanded(
                              child: Text(
                                '$prediction',
                                overflow: TextOverflow.ellipsis,
                                textAlign: TextAlign.right,
                              ),
                            ),
                            SizedBox(width: 10),
                            Icon(Icons.gamepad),
                          ],
                        ),
                        Row(
                          children: [
                            Text("amount staked :"),
                            SizedBox(width: 10),
                            Expanded(
                              child: Text(
                                amount,
                                overflow: TextOverflow.ellipsis,
                                textAlign: TextAlign.right,
                              ),
                            ),
                            SizedBox(width: 10),
                            Icon(Icons.money),
                          ],
                        ),
                        Row(
                          children: [
                            Text("odds :"),
                            SizedBox(width: 10),
                            Expanded(
                              child: Text(
                                odds,
                                overflow: TextOverflow.ellipsis,
                                textAlign: TextAlign.right,
                              ),
                            ),
                            SizedBox(width: 10),
                            Icon(Icons.bar_chart),
                          ],
                        ),
                        Row(
                          children: [
                            Text("date :"),
                            Expanded(
                              child: Text(
                                createAt,
                                overflow: TextOverflow.ellipsis,
                                textAlign: TextAlign.right,
                              ),
                            ),
                            Icon(Icons.alarm),
                          ],
                        ),
                      ],
                    ),
                  ));
            },
          );
        }
      },
    );
  }
}
