import 'package:flutter/material.dart';
import 'package:sintir/Core/widgets/CustomAppBar.dart';
import 'package:sintir/Features/TeacherProfile/presentation/views/widgets/TeacherprofileviewBody.dart';

class Teacherprofileview extends StatefulWidget {
  const Teacherprofileview({super.key});
  static String routeName = "/Teacherprofileview";

  @override
  State<Teacherprofileview> createState() => _TeacherprofileviewState();
}

class _TeacherprofileviewState extends State<Teacherprofileview> {
  @override
  void initState() {
    // context.read<UserCubit>().getUsersCourses();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(appBartitle: "الملف الشخصى"),
      body: TeacherprofileviewBody(),
    );
  }
}
