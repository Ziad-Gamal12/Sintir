import 'package:flutter/material.dart';
import 'package:sintir/Core/utils/textStyles.dart';
import 'package:sintir/locale_keys.dart';

class SubscriberCoursesCountBadge extends StatelessWidget {
  const SubscriberCoursesCountBadge({
    super.key,
    required this.count,
  });

  final int count;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 3, horizontal: 8),
      decoration: ShapeDecoration(
        color: theme.colorScheme.surfaceContainerHighest,
        shape: StadiumBorder(
          side: BorderSide(
            color: theme.dividerColor.withValues(alpha: .5),
            width: 1,
          ),
        ),
      ),
      child: Text(
        LocaleKeys.coursesCount(count),
        textDirection: TextDirection.rtl,
        style: AppTextStyles(context).semiBold12.copyWith(
              height: 1.2,
              color: theme.colorScheme.onSurfaceVariant,
            ),
      ),
    );
  }
}
