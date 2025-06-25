import 'package:flutter/material.dart';
import 'package:sintir/constant.dart';

class CustomAiTeacherBodyColourfulBackground extends StatelessWidget {
  CustomAiTeacherBodyColourfulBackground({
    super.key,
  });

  List<Color> backGroundColors = [
    KMainColor,
    Colors.blue,
    Colors.blueAccent,
    Colors.lightBlue,
    Colors.cyan,
    Colors.cyanAccent,
  ];
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: backGroundColors)),
    );
  }
}
