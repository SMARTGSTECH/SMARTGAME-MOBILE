import 'package:flutter/material.dart';
import 'package:smartbet/utils/config/config.dart';

class HomeContainer extends StatelessWidget {
  const HomeContainer({
    Key? key,
    required this.sWidthpercent,
    required this.imagepath,
    required this.name,
    required this.index,
    required this.sHeightpercent,
    this.ball = false,
    this.dice = false,
    this.coin = false,
  }) : super(key: key);

  final double sWidthpercent;
  final String imagepath;
  final String name;
  final int index;
  final double sHeightpercent;
  final ball;
  final dice;
  final coin;

  @override
  Widget build(BuildContext context) {
    if (ball) {
      return Container(
        margin: EdgeInsets.only(
            left: sWidthpercent * 2,
            right: sWidthpercent * 2,
            bottom: sWidthpercent * 5),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.white.withOpacity(0.24)),
          //border: Border.all(color: yellowborder),
          color: barcolor,
          borderRadius: BorderRadius.circular(15),
        ),
        width: double.infinity,
        height: sHeightpercent * 35,
        child: Row(
          children: [
            Container(
                //  padding: EdgeInsets.only(top: sWidthpercent * 10),
                // child: Image.asset(pitch),
                width: sWidthpercent * 50,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(15),
                        bottomLeft: Radius.circular(15)),
                    color: Color.fromARGB(247, 253, 254, 255),
                    image: DecorationImage(
                        fit: BoxFit.fill, image: AssetImage(imagepath)))),
            Expanded(
                child: Container(
              color: Colors.transparent,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    name,
                    style: TextStyle(
                        color: myiconcolor,
                        fontSize: 15,
                        fontWeight: FontWeight.bold),
                  ),
                  GestureDetector(
                    onTap: (() {
                      // Navigator.push(
                      //   context,
                      //   MaterialPageRoute(
                      //       builder: (context) => HomeScreen(
                      //             indexbar: index,
                      //           )),
                      // );
                    }),
                    // child: buton(
                    //     home: true,
                    //     sWidthpercent: sWidthpercent,
                    //     value: "Play Now",
                    //     hasSelected: false),
                  )
                ],
              ),
            ))
          ],
        ),
      );
    } else if (dice) {
      return Container(
        margin: EdgeInsets.only(
            left: sWidthpercent * 2,
            right: sWidthpercent * 2,
            bottom: sWidthpercent * 5),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.white.withOpacity(0.24)),
          //border: Border.all(color: yellowborder),
          color: barcolor,
          borderRadius: BorderRadius.circular(15),
        ),
        width: double.infinity,
        height: sHeightpercent * 35,
        child: Row(
          children: [
            Container(
                //  padding: EdgeInsets.only(top: sWidthpercent * 10),
                width: sWidthpercent * 50,
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(15),
                      bottomLeft: Radius.circular(15)),
                  color: Colors.transparent,
                  // image: DecorationImage(
                  //     fit: BoxFit.fill, image: AssetImage(pitch)
                  //     )@sixtus_eto14187
                ),
                //  padding: EdgeInsets.only(top: sWidthpercent * 10),
                child: Image.asset(imagepath)),
            Expanded(
                child: Container(
              color: Colors.transparent,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    name,
                    style: TextStyle(
                        color: myiconcolor,
                        fontSize: 15,
                        fontWeight: FontWeight.bold),
                  ),
                  GestureDetector(
                    onTap: (() {
                      // Navigator.push(
                      //   context,
                      //   MaterialPageRoute(
                      //       builder: (context) => HomeScreen(
                      //             indexbar: index,
                      //           )),
                      // );
                    }),
                    // child: buton(
                    //     home: true,
                    //     sWidthpercent: sWidthpercent,
                    //     value: "Play Now",
                    //     hasSelected: false),
                  ),
                ],
              ),
            ))
          ],
        ),
      );
    } else if (coin) {
      return Container(
        margin: EdgeInsets.only(
            left: sWidthpercent * 2,
            right: sWidthpercent * 2,
            bottom: sWidthpercent * 5),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.white.withOpacity(0.24)),
          //border: Border.all(color: yellowborder),
          color: barcolor,
          borderRadius: BorderRadius.circular(15),
        ),
        width: double.infinity,
        height: sHeightpercent * 35,
        child: Row(
          children: [
            Container(

                //  padding: EdgeInsets.only(top: sWidthpercent * 10),
                width: sWidthpercent * 50,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(15),
                      bottomLeft: Radius.circular(15)),
                  color: Colors.transparent,
                  // image: DecorationImage(
                  //     fit: BoxFit.fill, image: AssetImage(pitch)
                  //     )
                ),

                //  padding: EdgeInsets.only(top: sWidthpercent * 10),
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Image.asset(imagepath),
                )),
            Expanded(
                child: Container(
              color: Colors.transparent,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    name,
                    style: TextStyle(
                        color: myiconcolor,
                        fontSize: 15,
                        fontWeight: FontWeight.bold),
                  ),
                  GestureDetector(
                    onTap: (() {
                      // Navigator.push(
                      //   context,
                      //   MaterialPageRoute(
                      //       builder: (context) => HomeScreen(
                      //             indexbar: index,
                      //           )),
                      // );
                    }),
                    // child: buton(
                    //     home: true,
                    //     sWidthpercent: sWidthpercent,
                    //     value: "Play Now",
                    //     hasSelected: false),
                  )
                ],
              ),
            ))
          ],
        ),
      );
    } else {
      return Container();
    }
  }
}
