// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';

class CustomAiTeacherBodyColourfulBackground extends StatelessWidget {
  CustomAiTeacherBodyColourfulBackground({
    super.key,
  });

  List<Color> backGroundColors = [
    const Color(0xFF0F2027),
    const Color(0xFF203A43),
    const Color(0xFF2C5364),
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
