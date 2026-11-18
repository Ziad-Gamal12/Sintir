import 'package:flutter/material.dart';
import 'package:sintir/Core/entities/CourseEntities/CourseEntity.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/Widgets/TeacherWorkenvironmentviewWidgets/TeacherCourseCard/utils/teacher_course_card_data.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/Widgets/TeacherWorkenvironmentviewWidgets/TeacherCourseCard/utils/teacher_course_card_metrics.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/Widgets/TeacherWorkenvironmentviewWidgets/TeacherCourseCard/widgets/body/teacher_course_card_body.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/Widgets/TeacherWorkenvironmentviewWidgets/TeacherCourseCard/widgets/poster/teacher_course_card_poster.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/Widgets/TeacherWorkenvironmentviewWidgets/TeacherCourseCard/widgets/teacher_course_card_shell.dart';

/// Course tile in the teacher work environment grid.
///
/// Size it with [TeacherCourseCardMetrics.heightForWidth]; the loading state
/// is `TeacherCourseCardSkeleton`.
class TeacherCourseCard extends StatelessWidget {
  const TeacherCourseCard({
    super.key,
    required this.course,
    required this.onTap,
  });

  final CourseEntity course;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final data = TeacherCourseCardData.fromCourse(context, course);

    return MediaQuery.withClampedTextScaling(
      maxScaleFactor: TeacherCourseCardMetrics.maxTextScale,
      child: Semantics(
        button: true,
        label: data.semanticsLabel,
        onTap: onTap,
        excludeSemantics: true,
        child: TeacherCourseCardShell(
          onTap: onTap,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TeacherCourseCardPoster(data: data),
              Expanded(child: TeacherCourseCardBody(data: data)),
            ],
          ),
        ),
      ),
    );
  }
}
