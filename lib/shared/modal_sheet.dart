import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smartbet/walletConnect/wallet_provider.dart';

modalSetup(context,
    {required double modalPercentageHeight,
    required Widget createPage,
    required bool showBarrierColor,
    AnimationController? animationController}) {
  // AppController homeController = Get.find();
  Web3Provider web3provider = Provider.of<Web3Provider>(context, listen: false);
  return showModalBottomSheet(
    transitionAnimationController: animationController,
    showDragHandle: true,

    //backgroundColor: Colors.black,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.only(
          topLeft: Radius.circular(30), topRight: Radius.circular(30)),
    ),
    context: context,
    isScrollControlled: true,
    builder: (context) => AnimatedContainer(
      duration: const Duration(milliseconds: 500),
      height: web3provider.isKeyBoardActive
          ? MediaQuery.of(context).size.height * modalPercentageHeight +
              MediaQuery.of(context).viewInsets.bottom
          : MediaQuery.of(context).size.height * modalPercentageHeight,
      child: createPage,
    ),
  );
}
