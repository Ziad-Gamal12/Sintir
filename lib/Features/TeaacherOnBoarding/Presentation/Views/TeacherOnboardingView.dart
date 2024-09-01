// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:sintir/Features/TeaacherOnBoarding/Presentation/Views/Widgets/TeacherOnboardingViewBody.dart';

class TeacherOnboardingView extends StatelessWidget {
  const TeacherOnboardingView({super.key});
  static const String routeName = "/TeacherOnboardingView";

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SafeArea(child: TeacherOnboardingViewBody()),
    );
  }
}
