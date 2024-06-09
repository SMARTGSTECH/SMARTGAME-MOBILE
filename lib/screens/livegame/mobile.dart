import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:provider/provider.dart';
import 'package:smartbet/screens/livegame/provider.dart';
import 'package:smartbet/utils/config/color.dart';
import 'package:smartbet/widget/comingSoon.dart';
import 'package:smartbet/widget/customGridview.dart';
import 'package:smartbet/widget/quadContainer.dart';

class LiveGameMobileScreen extends StatefulWidget {
  const LiveGameMobileScreen({super.key});

  @override
  State<LiveGameMobileScreen> createState() => _LiveGameMobileScreenState();
}

class _LiveGameMobileScreenState extends State<LiveGameMobileScreen> {
  @override
  Widget build(BuildContext context) {
    return Consumer<LiveEventProvider>(
      builder: (BuildContext context, model, _) {
        return Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(11.0),
              child: Column(
                children: [
                  Container(
                    padding: EdgeInsetsDirectional.all(4),
                    height: 40.h,
                    width: 340.w,
                    decoration: BoxDecoration(
                        color: ColorConfig.appBar,
                        borderRadius: BorderRadius.circular(10)),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        ...List.generate(
                            model.tabItemHeader.length,
                            (index) => TabCard(
                                  isActive:
                                      model.selectedTab == index ? true : false,
                                  title: model.tabItemHeader[index],
                                  action: () {
                                    index == 2
                                        ? toast("COMING SOON",
                                            bgColor: ColorConfig.yellow)
                                        : model.toggleTab(index);
                                  },
                                )),
                      ],
                    ),
                  ),
                  QuadrantBox(),
                  CustomGridView(
                    itemCount: 20,
                    crossAxisCount: 3,
                    crossAxisSpacing: 10.0,
                    mainAxisSpacing: 10.0,
                    itemBuilder: (context, index) {
                      return Container(
                        alignment: Alignment.center,
                        color: Colors.blue[100 * ((index % 8) + 1)],
                        child: Text('Item $index'),
                      );
                    },
                  ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }
}

class TabCard extends StatelessWidget {
  final Function()? action;
  final bool isActive;
  final String title;
  const TabCard(
      {super.key, this.action, required this.isActive, required this.title});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: action,
        child: Container(
          height: 35.h,
          decoration: BoxDecoration(
              color: isActive ? ColorConfig.yellow : Colors.transparent,
              borderRadius: BorderRadius.circular(10)),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                textAlign: TextAlign.center,
                title,
                style: TextStyle(
                    color: isActive ? Colors.black : Colors.white,
                    fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
