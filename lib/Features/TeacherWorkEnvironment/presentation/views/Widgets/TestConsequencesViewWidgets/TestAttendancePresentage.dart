import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:sintir/constant.dart';

class TestAttendancePresentage extends StatelessWidget {
  const TestAttendancePresentage({super.key});

  @override
  Widget build(BuildContext context) {
    return CircularPercentIndicator(
      radius: 50,
      lineWidth: 13.0,
      animation: true,
      percent: 0.6,
      center: const Text(
        "60%",
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0),
      ),
      progressColor: KMainColor,
      circularStrokeCap: CircularStrokeCap.round,
    );
  }
}
