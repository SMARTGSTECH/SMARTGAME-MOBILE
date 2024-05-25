import 'package:flutter/material.dart';
import 'package:smartbet/widget/comingSoon.dart';

class FootBallMobileScreen extends StatefulWidget {
  const FootBallMobileScreen({super.key});

  @override
  State<FootBallMobileScreen> createState() => _FootBallMobileScreenState();
}

class _FootBallMobileScreenState extends State<FootBallMobileScreen> {
  @override
  Widget build(BuildContext context) {
    return comingSoon();
  }
}
