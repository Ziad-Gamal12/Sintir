import 'package:flutter/material.dart';
import 'package:sintir/Core/utils/textStyles.dart';
import 'package:sintir/locale_keys.dart';

class SearchViewBodySearchViewBodyCoursesListHeader extends StatelessWidget {
  const SearchViewBodySearchViewBodyCoursesListHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Text(
      LocaleKeys.ourCourses,
      style: AppTextStyles(context).semiBold20,
    );
  }
}
