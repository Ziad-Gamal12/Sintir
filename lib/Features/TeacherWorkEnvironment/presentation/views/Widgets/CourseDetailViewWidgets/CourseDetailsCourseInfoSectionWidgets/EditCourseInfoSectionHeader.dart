import 'package:flutter/material.dart';
import 'package:sintir/Core/utils/textStyles.dart';
import 'package:sintir/locale_keys.dart';

class EditCourseInfoSectionHeader extends StatelessWidget {
  const EditCourseInfoSectionHeader({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Spacer(),
        const SizedBox(
          width: 30,
        ),
        Text(
          LocaleKeys.courseDetails,
          style:
              AppTextStyles(context).semiBold20.copyWith(color: Colors.black),
        ),
        const Spacer(),
        IconButton(
          icon: const Icon(
            Icons.close,
            color: Colors.red,
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
