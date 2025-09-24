// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:sintir/Core/widgets/CustomAppBar.dart';
import 'package:sintir/Features/Auth/StudentPresentation/views/widgets/StudentTermsAndConditions_ViewBody.dart';

class StudenttermsandconditionsView extends StatelessWidget {
  const StudenttermsandconditionsView({super.key});

  static const String routeName = '/StudenttermsandconditionsView';
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: CustomAppBar(appBartitle: "الشروط والاحكام"),
      body: StudentTermsAndConditions_ViewBody(),
    );
  }
}
