import 'package:flutter/material.dart';
import 'package:sintir/Core/utils/textStyles.dart';
import 'package:sintir/locale_keys.dart';

class CourseTestOverViewBodyListViewHeader extends StatelessWidget {
  const CourseTestOverViewBodyListViewHeader({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      LocaleKeys.previousResults,
      style: AppTextStyles(context).semiBold20.copyWith(color: Colors.black),
    );
  }
}
