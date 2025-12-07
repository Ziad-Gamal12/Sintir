import 'package:flutter/material.dart';
import 'package:sintir/Core/entities/CourseEntities/CourseTestItemEntities/CourseTestQuestionEntity.dart';
import 'package:sintir/Core/utils/textStyles.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/Widgets/AddExamWidgets/ExamQuestionsWidgets/ExamQuestionInputsQuestionHeader.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/Widgets/AddExamWidgets/ReviewExamWidgets/CustomReviewQuestionImage.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/Widgets/AddExamWidgets/ReviewExamWidgets/CustomReviewQuestionSolutionList.dart';

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
    // Fetch theme data
    final ThemeData theme = Theme.of(context);
    final bool isDarkMode = theme.brightness == Brightness.dark;

    // Use theme-aware colors
    final Color containerColor = theme.cardColor;
    final Color primaryTextColor = theme.textTheme.bodyLarge!.color!;

    // Adjust border color based on mode
    final Color borderColor =
        isDarkMode ? Colors.grey.shade600 : Colors.grey.shade400;

    // Adjust shadow for Dark Mode
    final List<BoxShadow> boxShadows = isDarkMode
        ? [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              blurRadius: 5,
              spreadRadius: 1,
              offset: const Offset(0, 2),
            ),
          ]
        : [
            BoxShadow(
              color: Colors.grey.shade100,
              blurRadius: 10,
              spreadRadius: 2,
              offset: const Offset(0, 3),
            ),
          ];

    return Container(
      padding: const EdgeInsets.all(16),
      width: double.infinity,
      decoration: BoxDecoration(
        color: containerColor,
        border: Border.all(color: borderColor, width: .5),
        borderRadius: BorderRadius.circular(16),
        // Use theme-aware shadows
        boxShadow: boxShadows,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ExamQuestionInputsQuestionHeader is already theme-aware
          ExamQuestionInputsQuestionHeader(
              index: index, totalQuestions: totalQuestions),
          const SizedBox(
            height: 10,
          ),
          Text(
            "${question.questionTitle}؟",
            style: AppTextStyles(context)
                .semiBold20
                // Use primaryTextColor instead of hardcoded Colors.black
                .copyWith(color: primaryTextColor),
          ),
          const SizedBox(
            height: 10,
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                // CustomReviewQuestionSolutionList needs to be theme-aware internally
                child: Customreviewquestionsolutionlist(
                  solutions: question.solutions,
                ),
              ),
              const SizedBox(
                width: 10,
              ),
              Expanded(
                  // CustomReviewQuestionImage needs to be theme-aware internally
                  child:
                      CustomReviewQuestionImage(imageFile: question.imageFile))
            ],
          )
        ],
      ),
    );
  }
}
