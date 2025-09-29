import 'package:flutter/material.dart';
import 'package:sintir/Core/utils/textStyles.dart';

class PersonalHeaderTitleText extends StatelessWidget {
  const PersonalHeaderTitleText({super.key, required this.title});
  final String title;
  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: AppTextStyles.semiBold20.copyWith(color: Colors.black),
    );
  }
}
