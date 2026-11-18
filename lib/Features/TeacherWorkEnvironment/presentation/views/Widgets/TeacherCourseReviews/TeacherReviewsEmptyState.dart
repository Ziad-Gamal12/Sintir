// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:sintir/Core/utils/textStyles.dart';
import 'package:sintir/locale_keys.dart';

class TeacherReviewsEmptyState extends StatelessWidget {
  const TeacherReviewsEmptyState({
    super.key,
    required this.filtered,
    required this.onShowAll,
  });

  final bool filtered;
  final VoidCallback onShowAll;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final styles = AppTextStyles(context);
    final mutedColor = theme.textTheme.bodySmall?.color;

    return Padding(
      key: ValueKey(
        filtered ? 'teacher-reviews-filter-empty' : 'teacher-reviews-empty',
      ),
      padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            filtered ? Icons.filter_alt_off_outlined : Icons.reviews_outlined,
            size: 40,
            color: mutedColor,
          ),
          const SizedBox(height: 12),
          Text(
            filtered ? LocaleKeys.reviewsFilterEmpty : LocaleKeys.noReviewsYet,
            textAlign: TextAlign.center,
            style: styles.semiBold16.copyWith(
              color: theme.textTheme.bodyLarge?.color,
            ),
          ),
          const SizedBox(height: 6),
          if (filtered)
            TextButton(
              key: const ValueKey('teacher-reviews-show-all'),
              onPressed: onShowAll,
              child: Text(LocaleKeys.reviewsShowAll),
            )
          else
            Text(
              LocaleKeys.teacherReviewsEmptyDescription,
              textAlign: TextAlign.center,
              style: styles.regular14.copyWith(color: mutedColor, height: 1.6),
            ),
        ],
      ),
    );
  }
}
