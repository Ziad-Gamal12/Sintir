// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:sintir/Core/entities/CourseEntities/CourseEntity.dart';
import 'package:sintir/Core/widgets/Custom%20Course%20Widgets/CourseCardMetrics.dart';
import 'package:sintir/constant.dart';
import 'package:sintir/locale_keys.dart';

class CourseItemBadge extends StatelessWidget {
  const CourseItemBadge({super.key});

  static bool isNew(CourseEntity course, {DateTime? now}) {
    if (course.id == CourseEntity.loadingId) return false;
    final age = (now ?? DateTime.now()).difference(course.postedDate);
    return age < CourseCardMetrics.newBadgeWindow;
  }

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      key: const ValueKey('course-new-badge'),
      decoration: BoxDecoration(
        color: KMainColor,
        borderRadius: BorderRadius.circular(6),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 1),
        child: Text(
          LocaleKeys.newCourseLabel,
          style: CourseCardMetrics.captionStrongStyle(context).copyWith(
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
