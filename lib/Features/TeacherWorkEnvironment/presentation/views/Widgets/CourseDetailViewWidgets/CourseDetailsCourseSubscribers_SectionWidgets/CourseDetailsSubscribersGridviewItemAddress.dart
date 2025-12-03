import 'package:flutter/material.dart';
import 'package:sintir/Core/utils/textStyles.dart';

class CourseDetailsSubscribersGridviewItemAddress extends StatelessWidget {
  const CourseDetailsSubscribersGridviewItemAddress({
    super.key,
    required this.address,
  });

  final String address;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final Color iconColor = theme.textTheme.bodyLarge!.color!;
    final Color textColor = theme.textTheme.bodyLarge!.color!;

    return Row(
      children: [
        Icon(
          Icons.location_on,
          color: iconColor,
        ),
        const SizedBox(
          width: 5,
        ),
        Expanded(
          child: Text(
            address == "" ? "_" : address,
            overflow: TextOverflow.ellipsis,
            style: AppTextStyles(context).regular16.copyWith(color: textColor),
          ),
        ),
      ],
    );
  }
}
