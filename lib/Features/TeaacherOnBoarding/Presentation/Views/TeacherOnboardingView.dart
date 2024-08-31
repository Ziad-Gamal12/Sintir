import 'package:flutter/material.dart';
import 'package:sintir/Features/TeaacherOnBoarding/Presentation/Views/Widgets/TeacherOnboardingViewBody.dart';

class TeacherOnboardingView extends StatelessWidget {
  const TeacherOnboardingView({super.key});
  static const String routeName = "/TeacherOnboardingView";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(child: TeacherOnboardingViewBody()),
    );
  }
}
