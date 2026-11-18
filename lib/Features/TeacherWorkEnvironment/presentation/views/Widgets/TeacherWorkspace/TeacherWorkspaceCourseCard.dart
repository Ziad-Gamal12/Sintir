// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:sintir/Core/entities/CourseEntities/CourseEntity.dart';
import 'package:sintir/Core/utils/locale_formatter.dart';
import 'package:sintir/Core/widgets/Custom%20Course%20Widgets/CourseCardMetrics.dart';
import 'package:sintir/Core/widgets/Custom%20Course%20Widgets/CourseItemImage.dart';
import 'package:sintir/Core/widgets/Custom%20Course%20Widgets/CourseItemPrice.dart';
import 'package:sintir/Core/widgets/Custom%20Course%20Widgets/CourseItemTitleBlock.dart';
import 'package:sintir/Core/widgets/Rating/StarRatingDisplay.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/domain/Entities/TeacherCourseState.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/Widgets/TeacherWorkspace/TeacherCourseStateStyle.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/Widgets/TeacherWorkspace/TeacherWorkspaceCourseCardMetrics.dart';
import 'package:sintir/constant.dart';
import 'package:sintir/locale_keys.dart';

class TeacherWorkspaceCourseCard extends StatelessWidget {
  const TeacherWorkspaceCourseCard({
    super.key,
    required this.course,
    required this.onTap,
    this.openReports = 0,
  });

  final CourseEntity course;
  final VoidCallback onTap;
  final int openReports;

  static bool needsContent(CourseEntity course) {
    final state = TeacherCourseState.fromRaw(course.state);
    return state != TeacherCourseState.published &&
        course.lessonsCount == 0 &&
        course.testsCount == 0;
  }

  @override
  Widget build(BuildContext context) {
    final borderRadius = BorderRadius.circular(CourseCardMetrics.radius);
    final state = TeacherCourseState.fromRaw(course.state);

    return MediaQuery.withClampedTextScaling(
      maxScaleFactor: CourseCardMetrics.maxTextScale,
      child: DecoratedBox(
        decoration: BoxDecoration(
          borderRadius: borderRadius,
          boxShadow: CourseCardMetrics.shadow(context),
        ),
        child: Material(
          color: CourseCardMetrics.surfaceColor(context),
          clipBehavior: Clip.antiAlias,
          shape: RoundedRectangleBorder(
            borderRadius: borderRadius,
            side: BorderSide(color: CourseCardMetrics.borderColor(context)),
          ),
          child: InkWell(
            onTap: onTap,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                AspectRatio(
                  aspectRatio: CourseCardMetrics.imageAspectRatio,
                  child: Stack(
                    fit: StackFit.expand,
                    children: [
                      CourseItemImage(imageUrl: course.posterUrl ?? ''),
                      PositionedDirectional(
                        top: 8,
                        start: 8,
                        end: 8,
                        child: Wrap(
                          spacing: 6,
                          runSpacing: 6,
                          children: [
                            if (openReports > 0)
                              _ReportsPill(count: openReports),
                            if (state != TeacherCourseState.published)
                              TeacherCourseStatePill(
                                state: state,
                                textStyle: CourseCardMetrics.captionStrongStyle(
                                  context,
                                ),
                              ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: CourseCardMetrics.detailsPadding,
                    child: _CardDetails(course: course, onTap: onTap),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _CardDetails extends StatelessWidget {
  const _CardDetails({required this.course, required this.onTap});

  final CourseEntity course;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        SizedBox(
          height: CourseCardMetrics.titleBlockHeight(context),
          child: CourseItemTitleBlock(title: course.title),
        ),
        const SizedBox(height: CourseCardMetrics.rowGap),
        SizedBox(
          height: CourseCardMetrics.metaHeight(context),
          child: _TeacherCourseMeta(course: course),
        ),
        const SizedBox(height: CourseCardMetrics.rowGap),
        SizedBox(
          height: TeacherWorkspaceCourseCardMetrics.contentLineHeight(context),
          child: _ContentLine(course: course),
        ),
        const Spacer(),
        SizedBox(
          height: TeacherWorkspaceCourseCardMetrics.bottomHeight(context),
          child: TeacherWorkspaceCourseCard.needsContent(course)
              ? _AddContentButton(onPressed: onTap)
              : Align(
                  alignment: AlignmentDirectional.bottomStart,
                  child: CourseItemPrice(price: course.price),
                ),
        ),
      ],
    );
  }
}

class _TeacherCourseMeta extends StatelessWidget {
  const _TeacherCourseMeta({required this.course});

  final CourseEntity course;

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
            style: CourseCardMetrics.captionStrongStyle(
              context,
            ).copyWith(color: CourseCardMetrics.textColor(context)),
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

    final state = TeacherCourseState.fromRaw(course.state);
    if (state.isLive || course.studentsCount > 0) {
      final students = LocaleKeys.courseStudentsCount(
        course.studentsCount,
        locale,
      );
      if (spans.isNotEmpty) spans.add(const TextSpan(text: '  ·  '));
      spans.add(TextSpan(text: students));
      semantics.add(students);
    }

    if (spans.isEmpty) return const SizedBox.shrink();
    return Text.rich(
      TextSpan(children: spans),
      key: const ValueKey('teacher-course-meta'),
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
      semanticsLabel: semantics.join('، '),
      style: CourseCardMetrics.captionStyle(
        context,
      ).copyWith(color: CourseCardMetrics.mutedColor(context)),
    );
  }
}

class _ContentLine extends StatelessWidget {
  const _ContentLine({required this.course});

  final CourseEntity course;

  @override
  Widget build(BuildContext context) {
    final locale = Localizations.localeOf(context).languageCode;
    final muted = CourseCardMetrics.mutedColor(context);
    final text =
        '${LocaleKeys.courseLessonsCount(course.lessonsCount, locale)}'
        '  ·  '
        '${LocaleKeys.courseTestsCount(course.testsCount, locale)}';
    return Row(
      children: [
        Icon(
          Icons.menu_book_outlined,
          size: TeacherWorkspaceCourseCardMetrics.contentIconSize,
          color: muted,
        ),
        const SizedBox(width: 4),
        Expanded(
          child: Text(
            text,
            key: const ValueKey('teacher-course-content'),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: CourseCardMetrics.captionStyle(
              context,
            ).copyWith(color: muted),
          ),
        ),
      ],
    );
  }
}

class _AddContentButton extends StatelessWidget {
  const _AddContentButton({required this.onPressed});

  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final foreground = isDark
        ? const Color(0xFF9DB4F5)
        : const Color(0xFF2F55C8);
    return TextButton.icon(
      key: const ValueKey('teacher-course-add-content'),
      onPressed: onPressed,
      style: TextButton.styleFrom(
        backgroundColor: KMainColor.withValues(alpha: isDark ? 0.2 : 0.1),
        foregroundColor: foreground,
        minimumSize: const Size.fromHeight(
          TeacherWorkspaceCourseCardMetrics.actionHeight,
        ),
        padding: const EdgeInsets.symmetric(horizontal: 8),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
      ),
      icon: const Icon(Icons.add_rounded, size: 18),
      label: Text(
        LocaleKeys.courseAddFirstLesson,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        style: CourseCardMetrics.captionStrongStyle(
          context,
        ).copyWith(color: foreground),
      ),
    );
  }
}

class _ReportsPill extends StatelessWidget {
  const _ReportsPill({required this.count});

  final int count;

  @override
  Widget build(BuildContext context) {
    final locale = Localizations.localeOf(context).languageCode;
    return _Pill(
      key: const ValueKey('teacher-course-reports'),
      background: const Color(0xFFC62828),
      foreground: Colors.white,
      leading: const Icon(Icons.flag_rounded, size: 13, color: Colors.white),
      label: LocaleKeys.cardOpenReports(count, locale),
    );
  }
}

class _Pill extends StatelessWidget {
  const _Pill({
    super.key,
    required this.background,
    required this.foreground,
    required this.leading,
    required this.label,
  });

  final Color background;
  final Color foreground;
  final Widget leading;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
      decoration: BoxDecoration(
        color: background,
        borderRadius: BorderRadius.circular(999),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          leading,
          const SizedBox(width: 5),
          Flexible(
            child: Text(
              label,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: CourseCardMetrics.captionStrongStyle(
                context,
              ).copyWith(color: foreground),
            ),
          ),
        ],
      ),
    );
  }
}
