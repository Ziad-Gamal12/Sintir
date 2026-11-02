import 'package:flutter/material.dart';
import 'package:sintir/Core/utils/textStyles.dart';
import 'package:sintir/locale_keys.dart';

class SubscriberCoursesCountBadge extends StatelessWidget {
  const SubscriberCoursesCountBadge({super.key, required this.count});
  final int count;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDarkMode = theme.brightness == Brightness.dark;
    return Container(
      padding:
          const EdgeInsetsDirectional.symmetric(vertical: 4, horizontal: 8),
      decoration: ShapeDecoration(
        color: theme.colorScheme.surfaceContainerHighest,
        shape: StadiumBorder(
            side: BorderSide(
                color: isDarkMode ? Colors.black54 : Colors.grey.shade200,
                width: 1)),
      ),
      child: Text(
        LocaleKeys.subscriberCourseCount(
            count, Localizations.localeOf(context).toString()),
        style: AppTextStyles(context)
            .semiBold12
            .copyWith(color: theme.colorScheme.onSurface),
      ),
    );
  }
}
