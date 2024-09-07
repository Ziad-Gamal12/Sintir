// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:sintir/constant.dart';

import '../../../../../Core/utils/textStyles.dart';

class StudentTextRich extends StatelessWidget {
  final String? text1, text2;
  const StudentTextRich({super.key, this.text1, this.text2});

  @override
  Widget build(BuildContext context) {
    return Text.rich(
      TextSpan(
        children: [
          TextSpan(
              text: text1,
              style: AppTextStyles.semiBold16
                  .copyWith(color: const Color(0xff818181))),
          const TextSpan(text: " "),
          TextSpan(
              text: text2,
              style: AppTextStyles.semiBold16.copyWith(color: KMainColor)),
        ],
      ),
    );
  }
}
