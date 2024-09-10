// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:sintir/Features/StudentOnboarding/Presentation/Views/widgets/CustomAppBar.dart';
import 'package:sintir/Features/StudentOnboarding/Presentation/Views/widgets/StudentBodyLoginPage.dart';

class StudentLoginPage extends StatelessWidget {
  static const String routeName = "/StudentLoginPage";
  const StudentLoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: ListView(
      children: [
        const CustomAppBar(title: 'تسجيل الدخول',),
        Studentbodyloginpage(),
      ],
    ));
  }
}
