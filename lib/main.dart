import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:provider/provider.dart';
import 'package:smartbet/layout/responsive.dart';
import 'package:smartbet/materialApp/desktop.dart';
import 'package:smartbet/materialApp/mobile.dart';
import 'package:smartbet/screens/car/provider.dart';
import 'package:smartbet/screens/coin/provider.dart';
import 'package:smartbet/screens/dice/provider.dart';
import 'package:smartbet/screens/fruit/provider.dart';
import 'package:smartbet/screens/home/provider.dart';
import 'package:smartbet/screens/liveEvent/liveEvent_view_model.dart';
import 'package:smartbet/screens/livegame/provider.dart';
import 'package:smartbet/screens/passcode/pass_code_view_model.dart';
import 'package:smartbet/screens/smartTrade/smartTrade_viewmodel.dart';
import 'package:smartbet/socket/provider.dart';
import 'package:smartbet/socket/socket_method.dart';
import 'package:smartbet/walletConnect/provider.dart';
import 'package:trust_wallet_core_lib/trust_wallet_core_lib.dart';
import 'package:url_strategy/url_strategy.dart';

import 'walletConnect/wallet_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  setPathUrlStrategy();
  TrustWalletCoreLib.init();
  await GetStorage.init();
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(create: (_) => CarStateProvider()),
    ChangeNotifierProvider(create: (_) => FruitStateProvider()),
    ChangeNotifierProvider(create: (_) => DiceStateProvider()),
    ChangeNotifierProvider(create: (_) => CoinStateProvider()),
    ChangeNotifierProvider(create: (_) => CoinCapProvider()),
    ChangeNotifierProvider(create: (_) => UserWeb3Provider()),
    ChangeNotifierProvider(create: (_) => Web3Provider()),
    ChangeNotifierProvider(create: (_) => SocketProvider()),
    ChangeNotifierProvider(create: (_) => LiveEventProvider()),
    ChangeNotifierProvider(create: (_) => SmartTradeProvider()),
    ChangeNotifierProvider(create: (_) => LiveEventPredictionProvider()),
    ChangeNotifierProvider(create: (_) => PinEntryProvider()),
    // ChangeNotifierProvider(create: (_) => HistoryDataClass()),
    // ChangeNotifierProvider(create: (_) => OddsProvider())
  ], child: const MyApp()));
}

// @override
// void initState() {
//   //super.initState();
// }
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final SocketMethods _socketMethods = SocketMethods();
    _socketMethods.counterEvent(context);
    _socketMethods.resultEvent(context);
    _socketMethods.resultHistory(context);
    _socketMethods.priceEvent(context);
    _socketMethods.initialVal(context);
    print("initilized desktop and mobile class");
    print("saved  changes  for test");
    return ResponsiveLayout(
        desktopScreen: const ISDesktop(), mobileScreen: const ISMobile());
  }
}
