import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:sintir/Core/utils/textStyles.dart';

class ExamQuestionInputsQuestionHeader extends StatelessWidget {
  const ExamQuestionInputsQuestionHeader({
    super.key,
    required this.index,
    required this.totalQuestions,
  });

  final int index;
  final int totalQuestions;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Icon(FontAwesomeIcons.circleInfo, color: Colors.red, size: 25),
        const SizedBox(
          width: 10,
        ),
        Text.rich(
          TextSpan(children: [
            TextSpan(
              text: "سؤال رقم ",
              style: AppTextStyles(context)
                  .semiBold16
                  .copyWith(color: Colors.black),
            ),
            TextSpan(
              text: "${index + 1}",
              style:
                  AppTextStyles(context).semiBold16.copyWith(color: Colors.red),
            ),
            TextSpan(
              text: " من ",
              style: AppTextStyles(context)
                  .regular16
                  .copyWith(color: Colors.black),
            ),
            TextSpan(
              text: "$totalQuestions",
              style:
                  AppTextStyles(context).semiBold16.copyWith(color: Colors.red),
            ),
          ]),
        ),
      ],
    );
  }
}
