// ignore_for_file: use_build_context_synchronously, non_constant_identifier_names

import 'dart:async';
import 'dart:developer';
import 'dart:convert';
import 'dart:math' as math;

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:smartbet/constants/assets_path.dart';
import 'package:smartbet/constants/strings.dart';
import 'package:smartbet/model/tx_history.dart';
import 'package:smartbet/screens/wallet_modals/save_mnemonics.dart';
import 'package:smartbet/screens/wallet_modals/wallet.dart';
import 'package:smartbet/services/storage.dart';
import 'package:smartbet/services/token_factory.dart';
import 'package:smartbet/shared/modal_sheet.dart';
import 'package:tonutils/tonutils.dart' as ton;
import 'package:trust_wallet_core_lib/trust_wallet_core_ffi.dart';
import 'package:trust_wallet_core_lib/trust_wallet_core_lib.dart';
import 'package:web3dart/crypto.dart';
import 'package:web3dart/web3dart.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:solana_web3/solana_web3.dart' as web3;
import 'package:solana_web3/programs.dart' show SystemProgram;
import 'package:bip39/bip39.dart' as bip39;
import 'package:bip32/bip32.dart' as bip32;
import 'package:crypto/crypto.dart';
import 'package:http/http.dart' as http;

class Web3Provider with ChangeNotifier {
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

  bool _keyBoardActive = false;
  late StreamSubscription<bool> keyboardSubscription;

  List<String> _generatedMnemonics = [];
  String enteredMnemonics = "";
  String _ethBalance = "0.0000";
  String _bnbBalance = "0.0000";
  String _usdtBalance = "0.0000";
  String _solBalance = "0.0000";
  String _tonBalance = "0.0000";

  List<TxResult> txResult = <TxResult>[];

  BuildContext? _context;

  TokenFactory tokenFactory = TokenFactory();
  final tonClient = ton.TonJsonRpc('https://toncenter.com/api/v2/jsonRPC');
  late ton.KeyPair keyPair;

  static const String baseUrl = 'https://deep-index.moralis.io/api/v2.2/';

  Web3Provider() {
    log("Web3Provider initialized");
    var keyboardVisibilityController = KeyboardVisibilityController();

    keyboardSubscription =
        keyboardVisibilityController.onChange.listen((bool visible) {
      _keyBoardActive = visible;
      log('Keyboard visibility update. Is visible: $visible');
    });

    _initializeKeyboardVisibility();
    setupTonKeypair();
  }

  BuildContext get mainContext => _context!;

  List<String> get userMnemonics => _generatedMnemonics;
  bool get isKeyBoardActive => _keyBoardActive;

  ///TODO: Make sure this variables are reactive on the UI
  String get userEthBalance => _ethBalance;
  String get userBnbBalance => _bnbBalance;
  String get userUsdtBalance => _usdtBalance;
  String get userSolBalance => _solBalance;
  String get userTonBalance => _tonBalance;

  void setContext(BuildContext context) {
    _context = context;
  }

  void _initializeKeyboardVisibility() {
    var keyboardVisibilityController = KeyboardVisibilityController();

    keyboardSubscription =
        keyboardVisibilityController.onChange.listen((bool visible) {
      _keyBoardActive = visible;
      log('Keyboard visibility update. Is visible: $visible');
    });
  }

  Future<void> createMultiWalletSystem(BuildContext modalContext) async {
    try {
      HDWallet newWalletInstance = HDWallet();
      String mnemonics = newWalletInstance.mnemonic();
      await Storage.saveData(WALLET_MNEMONICS, mnemonics);
      _generatedMnemonics = mnemonics.split(' ').toList();

      logWalletAddresses(newWalletInstance);
      toast(
        "Wallet created successfully. Please wait while we load your wallet",
      );
      await setupTonKeypair();

      notifyListeners();

      _showModalIfNeeded(_context, modalContext, const SaveMnemonics());
    } catch (e) {
      log('Error in creating wallet: $e');
    }
  }

  setupTonKeypair() async {
    final mnemonic = await Storage.readData(WALLET_MNEMONICS) ?? '';
    if (mnemonic.isEmpty) {
      return;
    }
    List<String> mnemonics = mnemonic.split(' ');
    // log("mnemonics is a List<String>: ${mnemonics is List<String>}"); // Should log true
    log("mnemonics: $mnemonics");

    log("-----------------setting up TON keypair-----------------");
    final seed = bip39.mnemonicToSeed(mnemonic);
    final wallet = bip32.BIP32.fromSeed(seed);
    final pathWallet = wallet.derivePath('''m/44'/607'/0'/0/0''');
    //Uint8List privateKey = pathWallet.privateKey!;
    Uint8List privateKey32 = pathWallet.privateKey!;

    // Create a 64-byte private key by hashing the private key and appending
    Uint8List privateKey64 =
        Uint8List.fromList(privateKey32 + sha256.convert(privateKey32).bytes);

    keyPair = ton.KeyPair.fromPrivateKey(privateKey64);
    log("public key: ${keyPair.publicKey}"); //[117, 116, 147, 124, 55, 179, 151, 224, 146, 51, 205, 145, 218, 150, 155, 29, 43, 227, 224, 80, 154, 176, 44, 147, 184, 97, 111, 91, 231, 254, 243, 133]
    log("private key: ${keyPair.privateKey}");

    // keyPair = ton.Mnemonic.toKeyPair(mnemonics);
    // final keyPairData = await _generateKeyPairInIsolate(mnemonics);

    // keyPair =
    //     await compute<List<String>, ton.KeyPair>(generateKeyPair, mnemonics);

    log("-----------------------setting up TON keypair: completed--------------------------");
    // keyPair = ton.KeyPair.fromPrivateKey(keyPairData['privateKey']);
    log("public key: ${keyPair.publicKey}");
  }

  // _initialize() async {
  //   var mnemonic = await st.Storage.readData(WALLET_MNEMONICS);
  //   final seed = bip39.mnemonicToSeed(mnemonic);
  //   final wallet = bip32.BIP32.fromSeed(seed);
  //   final pathWallet = wallet.derivePath('''m/44'/60'/0'/0/0''');
  //   privateKey = HEX.encode(pathWallet.privateKey!);
  //   final private = EthPrivateKey.fromHex(privateKey);
  //   var address = (private.address).hexEip55;
  //   log(address);
  //   log(privateKey);
  // }

  setupTONWallet(Map<String, dynamic> addresses) async {
    try {
      var wallet = ton.WalletContractV4R2.create(publicKey: keyPair.publicKey);
      log("public key: ${keyPair.publicKey}");
      var openedContract = tonClient.open(wallet);
      ton.InternalAddress walletAddress = wallet.address;

      log("Wallet Address: ${walletAddress.toString()}");
      addresses['ton'] = walletAddress.toString();

      BigInt balance = await openedContract.getBalance();
      double totalBalance = balance.toDouble() / math.pow(10, 9);
      log("TON Balance: $totalBalance");

      _tonBalance = totalBalance.toString();
      notifyListeners();

      //return walletAddress.toString();
    } catch (e) {
      log('Error in setting up TON wallet: $e');
    }
  }

  Future<void> sendTon({required double amount, required String to}) async {
    try {
      var wallet = ton.WalletContractV4R2.create(publicKey: keyPair.publicKey);
      var openedContract = tonClient.open(wallet);

      var seqno = await openedContract.getSeqno();
      var transfer = openedContract.createTransfer(
        seqno: seqno,
        privateKey: keyPair.privateKey,
        messages: [
          ton.internal(
            to: ton.SiaString(to),
            value: ton.SbiString(amount.toString()),
          )
        ],
      );
      final tx = ton.loadTransaction(transfer.beginParse());
      // log('tx: ${tx.}');
      ton.storeTransaction(tx);
      log('TON transfer: ${transfer.toString()}');
      ///TODO: Notify the user of the completed transaction

      notifyListeners();
    } catch (e) {
      log('Error in sending TON: $e');
    }
  }

  Future<void> importWallet(BuildContext modalContext) async {
    try {
      HDWallet newWalletInstance =
          HDWallet.createWithMnemonic(enteredMnemonics);
      logWalletAddresses(newWalletInstance);

      await Storage.saveData(WALLET_MNEMONICS, enteredMnemonics);
      toast(
          "Wallet imported successfully. Please wait while we load your wallet");
      one.clear();
      two.clear();
      three.clear();
      four.clear();
      five.clear();
      six.clear();
      seven.clear();
      eight.clear();
      nine.clear();
      ten.clear();
      eleven.clear();
      twelve.clear();
      setupTonKeypair();
      notifyListeners();

      _showModalIfNeeded(_context, modalContext, const UserWallet());
    } catch (e) {
      log('Error in importing wallet: $e');
    }
  }

  Future<Map<String, dynamic>> loadWallet() async {
    try {
      String mnemonics = await Storage.readData(WALLET_MNEMONICS);
      log('memnonics: $mnemonics');
      HDWallet newWalletInstance = HDWallet.createWithMnemonic(mnemonics);

      logWalletAddresses(newWalletInstance);

      Map<String, dynamic> addresses =
          _extractWalletAddresses(newWalletInstance);
      notifyListeners();
      getBalances(addresses);
      return addresses;
    } catch (e) {
      log('Error in loading wallet: $e');
      rethrow;
    }
  }

  void getBalances(Map<String, dynamic> addresses) async {
    getUSDTBSCBalance(addresses["usdt"]);
    getBNBNativeBSCBalance(addresses["bnb"]);
    getETHBaseBalance(addresses["eth"]);
    getSolanaBalance(addresses["sol"]);
    // Setup TON wallet and get the address
    //Setup TON wallet and get the address and get balance
    setupTONWallet(addresses);
  }

  Future<void> getBNBNativeBSCBalance(String address) async {
    await _getBalance(
      address: address,
      networkUrl: 'https://bsc-dataseed.binance.org/',
      onBalanceRetrieved: (balance) {
        _bnbBalance = balance;
        notifyListeners();
      },
    );
  }

  Future<void> getUSDTBSCBalance(String walletAddress) async {
    await _getTokenBalance(
      walletAddress: walletAddress,
      contractAddress: "0x55d398326f99059fF775485246999027B3197955",
      networkUrl: 'https://bsc-dataseed.binance.org/',
      decimal: 18,
      onBalanceRetrieved: (balance) {
        _usdtBalance = balance;
        notifyListeners();
      },
    );
  }

  Future<void> getETHBaseBalance(String address) async {
    await _getBalance(
      address: address,
      networkUrl: 'https://base.llamarpc.com',
      onBalanceRetrieved: (balance) {
        _ethBalance = balance;
        notifyListeners();
      },
    );
  }

  Future<void> getSolanaBalance(String walletAddress) async {
    try {
      log("Getting SOL balance for $walletAddress");
      final cluster = web3.Cluster.mainnet;
      final connection = web3.Connection(cluster);

      final mnemonic = await Storage.readData(WALLET_MNEMONICS);
      HDWallet newWalletInstance = HDWallet.createWithMnemonic(mnemonic);

      final SOLPkBuffer =
          newWalletInstance.getKeyForCoin(TWCoinType.TWCoinTypeSolana);
      final web3.Keypair wallet = web3.Keypair.fromSeedSync(SOLPkBuffer.data());

      final balance = await connection.getBalance(wallet.pubkey);

      log('SOL Balance: $balance');
      _solBalance = balance.toString();
      notifyListeners();
    } catch (e) {
      log('Error in getting SOL balance: $e');
    }
  }

  Future<void> sendCrypto({
    required String to,
    required String symbol,
    required String amount,
  }) async {
    final parsedAmount = double.parse(amount);
    if (symbol == "USDT") {
      await sendUsdt(amount: parsedAmount, to: to);
    } else if (symbol.contains('BNB')) {
      await sendBnb(amount: parsedAmount, to: to);
    } else if (symbol == "ETH") {
      await sendEthBase(amount: parsedAmount, to: to);
    } else if (symbol == "SOL") {
      await sendSol(amount: parsedAmount, to: to);
    } else if (symbol == "TON") {
      await sendTon(amount: parsedAmount, to: to);
    }
  }

  Future<void> sendBnb({required double amount, required String to}) async {
    await _sendTransaction(
      amount: amount,
      to: to,
      networkUrl: 'https://bsc-dataseed.binance.org/',
      chainId: 56,
    );
  }

  Future<void> sendUsdt({required double amount, required String to}) async {
    await _sendTokenTransaction(
      amount: amount,
      to: to,
      contractAddress: "0x55d398326f99059fF775485246999027B3197955",
      networkUrl: 'https://bsc-dataseed.binance.org/',
      chainId: 56,
      decimal: 18,
    );
  }

  Future<void> sendEthBase({required double amount, required String to}) async {
    await _sendTransaction(
      amount: amount,
      to: to,
      networkUrl: 'https://mainnet.base.org/',
      chainId: 8453,
    );
  }

  Future<void> sendSol({required double amount, required String to}) async {
    try {
      final cluster = web3.Cluster.mainnet;
      final connection = web3.Connection(cluster);

      final mnemonic = await Storage.readData(WALLET_MNEMONICS);
      HDWallet newWalletInstance = HDWallet.createWithMnemonic(mnemonic);
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
        ],
      );
      transaction.sign([wallet]);
      String txid = await connection.sendAndConfirmTransaction(transaction);
      log("Transaction ID: $txid");
    } catch (e) {
      log('Error in sending SOL: $e');
    }
  }

  Future<String> sendTransaction({
    required Transaction transaction,
    required Credentials credentials,
    required Web3Client webClient,
    required int chainId,
  }) async {
    try {
      log("Sending transaction");
      Uint8List signedTransaction = await webClient.signTransaction(
        credentials,
        transaction,
        chainId: chainId,
        fetchChainIdFromNetworkId: false,
      );
      String txId = await webClient.sendRawTransaction(signedTransaction);
      log("Transaction ID: $txId");
      return txId;
    } catch (e) {
      log('Error in sending transaction: $e');
      throw Exception("An error occurred while sending transaction");
    }
  }

  Future<void> _getBalance({
    required String address,
    required String networkUrl,
    required Function(String) onBalanceRetrieved,
  }) async {
    try {
      final client = await tokenFactory.initWebClient(networkUrl);
      final EtherAmount balanceAmount =
          await client.getBalance(EthereumAddress.fromHex(address));
      log('Native Balance with network url $networkUrl is: $balanceAmount');
      onBalanceRetrieved(
          balanceAmount.getValueInUnit(EtherUnit.ether).toString());
    } catch (e) {
      log('Error in getting balance: $e');
    }
  }

  Future<void> _getTokenBalance({
    required String walletAddress,
    required String contractAddress,
    required String networkUrl,
    required int decimal,
    required Function(String) onBalanceRetrieved,
  }) async {
    try {
      final client = await tokenFactory.initWebClient(networkUrl);
      final String abi = await rootBundle.loadString(bscTokenAbi);
      final contract = await tokenFactory.intContract(abi, contractAddress, '');
      final balanceFunction = contract.function("balanceOf");
      final balance = await client.call(
        contract: contract,
        function: balanceFunction,
        params: [EthereumAddress.fromHex(walletAddress)],
      );
      BigInt amount = balance.first;
      double totalBalance =
          double.parse(amount.toString()) / math.pow(10, decimal);
      log('Token Balance with network url $networkUrl is: $totalBalance');
      onBalanceRetrieved(totalBalance.toStringAsFixed(8));
    } catch (e) {
      log('Error in getting token balance with network url $networkUrl: $e');
    }
  }

  Future<void> _sendTransaction({
    required double amount,
    required String to,
    required String networkUrl,
    required int chainId,
  }) async {
    try {
      final client = await tokenFactory.initWebClient(networkUrl);
      final mnemonic = await Storage.readData(WALLET_MNEMONICS);
      HDWallet newWalletInstance = HDWallet.createWithMnemonic(mnemonic);

      final key =
          newWalletInstance.getKeyForCoin(TWCoinType.TWCoinTypeSmartChain);
      var privateKey = bytesToHex(key.data(), include0x: true);
      final credentials = await tokenFactory.getCredentials(privateKey);

      final amountInWei = BigInt.from(amount * 1e18);
      final senderAddress = credentials.address;

      // Create the transaction for sending native BNB
      final transaction = Transaction(
        from: senderAddress,
        to: EthereumAddress.fromHex(to),
        value: EtherAmount.inWei(amountInWei),
        gasPrice: await client.getGasPrice(),
        maxGas: 21000, // Standard gas limit for a simple transfer
      );

      String txid = await sendTransaction(
        transaction: transaction,
        credentials: credentials,
        webClient: client,
        chainId: chainId,
      );

      log("Transaction ID: $txid");
      ///TODO: Notify the user of the completed transaction
    } catch (e) {
      log('Error in sending token transaction: $e');
    }
  }

  Future<void> _sendTokenTransaction({
    required double amount,
    required String to,
    required String contractAddress,
    required String networkUrl,
    required int chainId,
    required int decimal,
  }) async {
    try {
      final client = await tokenFactory.initWebClient(networkUrl);
      final String abi = await rootBundle.loadString(bscTokenAbi);
      final contract = await tokenFactory.intContract(abi, contractAddress, '');

      final mnemonic = await Storage.readData(WALLET_MNEMONICS);
      HDWallet newWalletInstance = HDWallet.createWithMnemonic(mnemonic);
      final key =
          newWalletInstance.getKeyForCoin(TWCoinType.TWCoinTypeSmartChain);
      var privateKey = bytesToHex(key.data(), include0x: true);
      final credentials = await tokenFactory.getCredentials(privateKey);

      final sendFunction = contract.function('transfer');
      EtherAmount gasPrice = await client.getGasPrice();
      int totalAmount = ((amount) * math.pow(10, decimal)).toInt();

      Transaction transaction = Transaction.callContract(
        contract: contract,
        function: sendFunction,
        from: credentials.address,
        gasPrice: gasPrice,
        parameters: [EthereumAddress.fromHex(to), BigInt.from(totalAmount)],
      );
      String txid = await sendTransaction(
        transaction: transaction,
        credentials: credentials,
        webClient: client,
        chainId: chainId,
      );
      log("Transaction ID: $txid");
      ///TODO: Notify the user of the completed transaction
    } catch (e) {
      log('Error in sending token transaction: $e');
    }
  }

  Map<String, dynamic> _extractWalletAddresses(HDWallet wallet) {
    return {
      "eth": wallet.getAddressForCoin(TWCoinType.TWCoinTypeEthereum),
      "bnb": wallet.getAddressForCoin(TWCoinType.TWCoinTypeSmartChain),
      "usdt": wallet.getAddressForCoin(TWCoinType.TWCoinTypeSmartChain),
      "sol": wallet.getAddressForCoin(TWCoinType.TWCoinTypeSolana)
    };
  }

  // Fetch and merge all transfers
  Future<List<TxResult>> fetchAllTransfers(Map ethAddress) async {
    final bnbTransfers = await fetchBnbTransfers(ethAddress['eth']);
    final usdtTransfers = await fetchUsdtTransfers(ethAddress['eth']);
    final ethTransfers = await fetchEthTransfers(ethAddress['eth']);

    // Merge all transfers into one list
    final allTransfers = [...bnbTransfers, ...usdtTransfers, ...ethTransfers];

    // Sort the list by timestamp (or block_number)
    allTransfers.sort((a, b) => b.blockTimestamp!.compareTo(a.blockTimestamp!));
    // txResult = allTransfers.map((e) => TxResult.fromJson(e)).toList();

    return allTransfers;
  }

  // Fetch BNB (BSC) Transfers
  Future<List<TxResult>> fetchBnbTransfers(address) async {
    final url = Uri.parse('$baseUrl$address?chain=bsc&order=DESC');
    return await _fetchTransfers(url, true);
  }

  // Fetch USDT (BSC) Transfers
  Future<List<TxResult>> fetchUsdtTransfers(address) async {
    final url = Uri.parse(
        '$baseUrl$address/erc20/transfers?chain=bsc&contract_addresses%5B0%5D=0x55d398326f99059fF775485246999027B3197955&order=DESC');
    return await _fetchTransfers(url, false);
  }

  // Fetch ETH (Base) Transfers
  Future<List<TxResult>> fetchEthTransfers(address) async {
    final url =
        Uri.parse('$baseUrl$address/erc20/transfers?chain=base&order=DESC');
    return await _fetchTransfers(url, false);
  }

  Future<List<TxResult>> _fetchTransfers(Uri url, bool isNativeAsset) async {
    final response = await http.get(
      url,
      headers: {
        'accept': 'application/json',
        'X-API-Key':
            "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJub25jZSI6ImM1ZGM1MjJlLTFhOTUtNGZkZS04ZTBlLTUyMzFjZTkwMzI2ZSIsIm9yZ0lkIjoiNDA2MTU4IiwidXNlcklkIjoiNDE3MzU0IiwidHlwZUlkIjoiZTFiOWU3ZTAtMGM3Ny00ZDhhLTg4YjEtODc5MDVmYTc2MzIxIiwidHlwZSI6IlBST0pFQ1QiLCJpYXQiOjE3MjQ4MDE2OTcsImV4cCI6NDg4MDU2MTY5N30.smuUuJZT3kplNipuQXZCpN9RdsrCiGFAva6jaoGMt3s",
      },
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      log(data['result']);
      if (isNativeAsset) {
        List<TxResult> transfers = List.from(data['result'])
            .map((e) => TxResult.fromJson({
                  "token_name": "BNB",
                  "token_symbol": "BNB",
                  "value": e['value'],
                  "transaction_hash": e['hash'],
                  "block_timestamp": e['block_timestamp'],
                  "from_address": e['from_address'],
                  "to_address": e['to_address'],
                }))
            .toList();

        return transfers;
      } else {
        List<TxResult> transfers =
            List.from(data['result']).map((e) => TxResult.fromJson(e)).toList();
        return transfers;
      }
    } else {
      log('Failed to fetch transfers from $url: ${response.statusCode}');
      return [];
    }
  }

  void logWalletAddresses(HDWallet wallet) {
    log('----- Solana address: ${wallet.getAddressForCoin(TWCoinType.TWCoinTypeSolana)}');
    log('----- USDT(BSC) address: ${wallet.getAddressForCoin(TWCoinType.TWCoinTypeSmartChain)}');
    log('----- BNB(BSC) address: ${wallet.getAddressForCoin(TWCoinType.TWCoinTypeSmartChain)}');
    log('----- ETH(BASE) address: ${wallet.getAddressForCoin(TWCoinType.TWCoinTypeEthereum)}');
  }

  void _showModalIfNeeded(
      BuildContext? context, BuildContext modalContext, Widget page) {
    if (context != null) {
      Navigator.pop(modalContext);
      modalSetup(context,
          modalPercentageHeight: 0.9, createPage: page, showBarrierColor: true);
    }
  }

  void removeWallet() {
    Storage.removeData(WALLET_MNEMONICS);
    _generatedMnemonics = [];
    notifyListeners();
  }
}
