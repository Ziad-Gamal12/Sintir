import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sintir/Core/Managers/Cubits/test_item_cubit/test_item_cubit.dart';
import 'package:sintir/Core/entities/CourseEntities/CourseTestItemEntities/CourseTestEntity.dart';
import 'package:sintir/Core/entities/CourseEntities/CourseTestItemEntities/CourseTestQuestionEntity.dart';
import 'package:sintir/Core/services/PickerAssetsService.dart';
import 'package:sintir/Core/services/get_it_Service.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/Widgets/AddExamWidgets/AddCourseExamAddQuestionImage.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/Widgets/AddExamWidgets/ExamQuestionInputs.dart';

class AddCourseExamAddQuestionListViewItem extends StatefulWidget {
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
  State<AddCourseExamAddQuestionListViewItem> createState() =>
      _AddCourseExamAddQuestionListViewItemState();
}

class _AddCourseExamAddQuestionListViewItemState
    extends State<AddCourseExamAddQuestionListViewItem> {
  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: ValueKey(
        widget.coursetestquestionentity.index.toString(),
      ),
      onDismissed: (direction) => removeQuestionItem(context),
      direction: DismissDirection.horizontal,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: const Color(0xffF2F2F7),
          border: Border.all(color: Colors.grey.shade300, width: 2),
        ),
        child: Column(
          children: [
            ExamQuestionInputs(
              index: widget.index,
              coursetestquestionentity: widget.coursetestquestionentity,
              courseTestEntity: widget.coursetestentity,
            ),
            const Divider(
              color: Colors.black,
              thickness: 1,
            ),
            AddCourseExamAddQuestionImage(
              coursetestquestionentity: widget.coursetestquestionentity,
              pickerassetsservice: getIt<Pickerassetsservice>(),
            )
          ],
        ),
      ),
    );
  }

  void removeQuestionItem(BuildContext context) {
    context.read<TestItemCubit>().removeQuestion(
        question: widget.coursetestquestionentity,
        coursetestentity: widget.coursetestentity);
  }
}
