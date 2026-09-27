import 'package:flutter/material.dart';
import 'package:sintir/Core/entities/CourseEntities/CourseEntity.dart';
import 'package:sintir/Core/utils/textStyles.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/Widgets/CourseDetailViewWidgets/course_instructor_avatar.dart';
import 'package:sintir/locale_keys.dart';

class CourseDetailSummary extends StatelessWidget {
  const CourseDetailSummary({super.key, required this.course});

  final CourseEntity course;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textStyles = AppTextStyles(context);
    final instructorName = course.contentcreaterentity?.name;

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: theme.colorScheme.surfaceContainerHighest.withValues(alpha: .55),
        borderRadius: BorderRadius.circular(18),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.bookmark_border, color: theme.colorScheme.primary),
              const SizedBox(width: 10),
              Expanded(
                child: Text(
                  course.title,
                  style: textStyles.semiBold16.copyWith(
                    color: theme.textTheme.titleMedium?.color,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
          if (course.description.isNotEmpty) ...[
            const SizedBox(height: 8),
            Text(
              course.description,
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
              style: textStyles.regular13.copyWith(
                color: theme.textTheme.bodyMedium?.color,
              ),
            ),
          ],
          if (instructorName != null && instructorName.isNotEmpty) ...[
            const SizedBox(height: 12),
            _InstructorInfo(course: course, name: instructorName),
          ],
        ],
      ),
    );
  }
}

class _InstructorInfo extends StatelessWidget {
  const _InstructorInfo({required this.course, required this.name});

  final CourseEntity course;
  final String name;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textStyles = AppTextStyles(context);

    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: theme.colorScheme.surface.withValues(alpha: .8),
        borderRadius: BorderRadius.circular(14),
      ),
      child: Row(
        children: [
          CourseInstructorAvatar(course: course),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  LocaleKeys.courseInstructor,
                  style: textStyles.regular11.copyWith(
                    color: theme.textTheme.bodySmall?.color,
                  ),
                ),
                Text(
                  name,
                  style: textStyles.semiBold14.copyWith(
                    color: theme.textTheme.titleMedium?.color,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
