import 'package:flutter/material.dart';
import 'package:sintir/Core/utils/textStyles.dart';

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
          "تعديل بيانات الدورة",
          style: AppTextStyles(context).bold20.copyWith(color: Colors.black),
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
