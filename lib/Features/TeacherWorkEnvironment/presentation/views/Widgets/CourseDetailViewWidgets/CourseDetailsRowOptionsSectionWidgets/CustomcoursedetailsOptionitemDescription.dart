import 'package:flutter/material.dart';
import 'package:sintir/Core/utils/textStyles.dart';

class CustomcoursedetailsOptionitemDescription extends StatelessWidget {
  const CustomcoursedetailsOptionitemDescription({
    super.key,
    required this.description,
  });

  final String description;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Text(
      description,
      maxLines: 3,
      overflow: TextOverflow.ellipsis,
      style: AppTextStyles(context).regular10.copyWith(
            color: theme.textTheme.bodyMedium?.color ?? Colors.black,
          ),
    );
  }
}
