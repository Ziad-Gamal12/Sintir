import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sintir/Core/entities/CourseEntity.dart';
import 'package:sintir/Core/widgets/CustomAppBar.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/Widgets/TeacherWorkenvironmentviewBody.dart';

class TeacherWorkenvironmentview extends StatelessWidget {
  const TeacherWorkenvironmentview({super.key, required this.myCourses});
  static const routeName = '/TeacherWorkenvironmentview';
  final List<CourseEntity> myCourses;
  @override
  Widget build(BuildContext context) {
    return Provider.value(
      value: myCourses,
      child: const Scaffold(
        appBar: CustomAppBar(appBartitle: "بيئة العمل"),
        body: TeacherWorkenvironmentviewBody(),
      ),
    );
  }
}
