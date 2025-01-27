import 'package:flutter/material.dart';
import 'package:sintir/Core/widgets/CustomAppBar.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/Widgets/AddCourseViewBody.dart';

class Addcourseview extends StatelessWidget {
  const Addcourseview({super.key});
  static const routeName = '/Addcourseview';
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: CustomAppBar(
        appBartitle: "اضافة دورة",
      ),
      body: Addcourseviewbody(),
    );
  }
}
