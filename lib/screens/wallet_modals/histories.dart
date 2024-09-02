import 'dart:math' as math;

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:provider/provider.dart';
import 'package:smartbet/constants/strings.dart';
import 'package:smartbet/model/tx_history.dart';
import 'package:smartbet/screens/wallet_modals/wallet.dart';
import 'package:smartbet/services/storage.dart';
import 'package:smartbet/shared/modal_sheet.dart';
import 'package:smartbet/utils/config/color.dart';
import 'package:smartbet/utils/helpers.dart';
import 'package:smartbet/walletConnect/wallet_provider.dart';
import 'package:url_launcher/url_launcher.dart';

class WalletHistories extends StatefulWidget {
  final Map<String, dynamic> addresses;
  const WalletHistories({super.key, required this.addresses});

  @override
  State<WalletHistories> createState() => _WalletHistoriesState();
}

class _WalletHistoriesState extends State<WalletHistories> {
  late Web3Provider web3provider;
  List<TxResult> data = [];

  @override
  void initState() {
    web3provider = Provider.of<Web3Provider>(context, listen: false);
    getData();
    super.initState();
  }

  getData() async {
     ///TODO: add a loading indicator here that will show when the data is being fetched
    data = await web3provider.fetchAllTransfers(widget.addresses);
    log("history value: $data");
    setState(() {});
  }

  loadExplorer(TxResult history) {
    String url = '';
    switch (history.tokenSymbol) {
      case 'ETH':
        url = 'https://basescan.org/tx/${history.transactionHash}';
      case 'BNB':
        url = 'https://bscscan.com/tx/${history.transactionHash}';
      case 'USDT':
        url = 'https://bscscan.com/tx/${history.transactionHash}';
      case 'TON':
        url = 'https://ton.live/transactions/${history.transactionHash}';
      case 'SOL':
        url = 'https://solscan.io/tx/${history.transactionHash}';
      default:
        url = 'https://etherscan.io/tx/${history.transactionHash}';
    }
    openBrowser(url);
  }

  void openBrowser(String url) async {
    Uri uri = Uri.parse(url);
    if (!await launchUrl(uri, mode: LaunchMode.inAppBrowserView)) {
      throw Exception('Could not launch $url');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: kBackgroundColor,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 18.0),
          child: LayoutBuilder(builder: (context, constraints) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: constraints.maxHeight * 0.03),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Wallet History',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: const Icon(Icons.close),
                    )
                  ],
                ),
                3.h.toInt().height,
                const Text(
                  'This is your wallet history. You can view all your transactions here.',
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey,
                  ),
                ),
                20.h.toInt().height,
                Expanded(
                  child: ListView.builder(
                    itemCount: data.length,
                    itemBuilder: (context, index) {
                      int totalAmount =
                          ((data[index].value!.toDouble()) * math.pow(10, 8))
                              .toInt();
                      return Container(
                        margin: EdgeInsets.only(bottom: 10.h),
                        padding: EdgeInsets.all(10.h),
                        decoration: BoxDecoration(
                          // color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Row(
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    data[index].tokenName!,
                                    style: const TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white),
                                  ),
                                  5.h.toInt().height,
                                  Text(
                                    data[index].blockTimestamp.toString(),
                                    style: const TextStyle(
                                      fontSize: 14,
                                      color: Colors.grey,
                                    ),
                                  ),
                                  5.h.toInt().height,
                                  Text(
                                    totalAmount.toDouble().toStringAsFixed(8),
                                    style: const TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.green),
                                  ),
                                  5.h.toInt().height,
                                  Text(
                                    truncate(data[index].toAddress!,
                                        length: 18),
                                    style: const TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white),
                                  ),
                                ],
                              ),
                            ),
                            GestureDetector(
                                onTap: () {
                                  loadExplorer(data[index]);
                                },
                                child: const Icon(Icons.open_in_browser))
                          ],
                        ),
                      );
                    },
                  ),
                ),
                //const Spacer(),
                GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                    modalSetup(web3provider.mainContext,
                        modalPercentageHeight: 0.9,
                        createPage: const UserWallet(),
                        showBarrierColor: true);
                  },
                  child: Container(
                    width: double.infinity,
                    height: 40.h,
                    decoration: BoxDecoration(
                      color: ColorConfig.blue,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: const Center(
                      child: Text(
                        'Back to Wallet',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
                10.h.toInt().height,
              ],
            );
          }),
        ),
      ),
    );
  }
}
