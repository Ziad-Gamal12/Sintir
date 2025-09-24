// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:sintir/Features/StudentOnboarding/Presentation/Views/widgets/StudentOnboardingViewBody.dart';

class StudentOnboardingView extends StatelessWidget {
  static const routeName = '/student-onboarding';

  const StudentOnboardingView({super.key});
  @override
  Widget build(BuildContext context) {
    return const Scaffold(body: SafeArea(child: StudentOnboardingViewBody()));
  }
}
