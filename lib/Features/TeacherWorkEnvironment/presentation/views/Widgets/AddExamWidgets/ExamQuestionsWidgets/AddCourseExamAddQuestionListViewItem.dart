import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sintir/Core/Managers/Cubits/test_item_cubit/test_item_cubit.dart';
import 'package:sintir/Core/entities/CourseEntities/CourseTestItemEntities/CourseTestEntity.dart';
import 'package:sintir/Core/entities/CourseEntities/CourseTestItemEntities/CourseTestQuestionEntity.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/Widgets/AddExamWidgets/ExamQuestionsWidgets/AddCourseExamAddQuestionExplainationImage.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/Widgets/AddExamWidgets/ExamQuestionsWidgets/AddCourseExamAddQuestionImage.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/Widgets/AddExamWidgets/ExamQuestionsWidgets/ExamQuestionInputs.dart';

class AddCourseExamAddQuestionListViewItem extends StatelessWidget {
  const AddCourseExamAddQuestionListViewItem({
    super.key,
    required this.coursetestquestionentity,
    required this.coursetestentity,
    required this.index,
  });
  final CourseTestQuestionEntity coursetestquestionentity;
  final CourseTestEntity coursetestentity;
  final int index;
  @override
  Widget build(BuildContext context) {
    // 💡 Fetching theme colors dynamically for Dark Mode compatibility
    final ThemeData theme = Theme.of(context);
    final bool isDarkMode = theme.brightness == Brightness.dark;

    // Use a theme-aware color for the container background
    final Color containerColor = theme.cardColor;

    // Use a theme-aware color for the border and divider
    // In Dark Mode, a lighter shade is needed; in Light Mode, a darker shade.
    final Color borderColor =
        isDarkMode ? Colors.grey.shade600 : Colors.grey.shade300;

    // Adjust shadow for Dark Mode: typically, shadows are less intense or omitted.
    final List<BoxShadow> boxShadows = isDarkMode
        ? [
            // Lighter/fewer shadow in dark mode for a flat look
            const BoxShadow(
              color: Colors.white10,
              blurRadius: 2,
              offset: Offset(0, 2),
            ),
          ]
        : const [
            // Standard shadow for light mode
            BoxShadow(
              color: Colors.black26,
              blurRadius: 4,
              offset: Offset(0, 4),
            ),
          ];

    return Dismissible(
      key: ObjectKey(coursetestquestionentity),
      onDismissed: (direction) => removeQuestionItem(context),
      direction: DismissDirection.horizontal,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          boxShadow: boxShadows,
          color: containerColor,
          border: Border.all(color: borderColor, width: 1),
        ),
        child: Column(
          children: [
            ExamQuestionInputs(
              index: index,
              coursetestquestionentity: coursetestquestionentity,
              courseTestEntity: coursetestentity,
            ),
            Divider(
              color: borderColor,
              thickness: 1,
            ),
            AddCourseExamAddQuestionImage(
              coursetestquestionentity: coursetestquestionentity,
            ),
            Divider(
              color: borderColor,
              thickness: 1,
            ),
            AddCourseExamAddQuestionExplainationImage(
              coursetestquestionentity: coursetestquestionentity,
            )
          ],
        ),
      ),
    );
  }

  void removeQuestionItem(BuildContext context) {
    context.read<TestItemCubit>().removeQuestion(
        question: coursetestquestionentity, coursetestentity: coursetestentity);
  }
}
