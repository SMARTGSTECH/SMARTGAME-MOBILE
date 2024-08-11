// ignore_for_file: use_build_context_synchronously

import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:provider/provider.dart';
import 'package:smartbet/constants/strings.dart';
import 'package:smartbet/main_screen/provider.dart';
import 'package:smartbet/screens/car/mobile.dart';
import 'package:smartbet/screens/coin/mobile.dart';
import 'package:smartbet/screens/livegame/mobile.dart';
import 'package:smartbet/screens/home/mobile.dart';
import 'package:smartbet/screens/wallet_modals/create_wallet.dart';
import 'package:smartbet/screens/wallet_modals/wallet.dart';
import 'package:smartbet/services/storage.dart';
import 'package:smartbet/shared/modal_sheet.dart';
import 'package:smartbet/socket/socket_method.dart';
import 'package:smartbet/utils/config/color.dart';
import 'package:smartbet/walletConnect/wallet_provider.dart';
import 'package:smartbet/widget/bottomModal.dart';
import 'package:smartbet/widget/connectWallet.dart';
import 'package:smartbet/widget/quadContainer.dart';

class MainScreenMobile extends StatefulWidget {
  const MainScreenMobile({super.key});

  @override
  State<MainScreenMobile> createState() => _MainScreenMobileState();
}

class _MainScreenMobileState extends State<MainScreenMobile> {
  final SocketMethods _socketMethods = SocketMethods();

  @override
  void initState() {
    // _socketMethods.counterEvent(context);
    // _socketMethods.resultEvent(context);
    // print("initialized mobile");
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Web3Provider web3provider =
        Provider.of<Web3Provider>(context, listen: false);
    return Consumer<MainScreenProvider>(
      builder: (BuildContext context, provider, _) {
        return Scaffold(
          extendBody: true,
          appBar: AppBar(
            leading: Image.asset(
              "assets/images/icon/icon.png",
              width: 15.h,
              height: 15.h,
            ).paddingLeft(23.w),
            actions: [
              Icon(
                Icons.account_balance_wallet_rounded,
                color: ColorConfig.iconColor,
              ).paddingRight(23.w).onTap(() async {
                // showModalBottomSheet(
                //   context: context,
                //   enableDrag: false,
                //   isScrollControlled: true,
                //   builder: (BuildContext context) {
                //     return ReusableBottomModal();
                //   },
                // );
                web3provider.setContext(context);
                String data = await Storage.readData(WALLET_MNEMONICS) ?? "";
                if (data.isNotEmpty) {
                  modalSetup(
                    context,
                    modalPercentageHeight: 0.6,
                    createPage: const UserWallet(),
                    showBarrierColor: true,
                  );
                } else {
                  modalSetup(
                    context,
                    modalPercentageHeight: 0.6,
                    createPage: const CreateWallet(),
                    showBarrierColor: true,
                  );
                }

                // showDialog(
                //   context: context,
                //   barrierDismissible: false,
                //   builder: (BuildContext context) {
                //     return Dialog(
                //       shadowColor: ColorConfig.blue,
                //       // shape: CircleBorder(),
                //       backgroundColor: Colors.transparent,
                //       elevation: 10,
                //       child: walletContainer(),
                //     );
                //   },
                // );
              }),
            ],
            centerTitle: true,
            title: Text(
              "SmartBet",
              style: TextStyle(
                color: ColorConfig.iconColor,
                fontSize: 18.sp,
                fontWeight: FontWeight.w500,
              ),
            ),
            backgroundColor: ColorConfig.appBar,
          ),
          body: !true
              ? const Center(
                  child: Text(
                    "On Maintenance",
                    style: TextStyle(color: Colors.amber),
                  ),
                )
              : IndexedStack(
                  index: provider.currentIndex,
                  children: [
                    const LiveGameMobileScreen().paddingTop(5.h),
                    const HomeMobileScreen(),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [QuadrantBox(), 60.h.toInt().height],
                    ),

                    // Stack(children: [
                    //   // HomeMobileScreen(),
                    //   QuadrantBox(), 50.h.toInt().height
                    //   // Container(
                    //   //   color: Colors.black.withOpacity(0.6),
                    //   //   child: Column(
                    //   //     mainAxisAlignment: MainAxisAlignment.center,
                    //   //     children: [QuadrantBox(), 50.h.toInt().height],
                    //   //   ),
                    //   // )
                    // ]),
                  ],
                ),
          bottomNavigationBar: CurvedNavigationBar(
            height: 75,
            color: ColorConfig.appBar,
            backgroundColor: Colors.transparent,
            buttonBackgroundColor: provider.currentIndex != 1
                ? ColorConfig.yellow
                : ColorConfig.yellow,
            index: provider.currentIndex,
            animationCurve: Curves.easeInOut,
            items: provider.getItems(),
            onTap: (value) {
              provider.setPageIndex(value);
            },
          ),
        );
      },
    );
  }
}
