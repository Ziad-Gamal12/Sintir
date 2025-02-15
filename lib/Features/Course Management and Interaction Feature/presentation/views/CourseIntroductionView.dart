// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sintir/Core/entities/CourseEntity.dart';
import 'package:sintir/Core/widgets/CustomAppBar.dart';
import 'package:sintir/Features/Course%20Management%20and%20Interaction%20Feature/presentation/views/widgets/CourseIntroduction_Widgets/CourseIntroductionViewBody.dart';

class CourseIntroductionView extends StatelessWidget {
  const CourseIntroductionView({super.key, required this.course});
  static const routeName = "/CourseIntroductionView";
  final CourseEntity course;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(appBartitle: course.title),
      body: Provider.value(
        value: course,
        child: const CourseIntroductionViewBody(),
      ),
    );
  }
}
