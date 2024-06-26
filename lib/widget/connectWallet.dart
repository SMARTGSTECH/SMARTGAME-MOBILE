import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:provider/provider.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:smartbet/utils/config/color.dart';
import 'package:smartbet/utils/helpers.dart';
import 'package:smartbet/walletConnect/provider.dart';
import 'package:smartbet/widget/alertSnackBar.dart';
import 'package:smartbet/widget/balalnceContainer.dart';
import 'package:smartbet/widget/button.dart';
import 'package:smartbet/widget/walletTabContainer.dart';
// import 'package:walletconnect_modal_flutter/widgets/walletconnect_modal_connect.dart';

class walletContainer extends StatelessWidget {
  const walletContainer({
    super.key,
    this.size,
  });
  final double? size;
  @override
  Widget build(BuildContext context) {
    return Consumer<UserWeb3Provider>(
      builder: (BuildContext context, provider, _) {
        //  provider.initializeW3MService();
        //provider.initialize(context);
        return Container(
          height: size ?? 240,
          width: size ?? 300,
          decoration: BoxDecoration(
              color: ColorConfig.scaffold,
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: ColorConfig.lightBoarder)),
          padding: EdgeInsets.all(20.0),
          child: SingleChildScrollView(
            child: Stack(
              alignment: AlignmentDirectional.center,
              children: [
                Column(
                  //   mainAxisSize: MainAxisSize.min,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        if (provider.connected)
                          Icon(Icons.refresh).onTap(() {
                            provider.setLoader(true);
                            // provider.refreshWallet((success, address, chain,
                            //     convertedbalance, weiBalance) {
                            //   print([
                            //     success,
                            //     address,
                            //     chain,
                            //     convertedbalance,
                            //     weiBalance
                            //   ]);
                            //   print(weiBalance.runtimeType);
                            //   if (true) {
                            //     print(convertedbalance);
                            //     provider.setConnection(true, convertedbalance);

                            //     CustomSnackBar(
                            //         context: context,
                            //         message: "Refreshed",
                            //         leftColor: Colors.green,
                            //         icon: Icons.wallet,
                            //         width: 145);
                            //     // provider.switchNetwork(97);
                            //   }
                            // }, context);
                          }),
                        Container().expand(),
                        Icon(Icons.cancel).onTap(() {
                          provider.setLoader(false);
                          finish(context);
                        }),
                      ],
                    ),
                    // Text(
                    //   provider.connected ? "Connected" : "Connect Wallet",
                    //   style: TextStyle(
                    //     fontSize: 16.sp,
                    //     color: provider.connected
                    //         ? Colors.green
                    //         : ColorConfig.yellow,
                    //     fontWeight: FontWeight.w500,
                    //   ),
                    // ),
                    8.height,

                    Column(
                      children: [
                        const Icon(
                          Icons.inbox,
                          color: Colors.green,
                        ).onTap(() {
                          print(provider
                              .adapter.state!.connectedAccount!.addressBase58);

                          print([
                            provider.adapter.state,
                            provider.adapter.identity,
                            provider.adapter.isAuthorized
                          ]); // provider.adapter
                          //     .authorize()
                          //     .then((value) => provider.output = value.toJson())
                          //     .catchError((error) => provider.output = error);
                        }),
                        const Icon(
                          Icons.inbox,
                          color: Colors.brown,
                        ).onTap(() {
                          //   provider.adapter.state!.connectedAccount;
                          provider.adapter
                              .authorize()
                              .then((value) => provider.output = value.toJson())
                              .catchError((error) => provider.output = error);
                        }),
                        Icon(
                          Icons.abc_sharp,
                          color: ColorConfig.red,
                        ).onTap(() async {
                          await provider.initTonwalletconnect();
                          //   await provider.service.init();
                          // await provider.service
                          //     .open(context: context)
                          //     .whenComplete(() {});
                        }),
                        if (provider.universalLink != null)
                          QrImageView(
                            backgroundColor: Colors.white,
                            data: provider.universalLink!,
                            version: QrVersions.auto,
                            size: 120,
                            gapless: false,
                          ).onTap(() {
                            print(provider.connector.wallet!.account);
                          }),
                        Icon(
                          Icons.earbuds,
                          color: ColorConfig.red,
                        ).onTap(() async {
                          await provider.initFuntionWC();
                          //   await provider.service.init();
                          // await provider.service
                          //     .open(context: context)
                          //     .whenComplete(() {});
                        }),
                        // WalletConnectModalConnect(
                        //   service: provider.service,
                        // ),
                        // Icon(
                        //   Icons.h_mobiledata,
                        //   color: ColorConfig.red,
                        // ).onTap(() async {
                        //   await provider.service
                        //       .open(context: context)
                        //       .whenComplete(() {});
                        // }),
                      ],
                    )
                    // Column(
                    //   children: !provider.w3mService.isConnected
                    //       ? [
                    //           W3MNetworkSelectButton(
                    //               service: provider.w3mService),
                    //           W3MConnectWalletButton(
                    //               service: provider.w3mService),
                    //         ]
                    //       : [
                    //           W3MAccountButton(service: provider.w3mService),
                    //         ],
                    // ),
                    // // if (provider.connected)
                    // //   Column(
                    // //     children: [
                    // //       Container(
                    // //         width: double.infinity,
                    // //         height: 40,
                    // //         decoration: BoxDecoration(
                    // //           color: Color.fromARGB(255, 19, 29, 122)
                    // //               .withOpacity(0.4),
                    // //           borderRadius: BorderRadius.circular(12.r),
                    // //         ),
                    // //         child: Row(
                    // //           children: [
                    // //             9.width,
                    // //             Icon(
                    // //               Icons.account_balance_wallet_rounded,
                    // //               color: ColorConfig.iconColor,
                    // //             ),
                    // //             9.width,
                    // //             Container(
                    // //               width: 190,
                    // //               child: Text(provider.currentAddress ?? 'N/A',
                    // //                   style: TextStyle(
                    // //                     //  fontFamily: AppFont.euclidCircularARegular,
                    // //                     fontSize: 14.sp,
                    // //                     color: const Color(0xFF9FA4BC),
                    // //                   ),
                    // //                   overflow: TextOverflow.ellipsis),
                    // //             ),
                    // //             // 0.width.expand(),
                    // //             // Image.network(
                    // //             //   "https://assets.coingecko.com/coins/images/825/large/bnb-icon2_2x.png?1696501970",
                    // //             //   //   color: imgcolor,
                    // //             //   width: 30,
                    // //             //   height: 30,
                    // //             // ),
                    // //             // 6.width,
                    // //           ],
                    // //         ),
                    // //       ),
                    // //       9.height,
                    // //       Row(
                    // //         children: [
                    // //           balanceContainer(
                    // //             size: size,
                    // //             balance: "N/A".toString(),

                    // //             // balance: 0.toString(),
                    // //             currency: "USD",
                    // //           ),
                    // //           0.width.expand(),

                    // //           /// 15.width,
                    // //           balanceContainer(
                    // //             size: size,
                    // //             balance: double.tryParse(
                    // //                     provider.weibalance.toString())
                    // //                 .toString(),
                    // //             currency: 'BNB',
                    // //           ),
                    // //         ],
                    // //       ),
                    // //     ],
                    // //   )
                    // // else
                    // //   provider.isLoading
                    // //       ? Lottie.asset(
                    // //           "assets/images/beiloader2.json",
                    // //           height: 100,
                    // //           width: 100,
                    // //         )
                    // //       : Container(
                    // //           decoration: BoxDecoration(
                    // //               borderRadius:
                    // //                   BorderRadius.all(radiusCircular(20)),
                    // //               image: DecorationImage(
                    // //                   image: AssetImage(
                    // //                       "assets/images/metabig.png"))),
                    // //           height: 100,
                    // //           width: 100,
                    // //         ).onTap(() {
                    // //           provider.setLoader(true);
                    // //           // provider.connectExtentionProvider((success,
                    // //           //     address,
                    // //           //     chain,
                    // //           //     convertedbalance,
                    // //           //     weiBalance) {
                    // //           //   print([
                    // //           //     success,
                    // //           //     address,
                    // //           //     chain,
                    // //           //     convertedbalance,
                    // //           //     weiBalance
                    // //           //   ]);
                    // //           //   print(weiBalance.runtimeType);
                    // //           //   if (chain == 56 || chain == 97) {
                    // //           //     provider.setConnection(
                    // //           //         true, convertedbalance);
                    // //           //     provider.setLoader(false);
                    // //           //     CustomSnackBar(
                    // //           //         context: context,
                    // //           //         message: "Connected",
                    // //           //         leftColor: Colors.green,
                    // //           //         icon: Icons.wallet,
                    // //           //         width: 145);
                    // //           //     // provider.switchNetwork(97);
                    // //           //   } else {
                    // //           //     CustomSnackBar(
                    // //           //         context: context,
                    // //           //         message: "Connected to wrong chain",
                    // //           //         leftColor: Colors.red,
                    // //           //         icon: Icons.warning,
                    // //           //         width: 240);
                    // //           //   }
                    // //           // }, context);
                    // //         }),
                    // // provider.connected ? 8.height : 8.height,
                    // if (provider.connected)
                    //   // Container()
                    //   CustomAppButton(
                    //       text: 'Disconnect',
                    //       shimmer: true,
                    //       onPressed: () {
                    //         provider.disconnecWallet();
                    //         CustomSnackBar(
                    //             context: context,
                    //             message: "Disconnected",
                    //             leftColor: Colors.red,
                    //             icon: Icons.warning,
                    //             width: 159);
                    //       },
                    //       color: ColorConfig.yellow,
                    //       textColor: Colors.white,
                    //       borderRadius: 5,
                    //       height: 24,
                    //       width: 100,
                    //       size: 15
                    //       //  padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 12.0),
                    //       )
                    // else
                    //   Text(
                    //     "Metamask",
                    //     style: TextStyle(
                    //       fontSize: 16.sp,
                    //       color: ColorConfig.iconColor,
                    //       fontWeight: FontWeight.w500,
                    //     ),
                    //   ),
                  ],
                ),
                // Positioned(
                //   child: Icon(Icons.cancel),
                //   bottom: 130,
                //   // right: 0,
                //   left: 200,
                // ),
              ],
            ),
          ),
        );
      },
    );
  }
}
