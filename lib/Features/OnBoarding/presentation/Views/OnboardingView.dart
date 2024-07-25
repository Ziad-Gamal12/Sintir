import 'package:flutter/material.dart';
import 'package:sintir/Features/OnBoarding/presentation/Views/Widgets/Onboardingview_body.dart';

class Onboardingview extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(child: Onboardingview_body()),
    );
  }
}
