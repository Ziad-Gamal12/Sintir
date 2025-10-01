import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:sintir/constant.dart';

class StudentOnboardingButtonIcon extends StatelessWidget {
  const StudentOnboardingButtonIcon({super.key});

  @override
  Widget build(BuildContext context) {
    return const CircleAvatar(
      backgroundColor: KMainColor,
      radius: 35,
      child: Padding(
        padding: EdgeInsets.all(2),
        child: Icon(
          FontAwesomeIcons.arrowLeft,
          color: Colors.white,
          size: 30,
        ),
      ),
    );
  }
}
