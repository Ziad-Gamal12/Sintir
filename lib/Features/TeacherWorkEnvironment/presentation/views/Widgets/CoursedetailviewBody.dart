// ignore_for_file: camel_case_types

import 'package:flutter/material.dart';
import 'package:sintir/Core/entities/CourseEntity.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/Widgets/CustomCourseDetailsBodyCourse_Info.dart';
import 'package:sintir/constant.dart';

class CoursedetailviewBody extends StatelessWidget {
  const CoursedetailviewBody({super.key, required this.courseEntity});
  final CourseEntity courseEntity;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: KHorizontalPadding),
      child: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child:
                CustomCourseDetailsBodyCourse_Info(courseEntity: courseEntity),
          )
        ],
      ),
    );
  }
}
