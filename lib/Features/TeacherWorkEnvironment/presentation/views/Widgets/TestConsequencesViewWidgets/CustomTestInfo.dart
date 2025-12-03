import 'package:flutter/material.dart';
import 'package:sintir/Core/entities/CourseEntities/CourseTestItemEntities/CourseTestEntity.dart';
import 'package:sintir/Core/utils/textStyles.dart';

class CustomTestInfo extends StatelessWidget {
  const CustomTestInfo({
    super.key,
    required this.test,
  });

  final CourseTestEntity test;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    // Primary text color (dark in light mode, light in dark mode)
    final Color titleColor = theme.textTheme.bodyLarge!.color!;
    // Secondary text color (suitable for less important details like IDs)
    final Color idColor = theme.textTheme.bodySmall!.color!.withOpacity(0.7);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Text(
          test.title,
          textAlign: TextAlign.center,
          style: AppTextStyles(context)
              .semiBold20
              // Use theme-aware color instead of hardcoded Colors.black
              .copyWith(color: titleColor),
        ),
        const SizedBox(
          height: 10,
        ),
        Text(
          test.id,
          textAlign: TextAlign.center,
          style: AppTextStyles(context).regular14.copyWith(color: idColor),
        ),
      ],
    );
  }
}
