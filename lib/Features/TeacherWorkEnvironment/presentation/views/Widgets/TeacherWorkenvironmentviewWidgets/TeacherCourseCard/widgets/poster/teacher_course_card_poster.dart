import 'package:flutter/material.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/Widgets/TeacherWorkenvironmentviewWidgets/TeacherCourseCard/utils/teacher_course_card_data.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/Widgets/TeacherWorkenvironmentviewWidgets/TeacherCourseCard/utils/teacher_course_card_metrics.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/Widgets/TeacherWorkenvironmentviewWidgets/TeacherCourseCard/widgets/poster/teacher_course_poster_image.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/Widgets/TeacherWorkenvironmentviewWidgets/TeacherCourseCard/widgets/poster/teacher_course_status_badge.dart';

/// 16:9 poster with the status badge pinned to its top-end corner.
class TeacherCourseCardPoster extends StatelessWidget {
  const TeacherCourseCardPoster({super.key, required this.data});

  final TeacherCourseCardData data;

  @override
  Widget build(BuildContext context) {
    const inset = TeacherCourseCardMetrics.posterOverlayInset;

    return AspectRatio(
      aspectRatio: TeacherCourseCardMetrics.posterAspectRatio,
      child: Stack(
        fit: StackFit.expand,
        children: [
          TeacherCoursePosterImage(posterUrl: data.posterUrl),
          if (data.hasStatus)
            PositionedDirectional(
              top: inset,
              start: inset,
              end: inset,
              child: Align(
                alignment: AlignmentDirectional.topEnd,
                child: TeacherCourseStatusBadge(
                  status: data.status,
                  label: data.statusLabel,
                ),
              ),
            ),
        ],
      ),
    );
  }
}
