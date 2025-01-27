import 'package:flutter/material.dart';
import 'package:sintir/Core/widgets/CustomAppBar.dart';
import 'package:sintir/Features/StudentProfile/presentation/views/widgets/StudentprofileviewBody.dart';

class Studentprofileview extends StatelessWidget {
  const Studentprofileview({super.key});
  static const routeName = '/Studentprofileview';
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: CustomAppBar(appBartitle: "الملف الشخصى"),
      body: StudentprofileviewBody(),
    );
  }
}
