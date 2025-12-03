import 'package:flutter/material.dart';
import 'package:sintir/Core/utils/textStyles.dart';

class CustomcoursedetailsOptionitemTItleAndArrowIcon extends StatelessWidget {
  const CustomcoursedetailsOptionitemTItleAndArrowIcon({
    super.key,
    required this.title,
  });

  final String title;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: Text(
            title,
            overflow: TextOverflow.ellipsis,
            style: AppTextStyles(context).semiBold16.copyWith(
                  color: theme.textTheme.bodyLarge?.color ?? Colors.black,
                ),
          ),
        ),
        Transform.rotate(
          angle: 3.14,
          child: Icon(
            Icons.arrow_back_ios,
            color: theme.iconTheme.color ?? Colors.black,
            size: 20,
          ),
        )
      ],
    );
  }
}
