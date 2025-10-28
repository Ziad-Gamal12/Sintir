import 'package:flutter/material.dart';
import 'package:sintir/Core/utils/textStyles.dart';

class SearchViewBodySearchViewBodyTeachersListHeader extends StatelessWidget {
  const SearchViewBodySearchViewBodyTeachersListHeader({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      "مدرسينا",
      style: AppTextStyles(context).semiBold20,
    );
  }
}
