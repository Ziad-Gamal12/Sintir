import 'package:flutter/material.dart';
import 'package:sintir/Core/entities/CourseEntities/CourseTestItemEntities/CourseTestEntity.dart';
import 'package:sintir/Core/widgets/CustomAppBar.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/Widgets/TestConsequencesViewWidgets/TestConsequencesViewBody.dart';

class TestConsequencesView extends StatelessWidget {
  const TestConsequencesView({super.key, required this.test});
  final CourseTestEntity test;
  static const String routeName = "/TestConsequencesView";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(appBartitle: "التقارير الخاصة بالاختبار"),
      body: TestConsequencesViewBody(test: test),
    );
  }
}
