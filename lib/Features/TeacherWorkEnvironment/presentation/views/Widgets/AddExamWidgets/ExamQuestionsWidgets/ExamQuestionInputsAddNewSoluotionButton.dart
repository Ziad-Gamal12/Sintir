import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sintir/Core/Managers/Cubits/test_item_cubit/test_item_cubit.dart';
import 'package:sintir/Core/entities/CourseEntities/CourseTestItemEntities/CourseTestQuestionEntity.dart';
import 'package:sintir/Core/utils/textStyles.dart';
import 'package:sintir/constant.dart';
import 'package:sintir/locale_keys.dart';

class ExamQuestionInputsAddNewSoluotionButton extends StatelessWidget {
  const ExamQuestionInputsAddNewSoluotionButton({
    super.key,
    required this.coursetestquestionentity,
  });

  final CourseTestQuestionEntity coursetestquestionentity;

  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: () {
          context.read<TestItemCubit>().addSolution(
                question: coursetestquestionentity,
              );
        },
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.add,
              color: KMainColor,
            ),
            Text(
              LocaleKeys.addAnswer,
              style:
                  AppTextStyles(context).semiBold14.copyWith(color: KMainColor),
            )
          ],
        ));
  }
}
