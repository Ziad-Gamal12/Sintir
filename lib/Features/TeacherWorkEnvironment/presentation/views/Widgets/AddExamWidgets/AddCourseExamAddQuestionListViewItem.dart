import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sintir/Core/Managers/Cubits/test_item_cubit/test_item_cubit.dart';
import 'package:sintir/Core/entities/CourseEntities/CourseTestItemEntities/CourseTestEntity.dart';
import 'package:sintir/Core/entities/CourseEntities/CourseTestItemEntities/CourseTestQuestionEntity.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/Widgets/AddExamWidgets/AddCourseExamAddQuestionExplainationImage.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/Widgets/AddExamWidgets/AddCourseExamAddQuestionImage.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/Widgets/AddExamWidgets/ExamQuestionInputs.dart';

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
    return Dismissible(
      key: ObjectKey(coursetestquestionentity),
      onDismissed: (direction) => removeQuestionItem(context),
      direction: DismissDirection.horizontal,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          boxShadow: const [
            BoxShadow(
              color: Colors.black26,
              blurRadius: 4,
              offset: Offset(0, 4),
            ),
          ],
          color: Colors.white,
          border: Border.all(color: Colors.grey.shade300, width: 1),
        ),
        child: Column(
          children: [
            ExamQuestionInputs(
              index: index,
              coursetestquestionentity: coursetestquestionentity,
              courseTestEntity: coursetestentity,
            ),
            Divider(
              color: Colors.grey.shade300,
              thickness: 1,
            ),
            AddCourseExamAddQuestionImage(
              coursetestquestionentity: coursetestquestionentity,
            ),
            Divider(
              color: Colors.grey.shade300,
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
