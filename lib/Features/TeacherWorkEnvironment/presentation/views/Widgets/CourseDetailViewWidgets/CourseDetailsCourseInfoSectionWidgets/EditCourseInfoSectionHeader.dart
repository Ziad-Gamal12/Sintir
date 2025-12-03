import 'package:flutter/material.dart';
import 'package:sintir/Core/utils/textStyles.dart';
import 'package:sintir/locale_keys.dart';

class EditCourseInfoSectionHeader extends StatelessWidget {
  const EditCourseInfoSectionHeader({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textColor = theme.textTheme.bodyLarge?.color ?? Colors.black;
    const closeIconColor = Colors.redAccent; // ثابت لأن عادة الأحمر يبقى أحمر

    return Row(
      children: [
        const Spacer(),
        const SizedBox(width: 30),
        Text(
          LocaleKeys.courseDetails,
          style: AppTextStyles(context).semiBold20.copyWith(color: textColor),
        ),
        const Spacer(),
        IconButton(
          icon: const Icon(
            Icons.close,
            color: closeIconColor,
            size: 30,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ],
    );
  }
}
