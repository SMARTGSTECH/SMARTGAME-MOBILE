import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:provider/provider.dart';
import 'package:smartbet/constants/assets_path.dart';
import 'package:smartbet/screens/wallet_modals/import_walet.dart';
import 'package:smartbet/shared/modal_sheet.dart';
import 'package:smartbet/utils/config/color.dart';
import 'package:smartbet/walletConnect/wallet_provider.dart';

class CreateWallet extends StatefulWidget {
  const CreateWallet({super.key});

  @override
  State<CreateWallet> createState() => _CreateWalletState();
}

class _CreateWalletState extends State<CreateWallet> {
  @override
  Widget build(BuildContext context) {
    Web3Provider web3provider =
        Provider.of<Web3Provider>(context, listen: false);
    return Scaffold(
      //  backgroundColor: kBackgroundColor,
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
                      'Create Wallet',
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
                  'You do not have any wallet yet. Create a new wallet to start trading.',
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey,
                  ),
                ),
                10.h.toInt().height,
                Expanded(
                  child: GridView(
                    shrinkWrap: true,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 30,
                      mainAxisSpacing: 10,
                      childAspectRatio: 1.5,
                    ),
                    children: [
                      item(
                        assetName: 'Solana',
                        asset: sollogo,
                      ),
                      item(
                        assetName: 'Ethereum',
                        asset: ethlogo,
                      ),
                      item(
                        assetName: 'Binance Smart Chain',
                        asset: bnblogo,
                      ),
                      item(
                        assetName: 'USDT',
                        asset: usdtlogo,
                      ),
                    ],
                  ),
                ),
                // const Spacer(),
                GestureDetector(
                  onTap: () {
                    web3provider.createMultiWalletSystem(context);
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
                        'Create Wallet',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
                20.h.toInt().height,
                Align(
                  child: Text.rich(TextSpan(children: [
                    const TextSpan(
                      text: 'I have a 12 word seed phrase, ',
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey,
                      ),
                    ),
                    TextSpan(
                      text: 'Import Wallet',
                      style: TextStyle(
                        fontSize: 14,
                        color: ColorConfig.white,
                      ),
                      recognizer: TapGestureRecognizer()
                        ..onTap = () {
                          modalSetup(
                            web3provider.mainContext,
                            modalPercentageHeight: 0.95,
                            createPage: const ImportWallet(),
                            showBarrierColor: true,
                          );
                          // web3provider.createMultiWalletSystem(context);
                        },
                    ),
                  ])),
                ),

                // GestureDetector(
                //   onTap: () {
                //     // web3provider.createMultiWalletSystem(context);
                //   },
                //   child: Container(
                //     width: double.infinity,
                //     height: 40.h,
                //     decoration: BoxDecoration(
                //         //color: ColorConfig.blue,
                //         borderRadius: BorderRadius.circular(10),
                //         border: Border.all(color: ColorConfig.secondary)),
                //     child: const Center(
                //       child: Text(
                //         'Import Wallet',
                //         style: TextStyle(
                //           color: Colors.white,
                //           fontSize: 16,
                //           fontWeight: FontWeight.bold,
                //         ),
                //       ),
                //     ),
                //   ),
                // ),
                20.h.toInt().height,
              ],
            );
          }),
        ),
      ),
    );
  }

  Widget item({required String assetName, required String asset}) {
    return Column(
      children: [
        Container(
          height: 60.h,
          //width: 60.w,
          padding: const EdgeInsets.symmetric(horizontal: 18),
          decoration: BoxDecoration(
            // color: ColorConfig.secondary.withOpacity(0.8),
            color: Colors.grey,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Center(
            child: SvgPicture.asset(
              asset,
              width: 30.w,
            ),
          ),
        ),
        10.h.toInt().height,
        Text(
          assetName,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}
