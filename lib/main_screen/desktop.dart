import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:flutter_web3/flutter_web3.dart';
import 'package:hidden_drawer_menu/hidden_drawer_menu.dart';
import 'package:hidden_drawer_menu/model/item_hidden_menu.dart';
import 'package:hidden_drawer_menu/model/screen_hidden_drawer.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:provider/provider.dart' as provider;
import 'package:smartbet/screens/car/desktop.dart';
import 'package:smartbet/screens/coin/desktop.dart';
import 'package:smartbet/screens/dice/desktop.dart';
import 'package:smartbet/screens/livegame/desktop.dart';
import 'package:smartbet/screens/fruit/desktop.dart';
import 'package:smartbet/screens/history/desktop.dart';
import 'package:smartbet/screens/home/desktop.dart';
import 'package:smartbet/socket/socket_method.dart';
import 'package:smartbet/utils/config/color.dart';
import 'package:smartbet/walletConnect/provider.dart';
import 'package:smartbet/widget/alertSnackBar.dart';
import 'package:smartbet/widget/connectWallet.dart';

class MainScreenDesktop extends StatefulWidget {
  //////////////////////////////
  MainScreenDesktop({Key? key}) : super(key: key);
  List<ScreenHiddenDrawer> _pages = [];
  @override
  State<MainScreenDesktop> createState() => _MainScreenDesktopState();
}

class _MainScreenDesktopState extends State<MainScreenDesktop> {
  List<ScreenHiddenDrawer> _pages = [];

  @override
  void initState() {
    // _socketMetho ds.counterEvent(context);
    // _socketMethods.resultEvent(context);
    // print("initilized desktop");
    // TODO: implement initState
    super.initState();
    _pages = [
      ScreenHiddenDrawer(
          ItemHiddenMenu(
            //\u{2302}
            name: "Home",
            baseStyle: StyleConfig.primaryStyle,
            selectedStyle: StyleConfig.primaryStyle,
          ),
          //CarDesktopScreen()
          //  DiceDesktopScreen()
          // CarDesktopScreen()),
          // CarHistory()
          DesktopHomeScreen()),
      ScreenHiddenDrawer(
          //\u{1F3CE}
          ItemHiddenMenu(
            name: "Car",
            baseStyle: StyleConfig.primaryStyle,
            selectedStyle: StyleConfig.primaryStyle,
          ),
          CarDesktopScreen()),
      ScreenHiddenDrawer(
          //\u{1F3CE}
          ItemHiddenMenu(
            name: "Fruit",
            baseStyle: StyleConfig.primaryStyle,
            selectedStyle: StyleConfig.primaryStyle,
          ),
          FruitDesktopScreen()),
      ScreenHiddenDrawer(
          //\u{1F3B2
          ItemHiddenMenu(
            name: "Dice",
            baseStyle: StyleConfig.primaryStyle,
            selectedStyle: StyleConfig.primaryStyle,
          ),
          DiceDesktopScreen()),
      ScreenHiddenDrawer(
          ItemHiddenMenu(
            //\u{1FA99}
            name: "Coin",
            baseStyle: StyleConfig.primaryStyle,
            selectedStyle: StyleConfig.primaryStyle,
          ),
          CoinDesktopScreen()),
      ScreenHiddenDrawer(
          //\u{26BD}
          ItemHiddenMenu(
            name: "Soccer",
            baseStyle: StyleConfig.primaryStyle,
            selectedStyle: StyleConfig.primaryStyle,
          ),
          FootBallDesktopScreen()),
    ];
  }
// ScreenUtilInit(

  @override
  Widget build(BuildContext context) {
    /// SizeConfigs().init(context);

    return HiddenDrawerMenu(
      leadingAppBar: Icon(
        Icons.menu_sharp,
        color: ColorConfig.iconColor,
      ),
      actionsAppBar: [
        Icon(
          Icons.account_balance_wallet_rounded,
          color: ColorConfig.iconColor,
        ).paddingRight(35.w).onTap(() {
          showDialog(
            context: context,
            barrierDismissible: false,
            builder: (BuildContext context) {
              return Dialog(
                shadowColor: ColorConfig.blue,
                // shape: CircleBorder(),
                backgroundColor: Colors.transparent,
                elevation: 10,
                child: walletContainer(),
              );
            },
          );
        }),
      ],
      backgroundColorAppBar: ColorConfig.appBar,
      screens: _pages,
      disableAppBarDefault: false,
      slidePercent: context.width() < 1200 ? 20 : 10,
      backgroundColorMenu: Color.fromARGB(255, 14, 27, 58),
      initPositionSelected: 0,
      elevationAppBar: 4.0,
      isTitleCentered: true,
      // iconMenuAppBar: Icon(Icons.menu),
      tittleAppBar: Center(
        child: Text(
          "SmartGame",
          style: TextStyle(
            color: ColorConfig.iconColor,
            fontSize: 20.sp,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
      // enableShadowItensMenu: true,
    );
  }
}

// void _showAlertDialog(BuildContext context) {
//   showDialog(
//     context: context,
//     builder: (BuildContext context) {
//       return Dialog(
//         // shape: CircleBorder(),
//         //  backgroundColor: ColorConfig.scaffold,
//         elevation: 10,
//         child: walletContainer(),
//       );
//     },
//   );
// }
