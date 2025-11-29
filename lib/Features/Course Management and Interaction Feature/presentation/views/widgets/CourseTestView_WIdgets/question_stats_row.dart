import 'package:flutter/material.dart';
import 'package:sintir/Core/entities/CourseEntities/CourseTestItemEntities/CourseTestEntity.dart';
import 'package:sintir/Features/Course%20Management%20and%20Interaction%20Feature/presentation/views/widgets/CourseTestView_WIdgets/question_count_circle.dart';
import 'package:sintir/constant.dart';
import 'package:sintir/locale_keys.dart';

class QuestionStatsRow extends StatelessWidget {
  const QuestionStatsRow({super.key, required this.exam});

  final CourseTestEntity exam;

  @override
  Widget build(BuildContext context) {
    final total = exam.questions.length;
    final answered =
        exam.questions.where((e) => e.selectedSolution != "").length;
    final unanswered = total - answered;

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        QuestionCountCircle(
          count: total,
          borderColor: KMainColor,
          tooltip: LocaleKeys.totalQuestions,
        ),
        QuestionCountCircle(
          count: answered,
          borderColor: Colors.green,
          tooltip: LocaleKeys.answeredQuestions,
        ),
        QuestionCountCircle(
          count: unanswered,
          borderColor: Colors.red,
          tooltip: LocaleKeys.unansweredQuestions,
        ),
      ],
    );
  }
}
