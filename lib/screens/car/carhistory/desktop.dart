import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:provider/provider.dart';
import 'package:smartbet/screens/car/carhistory/carapi.dart';
import 'package:smartbet/screens/car/carhistory/historyTable.dart';
import 'package:smartbet/screens/history/components/details.dart';
import 'package:smartbet/screens/history/components/historyTable.dart';
import 'package:smartbet/socket/provider.dart';
import 'package:smartbet/utils/config/color.dart';
import 'package:smartbet/utils/config/size.dart';
import 'package:smartbet/walletConnect/provider.dart';
import 'package:smartbet/widget/customAppBar.dart';
import 'package:smartbet/widget/resultWidget.dart';

class CarHistoryScreen extends StatefulWidget {
  // const CarHistoryScreen({Key? key}) : super(key: key);
  const CarHistoryScreen({super.key, this.directLaunch = false});
  final bool directLaunch;

  @override
  State<CarHistoryScreen> createState() => _CarHistoryScreenState();
}

List names = ["18/20 - 2010", "Game Type", 'Status'];

class _CarHistoryScreenState extends State<CarHistoryScreen> {
  @override
  Widget build(BuildContext context) {
    if (widget.directLaunch) {
      return Scaffold(
          appBar: customAppbar(context),
          // backgroundColor: ColorConfig.scaffold,
          body: SizeConfig.screenWidth! < 1160
              ? TabletHistoryWidget()
              : HisToryWidget());
    } else {
      return Scaffold(
          appBar: customAppbar(context),

          // backgroundColor: ColorConfig.scaffold,
          body: SizeConfig.screenWidth! < 1160
              ? TabletHistoryWidget()
              : HisToryWidget());
    }
  }
}

class TabletHistoryWidget extends StatelessWidget {
  const TabletHistoryWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Expanded(
            child: Container(
          // height: MediaQuery.of(context).size.height,
          padding: const EdgeInsets.all(5),
          decoration: const BoxDecoration(color: Color(0xFF034F96)),

          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: ConstrainedBox(
                      constraints: BoxConstraints(
                        minWidth: 10,
                        //MediaQuery.of(context).size.width,
                      ),
                      // padding: const EdgeInsets.all(20),
                      child: Text(
                        '',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: SizeConfig.screenWidth! >= 1153
                                ? 26
                                : SizeConfig.screenWidth! < 1153
                                    ? 20
                                    : SizeConfig.screenWidth! < 999
                                        ? 17
                                        : 9,
                            decoration: TextDecoration.none),
                        textAlign: TextAlign.center,
                        // if (SizeConfig.screenWidth! >= 1137)
                      ),
                    ),
                  )
                ],
              ),
              const SizedBox(
                height: 30,
              ),
              Expanded(
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: ConstrainedBox(
                      constraints: BoxConstraints(
                        minWidth: 20,
                        //MediaQuery.of(context).size.width,
                      ),
                      child: Container(
                        width: 600,
                        child: myStakeWidget(),
                      )
                      //myStakeWidget(),
                      //  child: Details()
                      //Text('safdf'),
                      //Details(),
                      ),
                ),
              )
            ],
          ),
        )),
      ),
    );
  }
}

class HisToryWidget extends StatelessWidget {
  const HisToryWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        children: [
          Expanded(
              flex: 1,
              child: Container(
                // height: MediaQuery.of(context).size.height,
                padding: const EdgeInsets.all(5),
                decoration: const BoxDecoration(color: Color(0xFF034F96)),

                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: ConstrainedBox(
                            constraints: BoxConstraints(
                              minWidth: 10,
                              //MediaQuery.of(context).size.width,
                            ),
                            // padding: const EdgeInsets.all(20),
                            child: Text(
                              'My Stakes',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: SizeConfig.screenWidth! >= 1153
                                      ? 20
                                      : SizeConfig.screenWidth! < 1153
                                          ? 20
                                          : SizeConfig.screenWidth! < 999
                                              ? 17
                                              : 9,
                                  decoration: TextDecoration.none),
                              // if (SizeConfig.screenWidth! >= 1137)
                            ),
                          ),
                        )
                      ],
                    ),
                    20.height,

                    myStakeWidget(),
                    // SingleChildScrollView(
                    //     scrollDirection: Axis.horizontal,
                    //     child: Column(
                    //       children: [
                    //         ...List.generate(3, (index) => myStakeWidget())
                    //       ],
                    //     )),
                  ],
                ),
              )),
          // if (SizeConfig.screenWidth! >= 1838)
          Expanded(
            flex: 4,
            child: Container(
              padding: const EdgeInsets.only(left: 20, right: 20),
              height: MediaQuery.of(context).size.height,
              decoration: const BoxDecoration(
                color: Color(0xFF034F96),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    height: 120,
                    //  padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      //borderRadius: BorderRadius.all(radiusCircular(8)),
                      color: Color.fromARGB(255, 2, 53, 100),
                      border: Border(bottom: BorderSide(color: Colors.white)),
                    ),
                    child: Column(
                      children: [
                        8.height,
                        Row(
                          children: [
                            Container(
                              padding: EdgeInsets.symmetric(
                                horizontal: 20,
                              ),

                              ///   margin: const EdgeInsets.only(bottom: 65),
                              child: const Text(
                                'History',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 23,
                                    decoration: TextDecoration.none),
                              ),
                            )
                          ],
                        ),
                        if (SizeConfig.screenWidth! >= 1160)
                          Row(
                            children: [
                              // Container(
                              //   margin: const EdgeInsets.only(bottom: 40),
                              //   child: Row(
                              //       children: List.generate(
                              //     2,
                              //     (index) => Row(
                              //       children: [
                              //         dateContainer(
                              //           name: names[index],
                              //         ),
                              //         const SizedBox(
                              //             width:
                              //                 16.0), // Adjust the width as needed
                              //       ],
                              //     ),
                              //   )),
                              // ),
                              const Spacer(flex: 1),
                              Consumer<SocketProvider>(
                                builder: (BuildContext context, provider, _) {
                                  return provider.gameHistory.isEmpty
                                      ? Column(
                                          children: [
                                            Lottie.asset(
                                              "assets/images/beiLoader.json",
                                              height: 80,
                                              width: 80,
                                            ),
                                          ],
                                        )
                                      : Column(
                                          children: [
                                            // Container(
                                            //   alignment: AlignmentDirectional.centerEnd,
                                            //   width: 550,
                                            //   child: Icon(Icons.arrow_back),
                                            // ),
                                            Container(
                                              padding: EdgeInsets.symmetric(
                                                  horizontal: 20),
                                              child: Row(
                                                children: List.generate(
                                                  provider.gameHistory.length,
                                                  (index) => resultContainer(
                                                    colorImg: true,
                                                    color: provider
                                                                .gameHistory[index]
                                                                    ["race"]
                                                                .toLowerCase() ==
                                                            "g"
                                                        ? ColorConfig.greenCar
                                                            .withOpacity(0.8)
                                                        : provider.gameHistory[index]
                                                                        ["race"]
                                                                    .toLowerCase() ==
                                                                "y"
                                                            ? ColorConfig
                                                                .yellowCar
                                                            : provider.gameHistory[index]["race"]
                                                                        .toLowerCase() ==
                                                                    'r'
                                                                ? ColorConfig
                                                                    .redCar
                                                                    .withOpacity(
                                                                        0.9)
                                                                : ColorConfig
                                                                    .blueCar
                                                                    .withOpacity(
                                                                        0.8),
                                                    img:
                                                        "assets/images/tesla.png",
                                                    height: 50,
                                                    width: 50,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        );
                                },
                              ),
                            ],
                          ),
                        if (SizeConfig.screenWidth! < 1160)
                          Container(
                            margin: const EdgeInsets.only(bottom: 40),
                            child: SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: Wrap(
                                children: List.generate(
                                  3,
                                  (index) => Row(
                                    children: [
                                      dateContainer(
                                        name: names[index],
                                      ),
                                      const SizedBox(
                                        width:
                                            16.0, // Adjust the width as needed
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        if (SizeConfig.screenWidth! < 1160)
                          Row(
                            children: [
                              Container(
                                margin: const EdgeInsets.only(bottom: 40),
                                child: Row(
                                    children: List.generate(
                                        10, (index) => const htContainer())),
                              ),
                            ],
                          )
                      ],
                    ),
                  ),
                  Expanded(child: CarTable()),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class myStakeWidget extends StatefulWidget {
  const myStakeWidget({super.key});

  @override
  State<myStakeWidget> createState() => _myStakeWidgetState();
}

class _myStakeWidgetState extends State<myStakeWidget> {
  late Future<List<RaceData>> futureData;
  late String wallet;
  late String prediction;
  late String amount;
  late String odds;
  late String side;
  late String createAt;

  @override
  void initState() {
    super.initState();
    futureData = fetchOdds();

    wallet = '';
    prediction = '';
    amount = '';
    odds = '';
    side = '';
    createAt = '';
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<RaceData>>(
      future: futureData,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
              child:
                  CircularProgressIndicator().paddingSymmetric(vertical: 300));
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        } else {
          UserWeb3Provider userWallet =
              Provider.of<UserWeb3Provider>(context, listen: false);
          //  print(userWallet.currentAddress);

          final dataList = snapshot.data!
              .where((element) =>
                  element.wallet.toLowerCase() ==
                  shortenWalletAddress(userWallet.currentAddress ?? "0xde")
                      .toLowerCase())
              .toList();

          print(dataList);
          if (dataList.isEmpty && userWallet.currentAddress == null) {
            return SingleChildScrollView(
              child: const Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Center(child: Text("Please Connect wallet")),
                ],
              ).paddingSymmetric(vertical: 300),
            );
          }
          if (dataList.isEmpty) {
            return const Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Center(child: Text("You have not made any transaction")),
              ],
            ).paddingSymmetric(vertical: 300);
          }

          return ListView.builder(
            key: const Key('uniqueKey'),
            physics: const AlwaysScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: dataList.length,
            itemBuilder: (context, index) {
              final raceData = dataList[index];
              final wallet = raceData.wallet;
              final prediction = raceData.prediction.toString();
              final amount = raceData.amount.toString();
              final odds = raceData.odds.toString();
              // final side = raceData.side.toString();
              final createAt = raceData.createdAt.toString();

              return Container(
                  width: 10,
                  padding: EdgeInsets.only(left: 10),
                  decoration: BoxDecoration(
                    color: const Color(0xFF001234),
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  margin: const EdgeInsets.only(bottom: 20.0),
                  child: ListTile(
                    title: Column(
                      children: [
                        Row(
                          children: [
                            Text("wallet address :"),
                            SizedBox(width: 10),
                            Expanded(
                              child: Text(
                                wallet,
                                overflow: TextOverflow.ellipsis,
                                textAlign: TextAlign.right,
                              ),
                            ),
                            SizedBox(width: 10),
                            Icon(Icons.wallet),
                          ],
                        ),
                        Row(
                          children: [
                            Text("prediction :"),
                            SizedBox(width: 10),
                            Expanded(
                              child: Text(
                                '$prediction',
                                overflow: TextOverflow.ellipsis,
                                textAlign: TextAlign.right,
                              ),
                            ),
                            SizedBox(width: 10),
                            Icon(Icons.gamepad),
                          ],
                        ),
                        Row(
                          children: [
                            Text("amount staked :"),
                            SizedBox(width: 10),
                            Expanded(
                              child: Text(
                                amount,
                                overflow: TextOverflow.ellipsis,
                                textAlign: TextAlign.right,
                              ),
                            ),
                            SizedBox(width: 10),
                            Icon(Icons.money),
                          ],
                        ),
                        Row(
                          children: [
                            Text("odds :"),
                            SizedBox(width: 10),
                            Expanded(
                              child: Text(
                                odds,
                                overflow: TextOverflow.ellipsis,
                                textAlign: TextAlign.right,
                              ),
                            ),
                            SizedBox(width: 10),
                            Icon(Icons.bar_chart),
                          ],
                        ),
                        Row(
                          children: [
                            Text("date :"),
                            Expanded(
                              child: Text(
                                createAt,
                                overflow: TextOverflow.ellipsis,
                                textAlign: TextAlign.right,
                              ),
                            ),
                            Icon(Icons.alarm),
                          ],
                        ),
                      ],
                    ),
                  ));
            },
          );
        }
      },
    );
  }
}

class htContainer extends StatelessWidget {
  const htContainer({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 40,
        width: 35,
        decoration: BoxDecoration(
            color: const Color(0xFF001234),
            border: Border.all(color: Colors.white)),
        child: const Center(
          child: Text(
            'H',
            style: TextStyle(fontSize: 18, color: Colors.white),
          ),
        ));
  }
}

class dateContainer extends StatelessWidget {
  const dateContainer({super.key, required this.name});
  final String name;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      height: 40,
      width: 150,
      color: Colors.white,
      child: Row(
        children: [
          Row(
            children: [
              Text(
                name,
                style: TextStyle(color: Colors.black),
              )
            ],
          ),
          const Spacer(),
          Row(
            children: [
              Icon(Icons.sort, color: Colors.black),
            ],
          )
        ],
      ),
    );
  }
}
