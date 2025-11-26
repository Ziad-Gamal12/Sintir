// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:sintir/Core/utils/textStyles.dart';
import 'package:sintir/locale_keys.dart';

class CustomMyCoursesGridHeader extends StatelessWidget {
  const CustomMyCoursesGridHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Text(
          LocaleKeys.myCourses,
          style: AppTextStyles(context).bold20.copyWith(color: Colors.black),
        ),
      ],
    );
  }
}
