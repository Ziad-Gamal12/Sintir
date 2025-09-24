// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:sintir/Core/utils/textStyles.dart';
import 'package:sintir/constant.dart';

class CustomLoginViewBodyDonotHaveAccountText extends StatelessWidget {
  const CustomLoginViewBodyDonotHaveAccountText({
    super.key,
    required this.onTap,
  });
  final void Function() onTap;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Text.rich(TextSpan(children: [
        TextSpan(
            text: "ليس لديك حساب؟ ",
            style: AppTextStyles.semiBold16
                .copyWith(color: const Color(0xff949D9E))),
        TextSpan(
            text: "انشاء حساب",
            style: AppTextStyles.semiBold16.copyWith(color: KMainColor))
      ])),
    );
  }
}
