import 'package:flutter/material.dart';
import 'package:sintir/Core/utils/textStyles.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/domain/Entities/CoursedetailsviewOptionitemEntity.dart';

class CourseDetailManagementTile extends StatelessWidget {
  const CourseDetailManagementTile({super.key, required this.item});
  final CoursedetailsviewOptionitemEntity item;
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textStyles = AppTextStyles(context);
    final icon = switch (item.title) {
      _ when item.image.toLowerCase().contains('content') =>
        Icons.folder_open_outlined,
      _ when item.image.toLowerCase().contains('student') =>
        Icons.groups_outlined,
      _ when item.image.toLowerCase().contains('feedback') =>
        Icons.star_outline,
      _ when item.image.toLowerCase().contains('coupon') =>
        Icons.confirmation_number_outlined,
      _ => Icons.flag_outlined,
    };
    return Material(
        color: theme.colorScheme.surfaceContainerHighest.withValues(alpha: .55),
        borderRadius: BorderRadius.circular(16),
        child: InkWell(
          borderRadius: BorderRadius.circular(16),
          onTap: item.onTap,
          child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
              child: Row(children: [
                CircleAvatar(
                    backgroundColor:
                        theme.colorScheme.primary.withValues(alpha: .13),
                    foregroundColor: theme.colorScheme.primary,
                    child: Icon(icon)),
                const SizedBox(width: 10),
                Expanded(
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                      Text(item.title,
                          style: textStyles.semiBold16.copyWith(
                              color: theme.textTheme.titleMedium?.color)),
                      Text(item.description,
                          textAlign: TextAlign.start,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: textStyles.regular12.copyWith(
                              color: theme.textTheme.bodySmall?.color)),
                    ])),
                const SizedBox(width: 12),
                Icon(Icons.chevron_left,
                    color: theme.textTheme.bodySmall?.color),
              ])),
        ));
  }
}
