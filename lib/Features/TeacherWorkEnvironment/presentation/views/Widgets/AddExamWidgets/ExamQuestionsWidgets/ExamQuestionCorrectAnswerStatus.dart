// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sintir/Core/Managers/Cubits/test_item_cubit/test_item_cubit.dart';
import 'package:sintir/Core/entities/CourseEntities/CourseTestItemEntities/CourseTestQuestionEntity.dart';
import 'package:sintir/Core/utils/textStyles.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/Widgets/TeacherWorkspace/TeachespaceEnvironmentTheme.dart';
import 'package:sintir/locale_keys.dart';

/// Whether the question has a correct answer marked: green once it does,
/// amber until then, and red once the teacher has tried to continue without
/// one ([flagged]).
class ExamQuestionCorrectAnswerStatus extends StatelessWidget {
  const ExamQuestionCorrectAnswerStatus({
    super.key,
    required this.question,
    required this.flagged,
  });

  final CourseTestQuestionEntity question;
  final bool flagged;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TestItemCubit, TestItemState>(
      buildWhen: (previous, current) {
        return current is AddCourseSectionTestSolutionChanged ||
            current is AddCourseSectionTestSolutionRemoved;
      },
      builder: (context, state) {
        final tokens = WorkEnvironmentThemeExtension.of(context);
        final (
          foreground,
          background,
          border,
          icon,
          label,
        ) = question.hasCorrectAnswer
            ? (
                tokens.successForeground,
                tokens.successBackground,
                tokens.successBorder,
                Icons.check_circle_rounded,
                LocaleKeys.correctAnswer,
              )
            : flagged
            ? (
                tokens.dangerForeground,
                tokens.dangerBackground,
                tokens.dangerBorder,
                Icons.error_outline_rounded,
                LocaleKeys.markCorrectAnswer,
              )
            : (
                tokens.warningForeground,
                tokens.warningBackground,
                tokens.warningBorder,
                Icons.radio_button_unchecked_rounded,
                LocaleKeys.markCorrectAnswer,
              );

        return AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
          decoration: BoxDecoration(
            color: background,
            borderRadius: BorderRadius.circular(999),
            border: Border.all(color: border),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(icon, size: 16, color: foreground),
              const SizedBox(width: 6),
              Flexible(
                child: Text(
                  label,
                  style: AppTextStyles(
                    context,
                  ).semiBold12.copyWith(color: foreground),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
