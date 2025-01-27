import 'package:flutter/material.dart';
import 'package:sintir/Core/widgets/CustomAppBar.dart';
import 'package:sintir/Features/TeacherProfile/presentation/views/widgets/TeacherprofileviewBody.dart';

class Teacherprofileview extends StatelessWidget {
  const Teacherprofileview({super.key});
  static String routeName = "/Teacherprofileview";
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: CustomAppBar(appBartitle: "الملف الشخصى"),
      body: TeacherprofileviewBody(),
    );
  }
}
