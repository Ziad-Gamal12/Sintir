// ignore_for_file: camel_case_types, file_names

import 'package:flutter/material.dart';
import 'package:sintir/Core/utils/textStyles.dart';

class courseDetailsViewBodyListViewHeader extends StatelessWidget {
  const courseDetailsViewBodyListViewHeader({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      "المحتوى",
      style: AppTextStyles.bold24.copyWith(color: Colors.black),
      textAlign: TextAlign.center,
    );
  }
}
