import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:provider/provider.dart';
import 'package:smartbet/screens/wallet_modals/wallet.dart';
import 'package:smartbet/shared/modal_sheet.dart';
import 'package:smartbet/utils/config/color.dart';
import 'package:smartbet/utils/helpers.dart';
import 'package:smartbet/walletConnect/wallet_provider.dart';
import 'package:smartbet/widget/app_input_field.dart';

class SendCrypto extends StatefulWidget {
  final String assetLogo;
  final String assetSymbol;
  final String assetAddress;
  final String assetBalance;
  final String? chainLogo;
  const SendCrypto({
    super.key,
    required this.assetLogo,
    required this.assetSymbol,
    required this.assetAddress,
    required this.assetBalance,
    this.chainLogo,
  });

  @override
  State<SendCrypto> createState() => _SendCryptoState();
}

class _SendCryptoState extends State<SendCrypto> {
  final cryptoAmountFormatter = CryptoAmountFormatter();
  TextEditingController sendAmountController = TextEditingController();
  TextEditingController addressController = TextEditingController();

  late Web3Provider web3provider;

  @override
  void initState() {
    web3provider = Provider.of<Web3Provider>(context, listen: false);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: ,
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
                      'Send Crypto',
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
                20.h.toInt().height,
                Align(
                  child: Text(
                    'Amount',
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: Colors.white.withOpacity(0.5)),
                  ),
                ),
                5.h.toInt().height,
                Align(
                  child: SizedBox(
                    width: constraints.maxWidth * 0.8,
                    child: TextFormField(
                      enabled: true,
                      controller: sendAmountController,
                      textAlign: TextAlign.center,
                      cursorColor: ColorConfig.secondary,
                      showCursor: false,
                      minLines: 1,
                      // maxLength: 11,
                      cursorWidth: 2.0,
                      keyboardType:
                          const TextInputType.numberWithOptions(decimal: true),
                      inputFormatters: [cryptoAmountFormatter],
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 20.sp,
                      ),
                      onChanged: (val) {
                        //calculateUsd();
                      },
                      decoration: InputDecoration(
                        hintText: "0.0000",
                        hintStyle: TextStyle(
                          color: Colors.grey,
                          fontSize: 20.h,
                        ),
                        border: InputBorder.none,
                        enabledBorder: InputBorder.none,
                        focusedBorder: InputBorder.none,
                        errorBorder: InputBorder.none,
                      ),
                    ),
                  ),
                ),
                20.h.toInt().height,
                AppInputField(
                  controller: addressController,
                  prefixIcon: Icon(
                    Icons.data_array_rounded,
                    color: ColorConfig.iconColor,
                  ),
                  fillColor:
                      const Color.fromARGB(255, 19, 27, 93).withOpacity(0.4),
                  inputColor: ColorConfig.iconColor,
                  hintText: 'Wallet Address',
                  keyboardType: TextInputType.text,
                  // TextInputType.numberWithOptions(decimal: true),
                  allowWordSpacing: true,
                  inputFormatters: const [
                    // NumericalRangeFormatter(min: minAmount, max: maxAmount),
                    // FilteringTextInputFormatter.allow(RegExp(r'^[0-9]+.?[0-9]*')),
                  ],
                  cursorColor: Colors.white,
                  onChanged: (value) {},

                  validator: (value) {
                    return null;

                    // if (value == null || value.isEmpty) {
                    //   return "Please Enter Your Code";
                    // }
                    // if (value.length < 5) {
                    //   return 'Code must be 5 characters';
                    // }
                    // return null;
                  },
                ),
                // Row(
                //   mainAxisAlignment: MainAxisAlignment.center,
                //   children: [
                //     SvgPicture.asset(
                //       widget.assetLogo,
                //       width: 15.w,
                //       height: 15.h,
                //     ),
                //     8.w.toInt().width,
                //     Text(
                //       truncate(widget.assetAddress, length: 20),
                //       style: TextStyle(
                //         fontSize: 10.sp,
                //         fontWeight: FontWeight.w500,
                //         color: Colors.grey,
                //       ),
                //     ),
                //   ],
                // ),
                5.h.toInt().height,
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  decoration: BoxDecoration(
                    color: ColorConfig.secondary.withOpacity(0.5),
                    borderRadius: BorderRadius.circular(14),
                  ),
                  child: Text(
                    '${widget.assetSymbol} balance: ${widget.assetBalance}',
                    style: TextStyle(
                      fontSize: 10.sp,
                    ),
                  ),
                ),
                // 15.h.toInt().height,
                const Spacer(),
                GestureDetector(
                  onTap: () {
                    // if (buttonActive) {
                    //   web3provider.importWallet(context);
                    // }
                    web3provider.sendCrypto(
                        to: addressController.text.trim(),
                        symbol: widget.assetSymbol,
                        amount: sendAmountController.text.trim());
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
                        'Send',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
                //const Spacer(),
                10.h.toInt().height,
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
