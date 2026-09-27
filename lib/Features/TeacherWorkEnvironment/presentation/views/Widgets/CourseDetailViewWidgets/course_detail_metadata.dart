import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:sintir/Core/utils/textStyles.dart';
import 'package:sintir/Core/entities/CourseEntities/CourseEntity.dart';
import 'package:sintir/locale_keys.dart';

class CourseDetailMetadata extends StatelessWidget {
  const CourseDetailMetadata({super.key, required this.course});
  final CourseEntity course;
  @override
  Widget build(BuildContext context) {
    final locale = Localizations.localeOf(context).toLanguageTag();
    final date = DateFormat.yMMMMd(locale).format(course.postedDate);
    return LayoutBuilder(builder: (context, constraints) {
      final count = constraints.maxWidth > 560 ? 4 : 2;
      final width = (constraints.maxWidth - (count - 1) * 10) / count;
      final items = [
        _MetadataItem(Icons.translate, LocaleKeys.language, course.language),
        _MetadataItem(Icons.menu_book_outlined,
            LocaleKeys.studentEducationLevel, course.level),
        _MetadataItem(Icons.workspace_premium_outlined,
            LocaleKeys.teacherSubject, course.subject),
        _MetadataItem(
            Icons.calendar_month_outlined, LocaleKeys.createdDate, date),
      ];
      return Wrap(
          spacing: 10,
          runSpacing: 10,
          children: items
              .map((item) =>
                  SizedBox(width: width, child: _MetadataCard(item: item)))
              .toList());
    });
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
            color: theme.colorScheme.surfaceContainerHighest
                .withValues(alpha: .55),
            borderRadius: BorderRadius.circular(15)),
        child: Row(children: [
          CircleAvatar(
              radius: 17,
              backgroundColor: theme.colorScheme.primary.withValues(alpha: .12),
              child:
                  Icon(item.icon, size: 18, color: theme.colorScheme.primary)),
          const SizedBox(width: 8),
          Expanded(
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                Text(item.label,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: textStyles.regular11
                        .copyWith(color: theme.textTheme.bodySmall?.color)),
                Text(item.value,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: textStyles.semiBold12
                        .copyWith(color: theme.textTheme.bodyLarge?.color))
              ])),
        ]));
  }
}
