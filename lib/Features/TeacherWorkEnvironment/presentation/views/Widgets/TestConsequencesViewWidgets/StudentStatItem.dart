import 'package:flutter/material.dart';
import 'package:sintir/Core/utils/textStyles.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/Widgets/TestConsequencesViewWidgets/StudentStatItemIcon.dart';

class StudentStatItem extends StatelessWidget {
  const StudentStatItem({
    super.key,
    required this.icon,
    required this.title,
    required this.value,
    required this.backgroundColor,
  });

  final String icon;
  final String title;
  final String value;
  final Color backgroundColor;

  @override
  Widget build(BuildContext context) {
    final style = AppTextStyles(context);
    final theme = Theme.of(context);

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: theme.colorScheme.surfaceContainerHighest.withValues(alpha: .55),
        border: Border.all(color: theme.dividerColor.withValues(alpha: .45)),
      ),
      child: Row(
        children: [
          StudentStatItemIcon(icon: icon, backgroundColor: backgroundColor),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  // letterSpacing removed: it breaks Arabic letter joining.
                  style: style.regular12.copyWith(
                    color: theme.colorScheme.onSurfaceVariant,
                  ),
                ),
                const SizedBox(height: 4),
                Directionality(
                  textDirection: TextDirection.ltr,
                  child: Text(
                    value,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: style.semiBold16.copyWith(
                      color: theme.colorScheme.onSurface,
                    ),
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
