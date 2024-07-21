import 'package:flutter/material.dart';
import 'package:sintir/Features/Splash/presentation/Views/Widgets/Splashview_body.dart';
import 'package:sintir/constant.dart';

class Splashview extends StatelessWidget {
  const Splashview({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: KMainColor,
      body: SafeArea(child: Splashview_body()),
    );
  }
}
