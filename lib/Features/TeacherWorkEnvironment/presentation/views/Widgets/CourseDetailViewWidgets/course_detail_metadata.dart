import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:sintir/Core/utils/textStyles.dart';
import 'package:sintir/Core/entities/CourseEntities/CourseEntity.dart';
import 'package:sintir/locale_keys.dart';

class CourseDetailMetadata extends StatelessWidget {
  const CourseDetailMetadata({super.key, required this.course});
  final CourseEntity course;

  static const double _spacing = 10;
  static const double _minCardWidth = 200;

  @override
  Widget build(BuildContext context) {
    final locale = Localizations.localeOf(context).toLanguageTag();
    final date = DateFormat.yMMMMd(locale).format(course.postedDate);
    final items = [
      _MetadataItem(Icons.translate, LocaleKeys.language, course.language),
      _MetadataItem(
        Icons.menu_book_outlined,
        LocaleKeys.studentEducationLevel,
        course.level,
      ),
      _MetadataItem(
        Icons.workspace_premium_outlined,
        LocaleKeys.teacherSubject,
        course.subject,
      ),
      _MetadataItem(
        Icons.calendar_month_outlined,
        LocaleKeys.createdDate,
        date,
      ),
    ];
    return LayoutBuilder(
      builder: (context, constraints) {
        final columns =
            (constraints.maxWidth - _spacing * 3) / 4 >= _minCardWidth ? 4 : 2;
        return Column(
          children: [
            for (var start = 0; start < items.length; start += columns) ...[
              if (start > 0) const SizedBox(height: _spacing),
              IntrinsicHeight(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    for (var index = start; index < start + columns; index++) ...[
                      if (index > start) const SizedBox(width: _spacing),
                      Expanded(
                        child: index < items.length
                            ? _MetadataCard(item: items[index])
                            : const SizedBox.shrink(),
                      ),
                    ],
                  ],
                ),
              ),
            ],
          ],
        );
      },
    );
  }
}

class _MetadataItem {
  const _MetadataItem(this.icon, this.label, this.value);
  final IconData icon;
  final String label, value;
}

class _MetadataCard extends StatelessWidget {
  const _MetadataCard({required this.item});
  final _MetadataItem item;
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textStyles = AppTextStyles(context);
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      decoration: BoxDecoration(
        color: theme.colorScheme.surfaceContainerHighest.withValues(alpha: .55),
        borderRadius: BorderRadius.circular(15),
      ),
      child: Row(
        children: [
          CircleAvatar(
            radius: 17,
            backgroundColor: theme.colorScheme.primary.withValues(alpha: .12),
            child: Icon(item.icon, size: 18, color: theme.colorScheme.primary),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item.label,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: textStyles.regular11.copyWith(
                    color: theme.textTheme.bodySmall?.color,
                  ),
                ),
                Text(
                  item.value,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: textStyles.semiBold12.copyWith(
                    color: theme.textTheme.bodyLarge?.color,
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
