import 'dart:developer';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:provider/provider.dart';
import 'package:smartbet/utils/config/color.dart';
import 'package:smartbet/walletConnect/wallet_provider.dart';

class ImportWallet extends StatefulWidget {
  const ImportWallet({super.key});

  @override
  State<ImportWallet> createState() => _ImportWalletState();
}

class _ImportWalletState extends State<ImportWallet> {
  late Web3Provider web3provider;
  @override
  void initState() {
    web3provider = Provider.of<Web3Provider>(context, listen: false);
    super.initState();
  }

  bool buttonActive = false;
  checkFieldsValidity() {
    if (web3provider.one.text.isNotEmpty &&
        web3provider.two.text.isNotEmpty &&
        web3provider.three.text.isNotEmpty &&
        web3provider.four.text.isNotEmpty &&
        web3provider.five.text.isNotEmpty &&
        web3provider.six.text.isNotEmpty &&
        web3provider.seven.text.isNotEmpty &&
        web3provider.eight.text.isNotEmpty &&
        web3provider.nine.text.isNotEmpty &&
        web3provider.ten.text.isNotEmpty &&
        web3provider.eleven.text.isNotEmpty &&
        web3provider.twelve.text.isNotEmpty) {
      buttonActive = true;
      web3provider.enteredMnemonics =
          "${web3provider.one.text.trim()} ${web3provider.two.text.trim()} ${web3provider.three.text.trim()} ${web3provider.four.text.trim()} ${web3provider.five.text.trim()} ${web3provider.six.text.trim()} ${web3provider.seven.text.trim()} ${web3provider.eight.text.trim()} ${web3provider.nine.text.trim()} ${web3provider.ten.text.trim()} ${web3provider.eleven.text.trim()} ${web3provider.twelve.text.trim()}";

      log("entered mnemonics: ${web3provider.enteredMnemonics}");
      setState(() {});
    } else {
      buttonActive = false;
    }
  }

  Future<void> pasteTextIntoFields() async {
    List<TextEditingController> controllers = [
      web3provider.one,
      web3provider.two,
      web3provider.three,
      web3provider.four,
      web3provider.five,
      web3provider.six,
      web3provider.seven,
      web3provider.eight,
      web3provider.nine,
      web3provider.ten,
      web3provider.eleven,
      web3provider.twelve,
    ];

    // Get the data from the clipboard
    ClipboardData? data = await Clipboard.getData(Clipboard.kTextPlain);
    if (data?.text != null) {
      // Split the clipboard text on spaces
      log('data: ${data!.text}');
      List<String> splitText = data.text!.split(' ');
      if (splitText.length != 12) {
        toast("Invalid Mnemonic Phrase");
        return;
      }

      // Loop over the text fields and assign each one a piece of the split text
      for (int i = 0; i < controllers.length; i++) {
        if (i < splitText.length) {
          controllers[i].text =
              splitText[i].toString().replaceAll(',', '').trim();
        } else {
          // If there is no more text to paste, break the loop
          break;
        }
      }
      checkFieldsValidity();
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: kBackgroundColor,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 18.0),
          child: LayoutBuilder(builder: (context, constraints) {
            return Listener(
              onPointerUp: (_) {
                FocusScopeNode currentFocus = FocusScope.of(context);
                if (!currentFocus.hasPrimaryFocus &&
                    currentFocus.focusedChild != null) {
                  currentFocus.focusedChild!.unfocus();
                }
              },
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: constraints.maxHeight * 0.03),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Import Wallet',
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
                  // const Text(
                  //   'Enter your 12-word mnemonic phrase to import your wallet.',
                  //   style: TextStyle(
                  //     fontSize: 14,
                  //     color: Colors.grey,
                  //   ),
                  // ),
                  RichText(
                    text: TextSpan(
                      children: [
                        const TextSpan(
                          text:
                              'Enter your 12-word mnemonic phrase to import your wallet or ',
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.grey,
                          ),
                        ),
                        TextSpan(
                          text: 'Paste from clipboard',
                          style: const TextStyle(
                            fontSize: 14,
                            color: Colors.white,
                          ),
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              pasteTextIntoFields();
                            },
                        ),
                      ],
                    ),
                  ),
                  20.h.toInt().height,
                  Expanded(
                    child: SingleChildScrollView(
                      physics: const BouncingScrollPhysics(),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Expanded(
                                child: inputWidget(
                                  position: 1,
                                  controller: web3provider.one,
                                ),
                              ),
                              SizedBox(width: 12.w),
                              Expanded(
                                child: inputWidget(
                                  position: 2,
                                  controller: web3provider.two,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 14.h),
                          Row(
                            children: [
                              Expanded(
                                child: inputWidget(
                                  position: 3,
                                  controller: web3provider.three,
                                ),
                              ),
                              SizedBox(width: 12.w),
                              Expanded(
                                child: inputWidget(
                                  position: 4,
                                  controller: web3provider.four,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 14.h),
                          Row(
                            children: [
                              Expanded(
                                child: inputWidget(
                                  position: 5,
                                  controller: web3provider.five,
                                ),
                              ),
                              SizedBox(width: 12.w),
                              Expanded(
                                child: inputWidget(
                                  position: 6,
                                  controller: web3provider.six,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 14.h),
                          Row(
                            children: [
                              Expanded(
                                child: inputWidget(
                                  position: 7,
                                  controller: web3provider.seven,
                                ),
                              ),
                              SizedBox(width: 12.w),
                              Expanded(
                                child: inputWidget(
                                  position: 8,
                                  controller: web3provider.eight,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 14.h),
                          Row(
                            children: [
                              Expanded(
                                child: inputWidget(
                                  position: 9,
                                  controller: web3provider.nine,
                                ),
                              ),
                              SizedBox(width: 12.w),
                              Expanded(
                                child: inputWidget(
                                  position: 10,
                                  controller: web3provider.ten,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 14.h),
                          Row(
                            children: [
                              Expanded(
                                child: inputWidget(
                                  position: 11,
                                  controller: web3provider.eleven,
                                ),
                              ),
                              SizedBox(width: 12.w),
                              Expanded(
                                child: inputWidget(
                                  position: 12,
                                  controller: web3provider.twelve,
                                  inputAction: TextInputAction.done,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 30.h),
                          GestureDetector(
                            onTap: () {
                              if (buttonActive) {
                                web3provider.importWallet(context);
                              }
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
                                  'Save',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          // Obx(
                          //   () => ActionButton(
                          //     text: "Save",
                          //     color: buttonActive
                          //         ? kPrimaryColor
                          //         : kPrimaryColor.withOpacity(0.1),
                          //     textColor:
                          //         buttonActive ? kWhiteColor : kPrimaryColor,
                          //     callback: () {

                          //     },
                          //     load: web3provider.load.value,
                          //   ),
                          // ),
                          SizedBox(height: 30.h),
                          Container(
                            height: 140.h,
                            width: double.infinity,
                            padding: const EdgeInsets.symmetric(
                                horizontal: 18.0, vertical: 10),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: ColorConfig.secondary.withOpacity(0.1),
                            ),
                            child: Column(
                              children: [
                                Container(
                                  height: 8.h,
                                  width: 30.w,
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 18.0),
                                  decoration: BoxDecoration(
                                    color: ColorConfig.secondary,
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                ),
                                SizedBox(height: 10.h),
                                Text("Disclaimer",
                                    style: TextStyle(
                                      fontSize: 14.sp,
                                      fontWeight: FontWeight.w500,
                                    )),
                                SizedBox(height: 7.h),
                                Text(
                                    "Mnemonics is essentially a backup for your private key. Losing your private key means losing your crypto assets. If you lose access to your crypto wallet, re-entering your exact seed phrase into a new BIP39 software wallet is the only way to get your cryptocurrency back.",
                                    style: TextStyle(
                                      fontSize: 10.sp,
                                      color: ColorConfig.white.withOpacity(0.5),
                                    )),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            );
          }),
        ),
      ),
    );
  }

  Widget inputWidget(
      {required int position,
      required TextEditingController controller,
      TextInputAction? inputAction}) {
    return Container(
      height: 40.h,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(14),
        color: ColorConfig.secondary.withOpacity(0.5),
      ),
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Positioned.fill(
            child: Align(
              alignment: Alignment.topLeft,
              child: CircleAvatar(
                radius: 9,
                backgroundColor: ColorConfig.secondary,
                child: Text(
                  "$position",
                  style: TextStyle(
                    color: ColorConfig.iconColor,
                    fontSize: 8.sp,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
          ),
          Center(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(20.0, 18, 18, 18),
              child: TextFormField(
                  controller: controller,
                  textInputAction: inputAction ?? TextInputAction.next,
                  keyboardType: TextInputType.text,
                  showCursor: true,
                  cursorColor: ColorConfig.secondary,
                  onChanged: (s) {
                    checkFieldsValidity();
                  },
                  style: TextStyle(color: ColorConfig.white, fontSize: 14.sp),
                  decoration: const InputDecoration(
                    border: InputBorder.none,
                    enabledBorder: InputBorder.none,
                    focusedBorder: InputBorder.none,
                    errorBorder: InputBorder.none,
                  )),
            ),
          ),
        ],
      ),
    );
  }
}
