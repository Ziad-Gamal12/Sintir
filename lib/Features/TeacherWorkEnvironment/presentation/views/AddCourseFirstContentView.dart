import 'package:flutter/material.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/Widgets/AddCourseFirstContentBody.dart';

class Addcoursefirstcontentview extends StatelessWidget {
  const Addcoursefirstcontentview({super.key});
  static const routeName = '/Addcoursefirstcontentview';
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SafeArea(child: AddCourseFirstContentBody()),
    );
  }
}
