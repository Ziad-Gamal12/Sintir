import 'package:flutter/material.dart';
import 'package:sintir/Core/utils/textStyles.dart';
import 'package:sintir/constant.dart';
import 'package:sintir/locale_keys.dart';

class QuestionCountHeader extends StatelessWidget {
  final int count;
  const QuestionCountHeader({super.key, required this.count});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          LocaleKeys.questionsHeader,
          style: AppTextStyles(context).bold19,
        ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
          decoration: BoxDecoration(
            color: KMainColor.withOpacity(0.1),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Text(
            "$count ${LocaleKeys.questionUnit}",
            style: AppTextStyles(context).bold14.copyWith(color: KMainColor),
          ),
        ),
      ],
    );
  }
}
