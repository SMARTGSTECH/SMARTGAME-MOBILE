// ignore_for_file: use_build_context_synchronously, non_constant_identifier_names

import 'dart:async';
import 'dart:developer';
import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:smartbet/constants/assets_path.dart';
import 'package:smartbet/constants/strings.dart';
import 'package:smartbet/screens/wallet_modals/save_mnemonics.dart';
import 'package:smartbet/screens/wallet_modals/wallet.dart';
import 'package:smartbet/services/storage.dart';
import 'package:smartbet/services/token_factory.dart';
import 'package:smartbet/shared/modal_sheet.dart';
import 'package:trust_wallet_core_lib/trust_wallet_core_ffi.dart';
import 'package:trust_wallet_core_lib/trust_wallet_core_lib.dart';
import 'package:web3dart/crypto.dart';
import 'package:web3dart/web3dart.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:solana_web3/solana_web3.dart' as web3;
import 'package:solana_web3/programs.dart' show SystemProgram;
import 'package:solana_web3/src/encodings/lamports.dart';
import 'package:solana_web3/src/rpc/models/blockhash_with_expiry_block_height.dart';

class Web3Provider with ChangeNotifier {
  bool _keyBoardActive = false;
  late StreamSubscription<bool> keyboardSubscription;
  TokenFactory tokenFactory = TokenFactory();
  List _generatedMnemonics = [];
  String enteredMnemonics = "";
  String _ethBalance = "0.0000";
  String _bnbBalance = "0.0000";
  String _usdtBalance = "0.0000";
  final String _solBalance = "0.0000";
  List get userMnemonics => _generatedMnemonics;
  bool get isKeyBoardActive => _keyBoardActive;
  String get userEthBalance => _ethBalance;
  String get userBnbBalance => _bnbBalance;
  String get userUsdtBalance => _usdtBalance;
  String get userSolBalance => _solBalance;

  TextEditingController one = TextEditingController();
  TextEditingController two = TextEditingController();
  TextEditingController three = TextEditingController();
  TextEditingController four = TextEditingController();
  TextEditingController five = TextEditingController();
  TextEditingController six = TextEditingController();
  TextEditingController seven = TextEditingController();
  TextEditingController eight = TextEditingController();
  TextEditingController nine = TextEditingController();
  TextEditingController ten = TextEditingController();
  TextEditingController eleven = TextEditingController();
  TextEditingController twelve = TextEditingController();

  Web3Provider() {
    log("Web3Provider initialized");
    var keyboardVisibilityController = KeyboardVisibilityController();

    // Subscribe
    keyboardSubscription =
        keyboardVisibilityController.onChange.listen((bool visible) {
      _keyBoardActive = visible;
      log('Keyboard visibility update. Is visible: $visible');
      //notifyListeners();
    });
  }

  BuildContext? _context;
  BuildContext get mainContext => _context!;

  void setContext(BuildContext context) {
    _context = context;
  }

  createMultiWalletSystem(BuildContext modalContext) async {
    try {
      HDWallet newWalletInstance = HDWallet();
      String mnemonics = newWalletInstance.mnemonic();
      await Storage.saveData(WALLET_MNEMONICS, mnemonics);
      _generatedMnemonics = List.from(mnemonics.split(' '));
      String solWalletAddress =
          newWalletInstance.getAddressForCoin(TWCoinType.TWCoinTypeSolana);
      String usdtWalletAddress =
          newWalletInstance.getAddressForCoin(TWCoinType.TWCoinTypeSmartChain);
      String bnbbscWalletAddress =
          newWalletInstance.getAddressForCoin(TWCoinType.TWCoinTypeSmartChain);

      String ethbaseWalletAddress =
          newWalletInstance.getAddressForCoin(TWCoinType.TWCoinTypeEthereum);
      log('----- solana address: $solWalletAddress');
      log('----- usdt(BSC) address: $usdtWalletAddress');
      log('----- BNB(BSC) address: $bnbbscWalletAddress');
      log('----- ETH(BASE) address: $ethbaseWalletAddress');
      notifyListeners();
      if (_context != null) {
        Navigator.pop(modalContext);
        modalSetup(
          _context,
          modalPercentageHeight: 0.55,
          createPage: const SaveMnemonics(),
          showBarrierColor: true,
        );
      }
    } catch (e) {
      //show toast
      log(e.toString());
    }
  }

  importWallet(BuildContext modalContext) async {
    try {
      HDWallet newWalletInstance =
          HDWallet.createWithMnemonic(enteredMnemonics);
      String solWalletAddress =
          newWalletInstance.getAddressForCoin(TWCoinType.TWCoinTypeSolana);
      String usdtWalletAddress =
          newWalletInstance.getAddressForCoin(TWCoinType.TWCoinTypeSmartChain);
      String bnbbscWalletAddress =
          newWalletInstance.getAddressForCoin(TWCoinType.TWCoinTypeSmartChain);

      String ethbaseWalletAddress =
          newWalletInstance.getAddressForCoin(TWCoinType.TWCoinTypeEthereum);
      log('----- solana address: $solWalletAddress');
      log('----- usdt(BSC) address: $usdtWalletAddress');
      log('----- BNB(BSC) address: $bnbbscWalletAddress');
      log('----- ETH(BASE) address: $ethbaseWalletAddress');
      final ETHPk =
          newWalletInstance.getKeyForCoin(TWCoinType.TWCoinTypeEthereum);
      log("ETHPk.data:${ETHPk.data()}");
      log('-1：${PrivateKey.isValid(ETHPk.data(), -1)}、none：${PrivateKey.isValid(ETHPk.data(), TWCurve.TWCurveNone)}、ed25519：${PrivateKey.isValid(ETHPk.data(), TWCurve.TWCurveED25519)}、secp256k1：${PrivateKey.isValid(ETHPk.data(), TWCurve.TWCurveSECP256k1)}、ed25519Blake2bNano：${PrivateKey.isValid(ETHPk.data(), TWCurve.TWCurveED25519Blake2bNano)}、curve25519：${PrivateKey.isValid(ETHPk.data(), TWCurve.TWCurveCurve25519)}、nist256p1:${PrivateKey.isValid(ETHPk.data(), TWCurve.TWCurveNIST256p1)}、ed25519Extended:${PrivateKey.isValid(ETHPk.data(), TWCurve.TWCurveED25519Extended)}');
      final BITPk =
          newWalletInstance.getKeyForCoin(TWCoinType.TWCoinTypeBitcoin);
      log("BITPk.data:${BITPk.data()}");
      log('10000000000000000：${PrivateKey.isValid(ETHPk.data(), 10000000000000000)}、none：${PrivateKey.isValid(BITPk.data(), TWCurve.TWCurveNone)}、ed25519：${PrivateKey.isValid(BITPk.data(), TWCurve.TWCurveED25519)}、secp256k1：${PrivateKey.isValid(BITPk.data(), TWCurve.TWCurveSECP256k1)}、ed25519Blake2bNano：${PrivateKey.isValid(BITPk.data(), TWCurve.TWCurveED25519Blake2bNano)}、curve25519：${PrivateKey.isValid(BITPk.data(), TWCurve.TWCurveCurve25519)}、nist256p1:${PrivateKey.isValid(BITPk.data(), TWCurve.TWCurveNIST256p1)}、ed25519Extended:${PrivateKey.isValid(BITPk.data(), TWCurve.TWCurveED25519Extended)}');

      await Storage.saveData(WALLET_MNEMONICS, enteredMnemonics);
      notifyListeners();

      if (_context != null) {
        Navigator.pop(modalContext);
        modalSetup(mainContext,
            modalPercentageHeight: 0.6,
            createPage: const UserWallet(),
            showBarrierColor: true);
      }
    } catch (e) {
      //show toast
      log(e.toString());
      String error = e.toString().split(":").last;
      log(error);
    }
  }

  Future<Map<String, dynamic>> loadWallet() async {
    try {
      String mnemonics = await Storage.readData(WALLET_MNEMONICS);
      HDWallet newWalletInstance = HDWallet.createWithMnemonic(mnemonics);
      String solWalletAddress =
          newWalletInstance.getAddressForCoin(TWCoinType.TWCoinTypeSolana);
      String usdtWalletAddress =
          newWalletInstance.getAddressForCoin(TWCoinType.TWCoinTypeSmartChain);
      String bnbbscWalletAddress =
          newWalletInstance.getAddressForCoin(TWCoinType.TWCoinTypeSmartChain);

      String ethbaseWalletAddress =
          newWalletInstance.getAddressForCoin(TWCoinType.TWCoinTypeEthereum);
      log('----- solana address: $solWalletAddress');
      log('----- usdt(BSC) address: $usdtWalletAddress');
      log('----- BNB(BSC) address: $bnbbscWalletAddress');
      log('----- ETH(BASE) address: $ethbaseWalletAddress');
      Map<String, dynamic> addresses = {
        "eth": ethbaseWalletAddress,
        "bnb": bnbbscWalletAddress,
        "usdt": usdtWalletAddress,
        "sol": solWalletAddress
      };
      notifyListeners();
      getBalances(addresses);
      return addresses;
    } catch (e) {
      //show toast
      log(e.toString());
      rethrow;
    }
  }

  getBalances(Map<String, dynamic> addresses) {
    getUSDTBSCBalance(addresses["usdt"]);
    getBNBNativeBSCBalance(addresses["bnb"]);
    getETHBaseBalance(addresses["eth"]);
    getSolanaBalance(addresses["sol"]);
  }

  getBNBNativeBSCBalance(address) async {
    try {
      Web3Client? client;
      client =
          await tokenFactory.initWebClient('https://bsc-dataseed.binance.org/');
      // String address = "oXhdhd";
      final EtherAmount balanceAmount =
          await client.getBalance(EthereumAddress.fromHex(address));
      double balance = balanceAmount.getValueInUnit(EtherUnit.ether);
      log('BNB Balance: $balance');
      _bnbBalance = balance.toString();
      notifyListeners();
    } catch (e) {
      log(e.toString());
    }
  }

  getUSDTBSCBalance(walletAddress) async {
    try {
      String contractAddress = "0x55d398326f99059fF775485246999027B3197955";
      int decimal = 18;
      log("Getting USDT balance for $walletAddress");
      Web3Client? webClient =
          await tokenFactory.initWebClient('https://bsc-dataseed.binance.org/');
      final String abi = await rootBundle.loadString(bscTokenAbi);
      final contract = await tokenFactory.intContract(abi, contractAddress, '');
      final balanceFunction = contract.function("balanceOf");
      final balance = await webClient
          .call(contract: contract, function: balanceFunction, params: [
        EthereumAddress.fromHex("0x644AFdB7f5663E63a26d164503fbDA61ed7E29B4")
      ]);
      BigInt amount = balance.first;
      log('You have $amount USDT from $balance');
      double totalBalance =
          double.parse(amount.toString()) / math.pow(10, decimal);
      log('Total balance: $totalBalance');
      _usdtBalance = totalBalance.toStringAsFixed(8);
      notifyListeners();
    } catch (e) {
      log(e.toString());
    }
  }

  getETHBaseBalance(walletAddress) async {
    try {
      String contractAddress = "0x07150e919B4De5fD6a63DE1F9384828396f25fDC";
      int decimal = 18;
      log("Getting ETH balance for $walletAddress");
      Web3Client? webClient =
          await tokenFactory.initWebClient('https://mainnet.base.org/');
      final String abi = await rootBundle.loadString(baseTokenAbi);
      final contract =
          await tokenFactory.intContract(abi, contractAddress, "ETH");
      final balanceFunction = contract.function("balanceOf");
      final balance = await webClient.call(
          contract: contract,
          function: balanceFunction,
          params: [EthereumAddress.fromHex(walletAddress)]);
      BigInt amount = balance.first;
      log('You have $amount USDT');
      double totalBalance =
          double.parse(amount.toString()) / math.pow(10, decimal);
      log('Total balance: $totalBalance');
      _ethBalance = totalBalance.toString();
      notifyListeners();
    } catch (e) {
      log(e.toString());
    }
  }

  getSolanaBalance(walletAddress) async {
    try {
      log("Getting SOL balance for $walletAddress");
      final cluster = web3.Cluster.mainnet;
      final connection = web3.Connection(cluster);
      final mnemonic = await Storage.readData(WALLET_MNEMONICS);
      HDWallet newWalletInstance = HDWallet.createWithMnemonic(mnemonic);
      String solWalletAddress =
          newWalletInstance.getAddressForCoin(TWCoinType.TWCoinTypeSolana);
      log("Getting SOL wallet addr: $solWalletAddress");
      final SOLPkBuffer =
          newWalletInstance.getKeyForCoin(TWCoinType.TWCoinTypeSolana);
      log("SOLPkBuffer.data:${SOLPkBuffer.data()}");
      final web3.Keypair wallet = web3.Keypair.fromSeedSync(SOLPkBuffer.data());
      // connection.w

      final balance = await connection.getBalance(wallet.pubkey);

      log('You have $balance SOL');
      _ethBalance = balance.toString();
      retrieveSolanaWallet();
      notifyListeners();
    } catch (e) {
      log("-----------------222-----------------");
      log(e.toString());
      log("-----------------2-----------------");
    }
  }

  retrieveSolanaWallet() async {
    try {
      final mnemonic = await Storage.readData(WALLET_MNEMONICS);
      HDWallet newWalletInstance = HDWallet.createWithMnemonic(mnemonic);
      String solWalletAddress =
          newWalletInstance.getAddressForCoin(TWCoinType.TWCoinTypeSolana);
      log("Getting SOL wallet addr: $solWalletAddress");

      final SOLPkBuffer =
          newWalletInstance.getKeyForCoin(TWCoinType.TWCoinTypeSolana);
      log("SOLPkBuffer.data:${SOLPkBuffer.data()}");
      final web3.Keypair wallet = web3.Keypair.fromSeedSync(SOLPkBuffer.data());
      log('Account is ${wallet.pubkey}');

      // final wallet = web3.
    } catch (e) {
      log("-----------------11111-----------------");
      log(e.toString());
      log("-----------------11111-----------------");
    }
  }

  sendCrypto({
    required String to,
    required String symbol,
    required String amount,
  }) {
    if (symbol == "USDT") {
      sendUsdt(amount: double.parse(amount), to: to);
    } else if (symbol.contains('BNB')) {
      // sendBnb(amount: double.parse(amount), to: to);
    } else if (symbol == "ETH") {
      sendEthBase(amount: double.parse(amount), to: to);
    } else if (symbol == "SOL") {
      sendSol(amount: double.parse(amount), to: to);
    }
  }

  sendUsdt({required double amount, required String to}) async {
    String contractAddress = "0x55d398326f99059fF775485246999027B3197955";
    int decimal = 18;
    log("Sending USDT");
    Web3Client? webClient =
        await tokenFactory.initWebClient('https://bsc-dataseed.binance.org/');
    final String abi = await rootBundle.loadString(bscTokenAbi);
    final contract = await tokenFactory.intContract(abi, contractAddress, '');

    final mnemonic = await Storage.readData(WALLET_MNEMONICS);
    HDWallet newWalletInstance = HDWallet.createWithMnemonic(mnemonic);

    final key =
        newWalletInstance.getKeyForCoin(TWCoinType.TWCoinTypeSmartChain);
    log("key${key.data()}");
    var privateKey = bytesToHex(key.data(), include0x: true);
    log("private key: $privateKey");
    final credentials = await tokenFactory.getCredentials(privateKey);
    final sendFunction = contract.function('transfer');
    EtherAmount gasPrice = await webClient.getGasPrice();
    // BigInt gas = await webClient.estimateGas(
    //   sender: EthereumAddress.fromHex(from),
    //   to: EthereumAddress.fromHex(to),
    //   //data: data,
    // );
    int totalAmount = ((amount) * math.pow(10, decimal)).toInt();

    Transaction transaction = Transaction.callContract(
      contract: contract,
      function: sendFunction,
      from: credentials.address,
      gasPrice: gasPrice,
      //maxGas: fee.maxGas,
      parameters: [EthereumAddress.fromHex(to), BigInt.from(totalAmount)],
    );
    String txid = await sendTransaction(
      transaction: transaction,
      credentials: credentials,
      webClient: webClient,
      chainId: 56,
    );
    print("transacation id $txid");
  }

  sendEthBase({required double amount, required String to}) async {
    String contractAddress = "0x07150e919B4De5fD6a63DE1F9384828396f25fDC";
    int decimal = 18;
    log("Sending USDT");
    Web3Client? webClient =
        await tokenFactory.initWebClient('https://mainnet.base.org/');
    final String abi = await rootBundle.loadString(baseTokenAbi);
    final contract = await tokenFactory.intContract(abi, contractAddress, '');

    final mnemonic = await Storage.readData(WALLET_MNEMONICS);
    HDWallet newWalletInstance = HDWallet.createWithMnemonic(mnemonic);

    final key =
        newWalletInstance.getKeyForCoin(TWCoinType.TWCoinTypeSmartChain);
    log("key${key.data()}");
    var privateKey = bytesToHex(key.data(), include0x: true);
    log("private key: $privateKey");
    final credentials = await tokenFactory.getCredentials(privateKey);
    final sendFunction = contract.function('transfer');
    EtherAmount gasPrice = await webClient.getGasPrice();

    int totalAmount = ((amount) * math.pow(10, decimal)).toInt();

    Transaction transaction = Transaction.callContract(
      contract: contract,
      function: sendFunction,
      from: credentials.address,
      gasPrice: gasPrice,
      //maxGas: fee.maxGas,
      parameters: [EthereumAddress.fromHex(to), BigInt.from(totalAmount)],
    );
    String txid = await sendTransaction(
      transaction: transaction,
      credentials: credentials,
      webClient: webClient,
      chainId: 8453,
    );
    print("transacation id $txid");
  }

  sendSol({required double amount, required String to}) async {
    final cluster = web3.Cluster.mainnet;
    final connection = web3.Connection(cluster);
    final mnemonic = await Storage.readData(WALLET_MNEMONICS);
    HDWallet newWalletInstance = HDWallet.createWithMnemonic(mnemonic);
    String solWalletAddress =
        newWalletInstance.getAddressForCoin(TWCoinType.TWCoinTypeSolana);
    final SOLPkBuffer =
        newWalletInstance.getKeyForCoin(TWCoinType.TWCoinTypeSolana);
    final web3.Keypair wallet = web3.Keypair.fromSeedSync(SOLPkBuffer.data());

    final web3.BlockhashWithExpiryBlockHeight blockhash =
        await connection.getLatestBlockhash();

    final transaction = web3.Transaction.v0(
        payer: wallet.pubkey,
        recentBlockhash: blockhash.blockhash,
        instructions: [
          SystemProgram.transfer(
            fromPubkey: wallet.pubkey,
            toPubkey: web3.Pubkey.fromBase58(to),
            lamports: web3.solToLamports(amount),
          ),
        ]);
    transaction.sign([wallet]);
    String txid = await connection.sendAndConfirmTransaction(
      transaction,
    );

    print("transacation id $txid");
  }

  Future<String> sendTransaction(
      {required Transaction transaction,
      required Credentials credentials,
      required Web3Client webClient,
      required int chainId}) async {
    try {
      log("Sending transaction");

      Uint8List signedTransaction = await webClient.signTransaction(
        credentials,
        transaction,
        chainId: chainId,
        fetchChainIdFromNetworkId: false,
      );
      String txId = await webClient.sendRawTransaction(signedTransaction);
      log("TxId: $txId");
      return txId;
    } catch (e) {
      log(e.toString());
      throw Exception("An error occurred while sending transaction");
    }
  }

// final sendFunction = contract.function('transfer');
// int amount * 10^(decimals)
// Transaction transaction = Transaction.callContract(
//     contract: contract,
//     function: sendFunction,
//     from: credentials.address,
//     gasPrice: EtherAmount.inWei(fee.gasPrice),
//     maxGas: fee.maxGas,
//     parameters: [
//       EthereumAddress.fromHex(widget.sendPayload.recipient_address!),
//       BigInt.from(totalAmount)
//     ]
// );
}
