import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:sintir/Core/entities/CourseEntities/CourseTestItemEntities/CourseTestViewNavigationsRequirmentsEntity.dart';
import 'package:sintir/Core/widgets/CustomButton.dart';
import 'package:sintir/Features/Course%20Management%20and%20Interaction%20Feature/presentation/views/courseTestView.dart';

class CourseTestOverViewBodyJoinExamButton extends StatelessWidget {
  const CourseTestOverViewBodyJoinExamButton({
    super.key,
    required this.courseExamViewNavigationsRequirmentsEntity,
  });

  final CourseExamViewNavigationsRequirmentsEntity
      courseExamViewNavigationsRequirmentsEntity;

  @override
  Widget build(BuildContext context) {
    return Custombutton(
        text: "بدأ الأختبار",
        color: Colors.red,
        textColor: Colors.white,
        onPressed: () {
          GoRouter.of(context).push(
            Coursetestview.routename,
            extra: courseExamViewNavigationsRequirmentsEntity,
          );
        });
  }
}
