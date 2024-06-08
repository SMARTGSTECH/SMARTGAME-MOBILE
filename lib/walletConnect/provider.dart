// connectProvider() async {
//     if (Ethereum.isSupported) {
//       final accs = await ethereum!.requestAccount();
//       if (accs.isNotEmpty) {
//         currentAddress = accs.first;
//         currentChain = await ethereum!.getChainId();
//       }

//       update();
//     }
//   }

import 'dart:convert';
import 'dart:math';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
// import 'package:flutter_web3/flutter_web3.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:provider/provider.dart' as p;
import 'package:smartbet/screens/home/provider.dart';
import 'package:smartbet/utils/base-url.dart';
import 'package:smartbet/utils/env.dart';
import 'package:smartbet/utils/helpers.dart';
import 'package:smartbet/widget/alertSnackBar.dart';
import 'package:walletconnect_flutter_v2/walletconnect_flutter_v2.dart';
import 'package:http/http.dart' as http;
import 'package:walletconnect_modal_flutter/services/walletconnect_modal/walletconnect_modal_service.dart';
import 'package:walletconnect_modal_flutter/walletconnect_modal_flutter.dart';
// import 'package:web3modal_flutter/web3modal_flutter.dart';

class UserWeb3Provider extends ChangeNotifier {
  dynamic? currentAddress;
  dynamic? usdBalance;
  dynamic? bnbBalance;
  int? currentChain;
  bool connected = false;
  bool isLoading = false;
  bool startedTransaction = false;

  dynamic weibalance;
  List cryptoRate = [];
  String cryptoBNBUSDT = "396";
  double userConvertedStaked = 0.0;
  // late W3MService w3mService;
  Web3App? _web3App;
  late WalletConnectModalService service;
  Future<void> initialize(context) async {
    // try {
    debugPrint('Project ID: ${DartDefines.projectId}');
    service = WalletConnectModalService(
      projectId: 'be0d3671eaede1506a668e53185c4d28',
      metadata: const PairingMetadata(
        name: 'BEI',
        description: 'SmartBet',
        url: 'https://walletconnect.com/',
        icons: ['https://walletconnect.com/walletconnect-logo.png'],
        redirect: Redirect(
          native: 'flutterdapp://',
          universal: 'https://www.walletconnect.com',
        ),
      ),
    );
    await service.init().whenComplete(() {
      print("initlized");

      print("open");
    });
    // notifyListeners();
  }

  connect() async {}

  void setConnection(bool, balance) {
    connected = bool;
    usdBalance = balance;
    notifyListeners();
  }

  void setTransactionLoader(bool) {
    startedTransaction = bool;
    notifyListeners();
  }

  void setcryptoBNBUSDT(value, context) {
    final coinP = p.Provider.of<CoinCapProvider>(context, listen: false);
    //print(varuntimeType);
    double result = userConvertedStaked = double.parse(value ?? 0) /
        coinP.coinArray.where((element) => element.name == "BNB").first.price;
    userConvertedStaked = double.parse(result.toStringAsFixed(7));

    print(userConvertedStaked);
    print(
        "usfing the rate of ${coinP.coinArray.where((element) => element.name == "BNB").first.price}");
    notifyListeners();
  }

  void setCryptoRate(rate) {
    // cryptoRate = rate;
    print("Rate has been set");
    List getRatePair =
        cryptoRate.where((element) => element['symbol'] == "BNBUSDT").toList();
    cryptoBNBUSDT = rate;
    print("this is the rate  $cryptoBNBUSDT");
    notifyListeners();
  }

  void setLoader(bool) {
    isLoading = bool;
    notifyListeners();
  }

  void disconnecWallet() {
    connected = false;
    usdBalance = 0;
    currentAddress = null;
    notifyListeners();
  }

  // Future<void> switchNetwork(number) async {
  //   await ethereum!.walletSwitchChain(number, () async {
  //     await ethereum!.walletAddChain(
  //       chainId: 97,
  //       chainName: 'Binance Testnet',
  //       nativeCurrency:
  //           CurrencyParams(name: 'BNB', symbol: 'BNB', decimals: 18),
  //       rpcUrls: ['https://data-seed-prebsc-1-s1.binance.org:8545/'],
  //     );
  //   });
  // }

  void doAfterConfirmation(context, wallet, amount, side, type) {
    Map object = {
      "wallet": wallet.toString(),
      "amount": amount.toString(),
      "side": side[0].toLowerCase().toString(),
      "type": type.toString(),
    };
    print('this is the new object ${object}');
    var status = stakeGame(object, context);
    print(status);
  }

  // initTransaction(amount, context, prediction, type) async {
  //   print(amount);
  //   final amountWei = (amount + 0.00004) * pow(10, 18);
  //   // Send 1000000000 wei to `0xcorge`
  //   try {
  //     final tx = await provider!.getSigner().sendTransaction(
  //           TransactionRequest(
  //             to: currentChain == 97
  //                 ? '0x0477186e7b6342e229fF58a2c0Eaa5eC1eDf7004'
  //                 : "0xeB683179cAB619B9FdF07C71B919D2AfD118CDE2",
  //             value: BigInt.from(amountWei),
  //           ),
  //         );

  //     tx.wait().whenComplete(() => doAfterConfirmation(
  //         context, currentAddress ?? "0x", amount, prediction, type));
  //   } on EthereumUserRejected {
  //     setTransactionLoader(false);
  //     CustomSnackBar(
  //         context: context, message: "Request Rejected By User", width: 235);
  //   } catch (e) {
  //     print(e);
  //   }
  // }

  // refreshWallet(Function callback, context) async {
  //   weibalance = await provider!.getSigner().getBalance();
  //   print("before convertion");

  //   print(weibalance.runtimeType);
  //   weibalance = weibalance / BigInt.from(pow(10, 18));
  //   print("-------------");
  //   print(weibalance);
  //   print(weibalance.runtimeType);
  //   final convertedWei =
  //       await weiToUsd(await provider!.getSigner().getBalance());
  //   callback(true, currentAddress, currentChain, convertedWei, weibalance);
  //   notifyListeners();
  // }

  // connectExtentionProvider(Function callback, context) async {
  //   if (!connected) {
  //     if (ethereum == null) {
  //       CustomSnackBar(
  //           context: context, message: "No Web3 Supported", width: 235);
  //       return;
  //     }

  //     try {
  //       var account = await ethereum!.requestAccount();
  //       weibalance = await provider!.getSigner().getBalance();
  //       print("object");
  //       weibalance = weibalance / BigInt.from(pow(10, 18));
  //       final convertedWei =
  //           await weiToUsd(await provider!.getSigner().getBalance());
  //       currentAddress = account[0];
  //       currentChain = await ethereum!.getChainId();
  //       // initTransaction(0.03843984939849348, context);
  //       print("object");
  //       callback(true, currentAddress, currentChain, convertedWei, weibalance);
  //       //
  //       print("object");
  //       callback(true, currentAddress, currentChain, 418, weibalance);
  //       print("object");
  //       notifyListeners();
  //     } on EthereumUserRejected {
  //       setLoader(false);
  //       CustomSnackBar(
  //           context: context, message: "Request Rejected By User", width: 235);
  //     } catch (e) {
  //       print(e);
  //     }

  //     // },
  //   }
  // }

  fetchRate(context) async {
    final coinP = p.Provider.of<CoinCapProvider>(context, listen: false);
    //userWallet.fetchRate();

    final dio = Dio();

    var _url = "https://api1.binance.com/api/v3/ticker/price";
    //print(responses.data);
    print("this rate is coming from coin remitter");
    print(
        coinP.coinArray.where((element) => element.name == "BNB").first.price);
    // http.Response response = await http.get(Uri.parse(_url));
    setCryptoRate(
        coinP.coinArray.where((element) => element.name == "BNB").first.price);
  }

  stakeGame(Map object, context) async {
    Map data = object;
    print("this is the map data:---- $data");
    try {
      final response = await http.post(
        Uri.parse(Apis.stake_url),
        body: json.encode(data),
        headers: {
          'Content-Type': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        // Successful POST request

        print('Response: ${response.body}');

        print("its sucessful");
        //try and fix this issue

        setTransactionLoader(false);
        // finish(context);
        finish(context);
        CustomSnackBar(
            context: context,
            message: "Staked Successful",
            width: 200,
            leftColor: Colors.green,
            icon: Icons.wallet);
        return response.statusCode;
      } else {
        // Handle errors
        print('Error: ${response.statusCode} - ${response.body}');
      }
    } catch (e) {
      // Handle exceptions
      print('Exception: $e');
    }
    //setCryptoRate(jsonDecode(response.body));
  }
}
