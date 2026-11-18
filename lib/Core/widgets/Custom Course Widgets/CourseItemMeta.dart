// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:sintir/Core/entities/CourseEntities/CourseEntity.dart';
import 'package:sintir/Core/utils/locale_formatter.dart';
import 'package:sintir/Core/widgets/Custom%20Course%20Widgets/CourseCardMetrics.dart';
import 'package:sintir/Core/widgets/Rating/StarRatingDisplay.dart';
import 'package:sintir/locale_keys.dart';

class CourseItemMeta extends StatelessWidget {
  const CourseItemMeta({super.key, required this.course});

  final CourseEntity course;

  static bool showsStudents(CourseEntity course) =>
      course.studentsCount >= CourseCardMetrics.minStudentsToShow;

  @override
  Widget build(BuildContext context) {
    final locale = Localizations.localeOf(context).languageCode;
    final stats = course.ratingStats;
    final spans = <InlineSpan>[];
    final semantics = <String>[];

    if (stats.hasRatings) {
      final average = stats.average.toStringAsFixed(1);
      spans
        ..add(
          const WidgetSpan(
            alignment: PlaceholderAlignment.middle,
            child: Padding(
              padding: EdgeInsetsDirectional.only(end: 3),
              child: Icon(
                Icons.star_rounded,
                size: 14,
                color: StarRatingDisplay.starColor,
              ),
            ),
          ),
        )
        ..add(
          TextSpan(
            text: average,
            style: CourseCardMetrics.captionStrongStyle(context).copyWith(
              color: CourseCardMetrics.textColor(context),
            ),
          ),
        )
        ..add(
          TextSpan(
            text: ' (${LocaleFormatter.number(stats.ratingsCount, locale)})',
          ),
        );
      semantics
        ..add(LocaleKeys.ratingOutOfFive(average))
        ..add(LocaleKeys.ratingsCount(stats.ratingsCount, locale));
    }

    String? secondary;
    if (showsStudents(course)) {
      secondary = LocaleKeys.courseStudentsCount(course.studentsCount, locale);
    } else if (!stats.hasRatings && course.lessonsCount > 0) {
      secondary = LocaleKeys.courseLessonsCount(course.lessonsCount, locale);
    }
    if (secondary != null) {
      if (spans.isNotEmpty) spans.add(const TextSpan(text: '  ·  '));
      spans.add(TextSpan(text: secondary));
      semantics.add(secondary);
    }

    if (spans.isEmpty) return const SizedBox.shrink();

    return Text.rich(
      TextSpan(children: spans),
      key: const ValueKey('course-card-meta'),
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
      semanticsLabel: semantics.join('، '),
      style: CourseCardMetrics.captionStyle(context).copyWith(
        color: CourseCardMetrics.mutedColor(context),
      ),
    );
  }
}
