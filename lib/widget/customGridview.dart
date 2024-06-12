import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nb_utils/nb_utils.dart';

class CustomGridView extends StatelessWidget {
  final int itemCount;
  final int crossAxisCount;
  final double crossAxisSpacing;
  final double mainAxisSpacing;
  final IndexedWidgetBuilder itemBuilder;
  final bool useAspectRatio;
  final bool gridCount;

  CustomGridView({
    this.gridCount = false,
    required this.itemCount,
    required this.crossAxisCount,
    required this.crossAxisSpacing,
    required this.mainAxisSpacing,
    required this.itemBuilder,
    this.useAspectRatio = false,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(1.0),
      child: GridView.builder(
        physics: BouncingScrollPhysics(),
        gridDelegate: useAspectRatio
            ? SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: crossAxisCount,
                crossAxisSpacing: crossAxisSpacing,
                mainAxisSpacing: mainAxisSpacing,
                childAspectRatio: 2.7)
            : SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: crossAxisCount,
                crossAxisSpacing: crossAxisSpacing,
                mainAxisSpacing: mainAxisSpacing,
              ),
        itemCount: itemCount,
        itemBuilder: itemBuilder,
      ),
    ).paddingTop(useAspectRatio ? 0 : 10.h);
  }
}

class CustomGridCount extends StatelessWidget {
  final List<Widget> children;

  CustomGridCount({
    required this.children,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(1.0),
      child: GridView.count(
        crossAxisCount: 2,
        children: children,
      ),
    ).paddingTop(10.h);
  }
}
