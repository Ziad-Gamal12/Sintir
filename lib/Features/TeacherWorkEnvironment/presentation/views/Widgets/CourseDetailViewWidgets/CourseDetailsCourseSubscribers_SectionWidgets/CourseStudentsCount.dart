import 'package:flutter/material.dart';
import 'package:sintir/Core/utils/textStyles.dart';
import 'package:sintir/locale_keys.dart';

class CourseStudentsCount extends StatelessWidget {
  final int count;
  const CourseStudentsCount({super.key, required this.count});

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final Color primaryTextColor = theme.textTheme.bodyLarge!.color!;
    final Color accentColor = theme.colorScheme.primary;

    return RichText(
      text: TextSpan(
        style: AppTextStyles(context).regular16,
        children: [
          TextSpan(
              text: LocaleKeys.subscribersCount,
              style: AppTextStyles(context)
                  .regular16
                  .copyWith(color: primaryTextColor)),
          TextSpan(
            text: " $count ",
            style: AppTextStyles(context).semiBold16.copyWith(
                  color: accentColor,
                ),
          ),
          TextSpan(
              text: LocaleKeys.person,
              style: AppTextStyles(context)
                  .regular16
                  .copyWith(color: primaryTextColor)),
        ],
      ),
    );
  }
}
