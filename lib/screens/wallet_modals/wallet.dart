import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:provider/provider.dart';
import 'package:smartbet/constants/assets_path.dart';
import 'package:smartbet/screens/wallet_modals/send_crypto.dart';
import 'package:smartbet/shared/modal_sheet.dart';
import 'package:smartbet/utils/config/color.dart';
import 'package:smartbet/utils/helpers.dart';
import 'package:smartbet/walletConnect/wallet_provider.dart';

class UserWallet extends StatefulWidget {
  const UserWallet({super.key});

  @override
  State<UserWallet> createState() => _UserWalletState();
}

class _UserWalletState extends State<UserWallet> {
  late Web3Provider web3provider;
  Map<String, dynamic> addresses = {};
  getUserWallet() async {
    addresses = await web3provider.loadWallet();
    setState(() {});
  }

  @override
  void initState() {
    web3provider = Provider.of<Web3Provider>(context, listen: false);
    getUserWallet();
    super.initState();
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
                      'Wallet',
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
                  'This is your wallet. You can view your balance, receive tokens and perform actions.',
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey,
                  ),
                ),
                20.h.toInt().height,
                item(
                  assetLogo: ethlogo,
                  assetAddress: addresses["eth"] ?? '',
                  assetSymbol: "ETH(Base)",
                  balance: web3provider.userEthBalance,
                ),
                item(
                  assetLogo: bnblogo,
                  assetAddress: addresses["bnb"] ?? '',
                  assetSymbol: "BNB(BSC)",
                  chainLogo: bnblogo,
                  balance: web3provider.userBnbBalance,
                ),
                item(
                  assetLogo: usdtlogo,
                  assetAddress: addresses["usdt"] ?? '',
                  assetSymbol: "USDT",
                  chainLogo: bnblogo,
                  balance: web3provider.userUsdtBalance,
                ),
                item(
                  assetLogo: sollogo,
                  assetAddress: addresses["sol"] ?? '',
                  assetSymbol: "SOL",
                  balance: web3provider.userSolBalance,
                ),
              ],
            );
          }),
        ),
      ),
    );
  }

  Widget item({
    required String assetLogo,
    required String assetAddress,
    required String assetSymbol,
    required String balance,
    String? chainLogo,
  }) {
    return Container(
      height: 60.h,
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 18),
      margin: const EdgeInsets.only(bottom: 15),
      decoration: BoxDecoration(
        border: Border.all(color: ColorConfig.secondary),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Stack(
            clipBehavior: Clip.none,
            children: [
              Container(
                height: 40.h,
                width: 40.h,
                decoration: BoxDecoration(
                  color: Colors.white10,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Center(
                  child: SvgPicture.asset(
                    assetLogo,
                    width: 30.w,
                    height: 30.h,
                  ),
                ),
              ),
              if (chainLogo != null)
                Positioned(
                  bottom: 8,
                  right: 5,
                  child: SvgPicture.asset(
                    chainLogo,
                    width: 12.w,
                    height: 12.h,
                  ),
                ),
            ],
          ),
          SizedBox(width: 10.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                10.h.toInt().height,
                Text(
                  truncate(assetAddress, length: 20),
                  textAlign: TextAlign.left,
                  style: const TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 15,
                  ),
                ),
                5.h.toInt().height,
                Text(
                  "$balance $assetSymbol",
                  style: const TextStyle(
                    fontWeight: FontWeight.w200,
                    fontSize: 13,
                  ),
                ),
              ],
            ),
          ),
          GestureDetector(
            onTap: () async {
              ClipboardData data = ClipboardData(text: assetAddress);
              await Clipboard.setData(data);
            },
            child: const Icon(
              LineIcons.copy,
            ),
          ),
          8.w.toInt().width,
          GestureDetector(
            onTap: () async {
              //go to send wallet
              Navigator.pop(context);
              modalSetup(
                web3provider.mainContext,
                modalPercentageHeight: 0.5,
                createPage: SendCrypto(
                  assetLogo: assetLogo,
                  assetSymbol: assetSymbol,
                  assetAddress: assetAddress,
                  assetBalance: balance,
                ),
                showBarrierColor: true,
              );
            },
            child: const Icon(
              LineIcons.arrow_circle_right,
            ),
          ),
        ],
      ),
    );
  }
}
