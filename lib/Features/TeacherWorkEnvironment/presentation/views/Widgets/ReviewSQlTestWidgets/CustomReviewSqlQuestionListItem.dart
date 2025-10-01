import 'package:flutter/material.dart';
import 'package:sintir/Core/entities/CourseEntities/CourseTestItemEntities/CourseTestQuestionEntity.dart';
import 'package:sintir/Core/utils/textStyles.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/Widgets/ReviewSQlTestWidgets/CustomReviewQuestionImage.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/Widgets/ReviewSQlTestWidgets/CustomReviewQuestionSolutionList.dart';

class CustomReviewSqlQuestionListItem extends StatelessWidget {
  const CustomReviewSqlQuestionListItem({
    super.key,
    required this.question,
  });
  final CourseTestQuestionEntity question;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      width: double.infinity,
      decoration: BoxDecoration(
        color: const Color(0xffF2F2F7),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "*${question.questionTitle}؟",
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
                width: 5,
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
