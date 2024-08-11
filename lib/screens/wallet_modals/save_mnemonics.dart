import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:provider/provider.dart';
import 'package:smartbet/screens/wallet_modals/wallet.dart';
import 'package:smartbet/shared/modal_sheet.dart';
import 'package:smartbet/utils/config/color.dart';
import 'package:smartbet/walletConnect/wallet_provider.dart';

class SaveMnemonics extends StatefulWidget {
  const SaveMnemonics({super.key});

  @override
  State<SaveMnemonics> createState() => _SaveMnemonicsState();
}

class _SaveMnemonicsState extends State<SaveMnemonics> {
  late Web3Provider web3provider;
  @override
  void initState() {
    web3provider = Provider.of<Web3Provider>(context, listen: false);
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
                      'Save Mnemonics',
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
                  'Please save your mnemonics in a safe place. You will need it to recover your wallet.',
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey,
                  ),
                ),
                20.h.toInt().height,
                Align(
                  child: Wrap(
                    runSpacing: 17,
                    spacing: 10,
                    runAlignment: WrapAlignment.center,
                    children: [
                      ...web3provider.userMnemonics.map((e) => item(e)).toList()
                    ],
                  ),
                ),
                const Spacer(),
                GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                    modalSetup(web3provider.mainContext,
                        modalPercentageHeight: 0.6,
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
                        'Proceed to wallet',
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

  Widget item(text) {
    int number = web3provider.userMnemonics.indexOf(text);
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Container(
          height: 35.h,
          width: 80.w,
          //padding: const EdgeInsets.all(18),
          decoration: BoxDecoration(
            color: Colors.grey,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Center(
            child: Text(
              text,
              style: const TextStyle(
                fontSize: 12,
                color: Colors.black,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ),
        Positioned.fill(
          child: Align(
            alignment: Alignment.topLeft,
            child: CircleAvatar(
              radius: 10,
              backgroundColor: ColorConfig.secondary,
              child: Text(
                '${number + 1}',
                style: const TextStyle(
                  fontSize: 10,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
