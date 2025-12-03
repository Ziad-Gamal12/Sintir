import 'package:flutter/material.dart';
import 'package:sintir/Core/utils/textStyles.dart';

class CourseDetailsSubscribersGridviewItemSchoolLevel extends StatelessWidget {
  const CourseDetailsSubscribersGridviewItemSchoolLevel({
    super.key,
    required this.schoolLevel,
  });

  final String schoolLevel;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final Color iconColor = theme.textTheme.bodyLarge!.color!;
    final Color textColor = theme.textTheme.bodyLarge!.color!;

    return Row(
      children: [
        Icon(
          Icons.school_rounded,
          color: iconColor,
        ),
        const SizedBox(
          width: 5,
        ),
        Expanded(
          child: Text(
            schoolLevel == "" ? "_" : schoolLevel,
            overflow: TextOverflow.ellipsis,
            style: AppTextStyles(context).regular16.copyWith(color: textColor),
          ),
        ),
      ],
    );
  }
}
