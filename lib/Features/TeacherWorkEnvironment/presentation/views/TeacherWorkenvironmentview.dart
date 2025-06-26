import 'package:flutter/material.dart';
import 'package:sintir/Core/entities/CourseEntities/CourseEntity.dart';
import 'package:sintir/Core/widgets/CustomAppBar.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/Widgets/TeacherWorkenvironmentviewWidgets/TeacherWorkenvironmentviewBody.dart';

class TeacherWorkenvironmentview extends StatelessWidget {
  const TeacherWorkenvironmentview({super.key, required this.myCourses});
  static const routeName = '/TeacherWorkenvironmentview';
  final List<CourseEntity> myCourses;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(appBartitle: "بيئة العمل"),
      body: TeacherWorkenvironmentviewBody(myCourses: myCourses),
    );
  }
}
