import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sintir/Core/Managers/Cubits/test_item_cubit/test_item_cubit.dart';
import 'package:sintir/Core/entities/CourseEntities/CourseTestItemEntities/CourseTestEntity.dart';
import 'package:sintir/Core/entities/CourseEntities/CourseTestItemEntities/CourseTestQuestionEntity.dart';
import 'package:sintir/Core/services/PickerAssetsService.dart';
import 'package:sintir/Core/services/get_it_Service.dart';
import 'package:sintir/Core/widgets/AwesomeDialog.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/Widgets/AddExamWidgets/AddCourseExamAddQuestionImage.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/Widgets/AddExamWidgets/ExamQuestionInputs.dart';

class AddCourseExamAddQuestionListViewItem extends StatefulWidget {
  const AddCourseExamAddQuestionListViewItem({
    super.key,
    required this.coursetestquestionentity,
    required this.coursetestentity,
  });
  final CourseTestQuestionEntity coursetestquestionentity;
  final CourseTestEntity coursetestentity;
  @override
  State<AddCourseExamAddQuestionListViewItem> createState() =>
      _AddCourseExamAddQuestionListViewItemState();
}

class _AddCourseExamAddQuestionListViewItemState
    extends State<AddCourseExamAddQuestionListViewItem> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onLongPress: () {
        removeQuestionItem(context);
      },
      child: Column(
        children: [
          ExamQuestionInputs(
            coursetestquestionentity: widget.coursetestquestionentity,
            courseTestEntity: widget.coursetestentity,
          ),
          const SizedBox(
            height: 5,
          ),
          AddCourseExamAddQuestionImage(
            coursetestquestionentity: widget.coursetestquestionentity,
            pickerassetsservice: getIt<Pickerassetsservice>(),
          )
        ],
      ),
    );
  }

  void removeQuestionItem(BuildContext context) {
    warningdialog(context, "هل انت متاكد من حذف السؤال", () {
      context.read<TestItemCubit>().removeQuestion(
          question: widget.coursetestquestionentity,
          coursetestentity: widget.coursetestentity);
    }).show();
  }
}
