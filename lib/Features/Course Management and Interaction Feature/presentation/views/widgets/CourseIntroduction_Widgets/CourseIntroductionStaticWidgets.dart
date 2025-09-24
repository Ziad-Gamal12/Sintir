import 'package:flutter/material.dart';
import 'package:sintir/Features/Course%20Management%20and%20Interaction%20Feature/presentation/views/widgets/CourseIntroduction_Widgets/CustomCourseIntroductionViewBodyHeader.dart';
import 'package:sintir/Features/Course%20Management%20and%20Interaction%20Feature/presentation/views/widgets/CourseIntroduction_Widgets/courseIntroductionViewBodyListViewHeader.dart';

class CourseIntroductionStaticHeader extends StatelessWidget {
  const CourseIntroductionStaticHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return const CustomCourseIntroductionViewBodyHeader();
  }
}

class CourseIntroductionStaticListViewHeader extends StatelessWidget {
  const CourseIntroductionStaticListViewHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return const courseIntroductionViewBodyListViewHeader();
  }
}
