import 'package:flutter/material.dart';
import 'package:sintir/Core/utils/textStyles.dart';

class CourseDetailsSubscribersGridviewItemPhoneNumber extends StatelessWidget {
  const CourseDetailsSubscribersGridviewItemPhoneNumber({
    super.key,
    required this.phone,
  });

  final String phone;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final Color iconColor = theme.textTheme.bodyLarge!.color!;
    final Color textColor = theme.textTheme.bodyLarge!.color!;

    return Row(
      children: [
        Icon(
          Icons.phone,
          color: iconColor,
        ),
        const SizedBox(
          width: 5,
        ),
        Expanded(
          child: Text(
            phone == "" ? "_" : phone,
            overflow: TextOverflow.ellipsis,
            style: AppTextStyles(context).regular16.copyWith(color: textColor),
          ),
        ),
      ],
    );
  }
}
