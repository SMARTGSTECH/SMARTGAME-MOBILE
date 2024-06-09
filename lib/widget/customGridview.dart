import 'package:flutter/material.dart';

class CustomGridView extends StatelessWidget {
  final int itemCount;
  final int crossAxisCount;
  final double crossAxisSpacing;
  final double mainAxisSpacing;
  final IndexedWidgetBuilder itemBuilder;

  CustomGridView({
    required this.itemCount,
    required this.crossAxisCount,
    required this.crossAxisSpacing,
    required this.mainAxisSpacing,
    required this.itemBuilder,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: crossAxisCount,
          crossAxisSpacing: crossAxisSpacing,
          mainAxisSpacing: mainAxisSpacing,
        ),
        itemCount: itemCount,
        itemBuilder: itemBuilder,
      ),
    );
  }
}
