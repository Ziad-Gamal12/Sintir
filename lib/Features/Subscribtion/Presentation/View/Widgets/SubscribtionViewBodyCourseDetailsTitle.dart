import 'package:flutter/material.dart';
import 'package:sintir/Core/utils/textStyles.dart';
import 'package:sintir/locale_keys.dart';

class SubscribtionViewBodyCourseDetailsTitle extends StatelessWidget {
  const SubscribtionViewBodyCourseDetailsTitle({super.key});

  @override
  Widget build(BuildContext context) {
    return Text(
      LocaleKeys.courseDetails,
      style: AppTextStyles(context).semiBold20,
    );
  }
}
