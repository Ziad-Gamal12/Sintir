import 'package:flutter/material.dart';
import 'package:sintir/Core/utils/textStyles.dart';

class PersonalHeaderTitleText extends StatelessWidget {
  const PersonalHeaderTitleText({super.key});

  @override
  Widget build(BuildContext context) {
    return Text(
      "البيانات الشخصية",
      style: AppTextStyles.semiBold20.copyWith(color: Colors.black),
    );
  }
}
