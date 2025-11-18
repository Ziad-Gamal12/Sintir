import 'package:flutter/material.dart';
import 'package:sintir/Core/entities/CourseEntities/CourseTestItemEntities/CourseTestQuestionEntity.dart';
import 'package:sintir/Core/utils/textStyles.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/Widgets/AddExamWidgets/ExamQuestionInputsQuestionHeader.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/Widgets/ReviewExamWidgets/CustomReviewQuestionImage.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/Widgets/ReviewExamWidgets/CustomReviewQuestionSolutionList.dart';

class CustomReviewExamQuestionListItem extends StatelessWidget {
  const CustomReviewExamQuestionListItem({
    super.key,
    required this.question,
    required this.totalQuestions,
    required this.index,
  });
  final CourseTestQuestionEntity question;
  final int totalQuestions;
  final int index;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: Colors.grey.shade400, width: .5),
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.shade100,
            blurRadius: 10,
            spreadRadius: 2,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ExamQuestionInputsQuestionHeader(
              index: index, totalQuestions: totalQuestions),
          const SizedBox(
            height: 10,
          ),
          Text(
            "${question.questionTitle}؟",
            style:
                AppTextStyles(context).semiBold20.copyWith(color: Colors.black),
          ),
          const SizedBox(
            height: 10,
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Customreviewquestionsolutionlist(
                  solutions: question.solutions,
                ),
              ),
              const SizedBox(
                width: 10,
              ),
              Expanded(
                  child:
                      CustomReviewQuestionImage(imageFile: question.imageFile))
            ],
          )
        ],
      ),
    );
  }
}
