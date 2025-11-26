import 'package:flutter/material.dart';
import 'package:sintir/Core/utils/textStyles.dart';
import 'package:sintir/locale_keys.dart';

class SearchViewBodySearchViewBodyTeachersListHeader extends StatelessWidget {
  const SearchViewBodySearchViewBodyTeachersListHeader({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      LocaleKeys.ourTeachers,
      style: AppTextStyles(context).semiBold20,
    );
  }
}
