// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:sintir/Core/widgets/CustomAppBar.dart';
import 'package:sintir/Features/Auth/StudentPresentation/views/widgets/StudentTermsAndConditions_ViewBody.dart';
import 'package:sintir/locale_keys.dart';

class StudenttermsandconditionsView extends StatelessWidget {
  const StudenttermsandconditionsView({super.key});

  static const String routeName = '/StudenttermsandconditionsView';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(appBartitle: LocaleKeys.termsConditions),
      body: const StudentTermsAndConditions_ViewBody(),
    );
  }
}
