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
    return Text(
      description,
      maxLines: 3,
      style: AppTextStyles(context)
          .regular10
          .copyWith(color: Colors.black, overflow: TextOverflow.ellipsis),
    );
  }
}
