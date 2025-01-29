import 'package:flutter/material.dart';
import 'package:sintir/Core/utils/textStyles.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/Widgets/AddCourseEditeWidget.dart';

class AddCourseFirstContentHeader extends StatelessWidget {
  const AddCourseFirstContentHeader({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          "محتوى الدورة",
          style: AppTextStyles.semiBold20.copyWith(color: Colors.black),
        ),
        const Spacer(),
        const AddCourseEditeWidget()
      ],
    );
  }
}
