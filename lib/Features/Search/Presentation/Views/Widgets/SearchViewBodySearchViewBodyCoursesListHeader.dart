import 'package:flutter/material.dart';
import 'package:sintir/Core/utils/textStyles.dart';

class SearchViewBodySearchViewBodyCoursesListHeader extends StatelessWidget {
  const SearchViewBodySearchViewBodyCoursesListHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Text(
      "كورساتنا",
      style: AppTextStyles(context).semiBold20,
    );
  }
}
