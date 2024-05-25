import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:provider/provider.dart';
import 'package:smartbet/screens/history/components/details.dart';
import 'package:smartbet/screens/history/components/historyTable.dart';
import 'package:smartbet/socket/provider.dart';
import 'package:smartbet/utils/config/color.dart';
import 'package:smartbet/widget/customAppBar.dart';
import 'package:smartbet/widget/resultWidget.dart';

class CarHistory extends StatefulWidget {
  // const CarHistory({Key? key}) : super(key: key);
  const CarHistory({super.key, this.directLaunch = false});
  final bool directLaunch;

  @override
  State<CarHistory> createState() => _CarHistoryState();
}

List names = ["18/20 - 2010", "Game Type", 'Status'];

class _CarHistoryState extends State<CarHistory> {
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
                    child: Container(child: Text('data')),
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
    return SizedBox(
      width: double.infinity,
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
                  const Expanded(child: CoinTable()),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class myStakeWidget extends StatelessWidget {
  const myStakeWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 140,
      width: 280,
      decoration: BoxDecoration(
          color: ColorConfig.scaffold, borderRadius: BorderRadius.circular(10)),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Row(
              children: [
                Text("wallet address :"),
                Container().expand(),
                Container(
                  width: 130,
                  child: Text(
                    '0x6c6d8fefd85487a514b376a722570fcdfac511ff',
                    overflow:
                        TextOverflow.ellipsis, // Adding ellipsis for overflow
                    //   Maximum number of lines to display before showing ellipsis
                    textAlign: TextAlign.center, // Aligning text to center
                    // style: TextStyle(
                    //     fontSize: 10), // Setting font size
                  ),
                ),
                Container().expand(),
                Icon(Icons.wallet)
              ],
            ),
            Row(
              children: [
                Text("prediction :"),
                Container().expand(),
                Text(
                  'blue',
                  overflow:
                      TextOverflow.ellipsis, // Adding ellipsis for overflow
                  //   Maximum number of lines to display before showing ellipsis
                  textAlign: TextAlign.center, // Aligning text to center
                  // style: TextStyle(
                  //     fontSize: 10), // Setting font size
                ),
                3.width,
                Icon(Icons.gamepad)
              ],
            ),
            Row(
              children: [
                Text("amonunt staked :"),
                Container().expand(),
                Text(
                  '0.0011576',
                  overflow:
                      TextOverflow.ellipsis, // Adding ellipsis for overflow
                  //   Maximum number of lines to display before showing ellipsis
                  textAlign: TextAlign.center, // Aligning text to center
                  // style: TextStyle(
                  //     fontSize: 10), // Setting font size
                ),
                3.width,
                Icon(Icons.money)
              ],
            ),
            Row(
              children: [
                Text("odds :"),
                Container().expand(),
                Text(
                  '4x',
                  overflow:
                      TextOverflow.ellipsis, // Adding ellipsis for overflow
                  //   Maximum number of lines to display before showing ellipsis
                  textAlign: TextAlign.center, // Aligning text to center
                  // style: TextStyle(
                  //     fontSize: 10), // Setting font size
                ),
                3.width,
                Icon(Icons.bar_chart)
              ],
            ),
            Row(
              children: [
                Text("date :"),
                Container().expand(),
                Text(
                  '2024-03-10 06:44:53 PM',
                  overflow:
                      TextOverflow.ellipsis, // Adding ellipsis for overflow
                  //   Maximum number of lines to display before showing ellipsis
                  textAlign: TextAlign.center, // Aligning text to center
                  // style: TextStyle(
                  //     fontSize: 10), // Setting font size
                ),
                3.width,
                Icon(Icons.alarm)
              ],
            )
          ],
        ),
      ),
    ).paddingBottom(10);
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
