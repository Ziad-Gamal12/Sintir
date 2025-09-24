// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:sintir/Core/widgets/CustomAppBar.dart';
import 'package:sintir/Features/Auth/TeacherPresentation/views/widgets/TeachertermsandconditionsviewBody.dart';

class Teachertermsandconditionsview extends StatelessWidget {
  const Teachertermsandconditionsview({super.key});
  static const String routeName = "/Teachertermsandconditionsview";
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: CustomAppBar(appBartitle: "الشروط والاحكام"),
      body: TeachertermsandconditionsviewBody(),
    );
  }
}
