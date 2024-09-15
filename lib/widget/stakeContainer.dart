import 'dart:math';

import 'package:contained_tab_bar_view/contained_tab_bar_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:provider/provider.dart';
import 'package:smartbet/constants/strings.dart';
import 'package:smartbet/screens/car/desktop.dart';
import 'package:smartbet/screens/car/provider.dart';
import 'package:smartbet/screens/coin/provider.dart';
import 'package:smartbet/screens/dice/provider.dart';
import 'package:smartbet/screens/fruit/provider.dart';
import 'package:smartbet/screens/home/provider.dart';
import 'package:smartbet/utils/config/color.dart';
import 'package:smartbet/utils/config/size.dart';
import 'package:smartbet/utils/constants.dart';
import 'package:smartbet/utils/helpers.dart';
import 'package:smartbet/walletConnect/provider.dart';
import 'package:smartbet/widget/alertSnackBar.dart';
import 'package:smartbet/widget/app_input_field.dart';
import 'package:smartbet/widget/button.dart';
import 'package:smartbet/widget/comingSoon.dart';
import 'package:smartbet/widget/conInput.dart';
import 'package:smartbet/widget/walletTabContainer.dart';

import '../walletConnect/wallet_provider.dart';

class StakeContainer extends StatelessWidget {
  StakeContainer(
      {super.key,
      this.coin = false,
      this.dice = false,
      this.fruit = false,
      this.car = false,
      this.dym,
      this.isEvent = false,
      this.containerH,
      this.containerW,
      this.prediction = '',
      this.tabWidth,
      this.maxAmount = 0.0,
      this.minAmount = 0.0,
      this.gameType}) {
    // getallprices().whenComplete(() => print(getPrice("BNBUSDT")));
  }

  final bool coin;
  final bool dice;
  final bool fruit;
  final bool car;
  final double? dym;
  final bool? isEvent;
  final String prediction;
  final double? containerH;
  final double? containerW;
  final double? tabWidth;
  final double minAmount;
  final double maxAmount;
  final String? gameType;

  @override
  Widget build(BuildContext context) {
    // final userWallet = Provider.of<UserWeb3Provider>(context, listen: false);
    // final coinP = Provider.of<CoinCapProvider>(context, listen: false);
    // Provider.of<Web3Provider>(context, listen: false).loadWallet();
    //userWallet.fetchRate(context);
    // print(
    //     coinP.coinArray.where((element) => element.name == "BNB").first.price);
    return SingleChildScrollView(
      child: Stack(children: [
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(radiusCircular(10)),
            color: Color(0xff0a0d27),
          ),
          // padding: EdgeInsets.all(8.0),
          child: Container(
            decoration: BoxDecoration(
              //   color: Colors.red,
              borderRadius: BorderRadius.all(radiusCircular(10)),
            ),
            height: 400.h,
            width: double.infinity,
            child: Container(
              width: containerW ?? 200,
              height: containerH ?? 100,
              child: ContainedTabBarView(
                // onChange: (intt) {
                //   print(intt);
                // },t
                tabBarProperties: TabBarProperties(
                  height: 45.h,
                  width: double.infinity,
                  indicatorColor: ColorConfig.yellow,

                  //  indicatorWeight: 10.0,
                  //  indicator:  ContainerTabIndicator(
                  //     radius: BorderRadius.circular(7.0),
                  //     color: Colors.blue,
                  //     borderWidth: 9.0,
                  //     borderColor: Colors.red,
                  //   ),
                  // indicator: BoxDecoration(
                  //   borderRadius: const BorderRadius.only(
                  //     topLeft: Radius.circular(9),
                  //     topRight: Radius.circular(9),
                  //   ),
                  //   border: Border.all(),
                  //   color: ColorConfig.desktopGameappBar.withOpacity(0.2),
                  // ),
                  labelColor: ColorConfig.yellow,
                  unselectedLabelColor: ColorConfig.tabincurrentindex,
                ),

                tabBarViewProperties: TabBarViewProperties(
                    physics: NeverScrollableScrollPhysics()),
                tabs: [
                  Text('USDT\n BSC', style: TextStyle(fontSize: 12.sp)),
                  isEvent!
                      ? Text('   ETH\n(BASE)\n USDT',
                          style: TextStyle(fontSize: 12.sp))
                      : Text('   ETH\n(BASE)',
                          style: TextStyle(fontSize: 12.sp)),
                  isEvent!
                      ? Text('   SOL\n USDC', style: TextStyle(fontSize: 12.sp))
                      : Text(
                          'SOL',
                          style: TextStyle(fontSize: 12.sp),
                        ),
                  isEvent!
                      ? Text('  TON\n USDT', style: TextStyle(fontSize: 12.sp))
                      : Text(
                          'TON',
                          style: TextStyle(fontSize: 12.sp),
                        ),
                  Text('BETK', style: TextStyle(fontSize: 12.sp)),
                ],
                views: [
                  /* -------------------------------------------------------------------------- */
                  /*                               Tab1                               */
                  /* -------------------------------------------------------------------------- */
                  ViewBody(
                    coinType: 'USDT',
                    minAmount: minAmount,
                    maxAmount: maxAmount,
                    isEvent: isEvent,
                    prediction: prediction,
                    car: car,
                    dice: dice,
                    fruit: fruit,
                    coin: coin,
                    runtimeType: runtimeType,
                    gameType: gameType!,
                  ),

                  /* -------------------------------------------------------------------------- */
                  /*                               Tab2                              */
                  /* -------------------------------------------------------------------------- */

                  isEvent!
                      ? comingSoon()
                      : ViewBody(
                          coinType: 'ETH',
                          minAmount: minAmount,
                          maxAmount: maxAmount,
                          isEvent: isEvent,
                          prediction: prediction,
                          car: car,
                          dice: dice,
                          fruit: fruit,
                          coin: coin,
                          runtimeType: runtimeType,
                          gameType: gameType!,
                        ),
                  /* ---------------------------------- TAB3 ---------------------------------- */

                  isEvent!
                      ? comingSoon()
                      : ViewBody(
                          coinType: 'SOL',
                          minAmount: minAmount,
                          maxAmount: maxAmount,
                          isEvent: isEvent,
                          prediction: prediction,
                          car: car,
                          dice: dice,
                          fruit: fruit,
                          coin: coin,
                          runtimeType: runtimeType,
                          gameType: gameType!,
                        ),

                  /* ---------------------------------- TAB4 ---------------------------------- */

                  isEvent!
                      ? comingSoon()
                      : ViewBody(
                          coinType: 'TON',
                          minAmount: minAmount,
                          maxAmount: maxAmount,
                          isEvent: isEvent,
                          prediction: prediction,
                          car: car,
                          dice: dice,
                          fruit: fruit,
                          coin: coin,
                          runtimeType: runtimeType,
                          gameType: gameType!,
                        ),
                  comingSoon(),
                ],
                onChange: (index) =>
                    context.read<UserWeb3Provider>().resetUserbalance(),
              ),
            ).paddingTop(50),
          ),
        ),
        Positioned(
          top: 5,
          right: 21,
          child: Consumer<UserWeb3Provider>(
            builder: (BuildContext context, userWalletProvider, _) {
              return Container(
                width: 50,
                height: 50,
                // color: Colors.black,
                child: Center(
                    child: const Icon(
                  Icons.cancel,
                  size: 28,
                ).onTap(() {
                  finish(context);
                  userWalletProvider.setTransactionLoader(false);
                })),
              );
            },
          ),
        ),
      ]),
    );
  }
}

class ViewBody extends StatelessWidget {
  const ViewBody({
    super.key,
    required this.minAmount,
    required this.coin,
    required this.maxAmount,
    required this.isEvent,
    required this.prediction,
    required this.car,
    required this.dice,
    required this.fruit,
    required this.coinType,
    required this.runtimeType,
    required this.gameType,
  });

  final double minAmount;
  final double maxAmount;
  final bool? isEvent;
  final String prediction;
  final bool car;
  final bool dice;
  final bool fruit;
  final bool coin;
  final String gameType;
  final Type runtimeType;
  final String coinType;

  @override
  Widget build(BuildContext context) {
    return Consumer6<CarStateProvider, DiceStateProvider, FruitStateProvider,
        CoinStateProvider, UserWeb3Provider, Web3Provider>(
      builder: (context, carProvider, diceProvider, fruitProvider, coinProvider,
          userWalletProvider, walletProvider, _) {
        print("raise");
        return Container(
          child: SingleChildScrollView(
            child: userWalletProvider.startedTransaction
                ? TransactionWidget()
                : Column(children: [
                    20.height,
                    !userWalletProvider.cryptoRate.isNotEmpty
                        ? Text(
                            //"${0} ${coinType}",
                            double.parse(userinput.text == ''
                                        ? '0'
                                        : userinput.text) <
                                    double.parse(minAmount.toString())
                                ? "Min stake amount is \$$minAmount"
                                : double.parse(userinput.text == ''
                                            ? '0'
                                            : userinput.text) >
                                        double.parse(maxAmount.toString())
                                    ? "Max stake amount is \$${maxAmount} "
                                    : "${userWalletProvider.userConvertedStaked} $coinType",
                            style: TextStyle(
                                fontSize: 16.sp,
                                color: ColorConfig.yellow,
                                fontWeight: FontWeight.bold),
                          )
                        : Lottie.asset(
                            "assets/images/beiLoader.json",
                            height: 50,
                            width: 50,
                          ),
                    20.height,
                    inputContainer(
                      minAmount: minAmount,
                      maxAmount: maxAmount,
                      coin: coinType,
                      instances: userWalletProvider,
                    ),
                    6.height,
                    isEvent!
                        ? conInput(
                            isEvent: isEvent,
                            img: "assets/images/tesla.png",
                            color: Colors.transparent,
                            colorImg: true,
                            predition: prediction,
                          )
                        : car
                            ? conInput(
                                img: "assets/images/tesla.png",
                                color: carProvider.blue
                                    ? ColorConfig.blueCar.withOpacity(0.8)
                                    : carProvider.red
                                        ? ColorConfig.redCar.withOpacity(0.9)
                                        : carProvider.yellow
                                            ? ColorConfig.yellowCar
                                            : ColorConfig.greenCar
                                                .withOpacity(0.8),
                                colorImg: true,
                                predition: carProvider.blue
                                    ? "Blue"
                                    : carProvider.green
                                        ? "Green"
                                        : carProvider.yellow
                                            ? "Yellow"
                                            : "Red",
                              )
                            : dice
                                ? conInput(
                                    img: diceProvider.one
                                        ? "assets/images/1.png"
                                        : diceProvider.two
                                            ? "assets/images/2.png"
                                            : diceProvider.three
                                                ? "assets/images/3.png"
                                                : diceProvider.four
                                                    ? "assets/images/4.png"
                                                    : diceProvider.five
                                                        ? "assets/images/5.png"
                                                        : "assets/images/6.png",
                                    predition: diceProvider.one
                                        ? "1"
                                        : diceProvider.two
                                            ? "2"
                                            : diceProvider.three
                                                ? "3"
                                                : diceProvider.four
                                                    ? "4"
                                                    : diceProvider.five
                                                        ? "5"
                                                        : "6",
                                  )
                                : fruit
                                    ? conInput(
                                        colorImg: true,
                                        predition: fruitProvider.banana
                                            ? "Bananna"
                                            : fruitProvider.orange
                                                ? "Orange"
                                                : fruitProvider.pineapple
                                                    ? "Pineapple"
                                                    : "StrawBerry",
                                        color: fruitProvider.pineapple
                                            ? Color(0xfffbd604)
                                            : fruitProvider.orange
                                                ? Colors.transparent
                                                : Colors.transparent,
                                        img: fruitProvider.pineapple
                                            ? "assets/images/pine.png"
                                            : fruitProvider.orange
                                                ? "assets/images/orange.png"
                                                : fruitProvider.banana
                                                    ? "assets/images/banana.png"
                                                    : "assets/images/straw.png")
                                    : coin
                                        ? conInput(
                                            predition: coinProvider.head
                                                ? "Head"
                                                : "Tail",
                                            img: coinProvider.head
                                                ? "assets/images/H.png"
                                                : "assets/images/T.png")
                                        : Container(),

                    //Consumer5<>(child: conInput()),
                    20.height,
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 7.w),
                      child: walletTabContainer(
                        inputcontroller: dice
                            ? diceGameController
                            : coin
                                ? coinGameController
                                : fruit
                                    ? fruitGamecontroller
                                    : carGameController,
                        wallet: userWalletProvider.returnAddress(
                                context)[coinType.toLowerCase()] ??
                            '',
                        isConnected: userWalletProvider.connected,
                      ),
                    ),
                    30.height,
                    userWalletProvider.userConvertedStaked.toDouble() !=
                            0.toDouble()
                        ? CustomAppButton(
                            text: 'Stake',
                            shimmer: true,
                            onPressed: () {
                              // walletProvider.sendCrypto(
                              //     to:
                              //         '0x3809e082f3eA4195271825f6b724c3c3809eC127',
                              //     symbol: coinType,
                              //     amount: userWalletProvider.userConvertedStaked
                              //         .toString());

                              Map gameObj = {
                                'wallet': userWalletProvider.returnAddress(
                                    context)[coinType.toLowerCase()],
                                'amount': userWalletProvider.userConvertedStaked
                                    .toString(),
                                'base': userinput.text,
                                'type': gameType,
                                'chain': coinType.contains('ETH')
                                    ? 'BASE'
                                    : coinType.contains('USDT')
                                        ? 'BSC'
                                        : coinType.contains('SOL')
                                            ? 'SOLANA'
                                            : 'TON',
                                'token': coinType.contains('USDT')
                                    ? "USDT"
                                    : 'NATIVE',
                                'side': predictionContoller.text,
                                'session': isEvent! ? 'sss' : ''
                              };
                              print(gameObj);
                              walletProvider.stakeCrypto(context,
                                  to: contractLive[coinType],
                                  symbol: coinType,
                                  amount: gameObj['amount'],
                                  object: gameObj,
                                  instances: userWalletProvider);
                              // userWalletProvider.stakeGame(gameObj, context);

                              // print([
                              //   userWalletProvider.userConvertedStaked
                              //       .toDouble(),
                              //   userWalletProvider.weibalance.runtimeType,
                              //   userWalletProvider.weibalance,
                              //   // userWalletProvider.weibalance /
                              //   //     BigInt.from(pow(10, 18))
                              // ]);
                              if (userWalletProvider.userConvertedStaked == 0) {
                                CustomSnackBar(
                                    context: context,
                                    message: "Enter Stake Amount",
                                    width: 195);
                                return;
                              }
                              // if (!userWalletProvider.connected) {
                              //   CustomSnackBar(
                              //       context: context,
                              //       message: "Please Connect Wallet",
                              //       width: 219);

                              //   return;
                              // }
                              // if ((userWalletProvider.userConvertedStaked
                              //             .toDouble() +
                              //         0.0004) >
                              //     userWalletProvider.weibalance) {
                              //   print((userWalletProvider.userConvertedStaked
                              //               .toDouble() +
                              //           0.0004) >
                              //       userWalletProvider.weibalance);
                              //   CustomSnackBar(
                              //       context: context,
                              //       message: "Sorry, Insufficient Funds",
                              //       width: 219);

                              //   return;
                              // }
                              print([
                                userWalletProvider
                                    .userConvertedStaked.runtimeType
                              ]);
                              // userWalletProvider.initTransaction(
                              //     userWalletProvider
                              //         .userConvertedStaked,
                              //     context,
                              //     predictionContoller.text
                              //         .toLowerCase(),
                              //     //this is the bend for prediction
                              //     car
                              //         ? "race"
                              //         : dice
                              //             ? "dice"
                              //             : coin
                              //                 ? "coin"
                              //                 : "fruit");
                              /* -------------------- this this for transaction stautus ------------------- */
                              //  userWalletProvider.setTransactionLoader(true);
                              //  print(provider)
                              // _showAlertContainer(
                              //   context: context,
                              // );
                              // Add your onPressed logic here

                              // Navigator.of(context).pop();
                            },
                            color: ColorConfig.yellow,
                            textColor: Colors.white,
                            borderRadius: 5,
                            height: 24,
                            width: 60,
                            size: 16
                            //  padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 12.0),
                            )
                        : CustomAppButton(
                            text: 'Stake',
                            shimmer: true,
                            onPressed: () {
                              CustomSnackBar(
                                  context: context,
                                  message:
                                      "Enter $coinType amount you want to stake ",
                                  width: 219);
                            },
                            color: ColorConfig.yellow.withOpacity(0.2),
                            textColor: Colors.white,
                            borderRadius: 5,
                            height: 24,
                            width: 60,
                            size: 16
                            //  padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 12.0),
                            ),
                    // Prices_tab(),
                  ]),
          ),
        );
      },
    );
  }
}

class TransactionWidget extends StatelessWidget {
  const TransactionWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        40.height,
        Lottie.asset(
          "assets/images/BEItrx.json",
          height: 160,
          width: 160,
        ),
        40.height,
        Padding(
          padding: const EdgeInsets.all(20.0),
          child: Text(
              'Please wait for confirmation before exiting so that the system can accurately record your stake.Once your stake is successful, you will be automatically redirected.',
              style: TextStyle(
                fontSize: 15.sp,
                color: ColorConfig.iconColor,
              ),
              textAlign: TextAlign.center),
        ),
      ],
    );
  }
}

class Transactionwidget extends StatelessWidget {
  const Transactionwidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        40.height,
        Lottie.asset(
          "assets/images/BEItrx.json",
          height: 160,
          width: 160,
        ),
        40.height,
        Padding(
          padding: const EdgeInsets.all(20.0),
          child: Text(
              'Please wait for confirmation before exiting so that the system can accurately record your stake.Once your stake is successful, you will be automatically redirected.',
              style: TextStyle(
                fontSize: 15.sp,
                color: ColorConfig.iconColor,
              ),
              textAlign: TextAlign.center),
        ),
      ],
    );
  }
}
// onPressed: () {
//                                           // Close the dialog
//                                         },

class inputContainer extends StatelessWidget {
  final double minAmount;
  final double maxAmount;
  final UserWeb3Provider instances;

  final String coin;

  const inputContainer({
    required this.minAmount,
    required this.maxAmount,
    required this.coin,
    required this.instances,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 7.w),
      child: Container(
        // height: 90,
        width: SizeConfig.screenWidth! <= 450 ? 300.w : 400,
        child: AppInputField(
          controller: userinput,
          prefixIcon: Icon(
            Icons.attach_money,
            color: ColorConfig.iconColor,
          ),
          fillColor: Color.fromARGB(255, 19, 27, 93).withOpacity(0.4),
          inputColor: ColorConfig.iconColor,
          hintText: 'Enter amount',
          keyboardType:
              TextInputType.numberWithOptions(decimal: true, signed: false),
          // TextInputType.numberWithOptions(decimal: true),
          allowWordSpacing: true,
          inputFormatters: [
            // NumericalRangeFormatter(min: minAmount, max: maxAmount),
            FilteringTextInputFormatter.allow(RegExp(r'^[0-9]+.?[0-9]*')),
          ],
          cursorColor: Colors.white,
          onChanged: (value) {
            print([value, maxAmount, minAmount]);
            instances.setcryptoRate(
                double.parse(value) < double.parse(minAmount.toString())
                    ? "0"
                    : double.parse(value) > double.parse(maxAmount.toString())
                        ? "0"
                        : value == ''
                            ? 0.toString()
                            : value,
                context,
                coin);
            print(value);
          },

          validator: (value) {
            if (value == null || value.isEmpty) {
              return "Please Enter Your Code";
            }
            if (value.length < 5) {
              return 'Code must be 5 characters';
            }
            return null;
          },
        ),
      ),
    );
  }
}

class NumericalRangeFormatter extends TextInputFormatter {
  final double min;
  final double max;

  NumericalRangeFormatter({this.min = 0, this.max = double.infinity});

  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    final value = double.tryParse(newValue.text);
    if (value != null) {
      if (value < min) {
        return TextEditingValue(
          text: min.toString(),
          selection: TextSelection.collapsed(offset: min.toString().length),
        );
      } else if (value > max) {
        return TextEditingValue(
          text: max.toString(),
          selection: TextSelection.collapsed(offset: max.toString().length),
        );
      }
    }
    return newValue;
  }
}
