import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sintir/Core/Managers/Cubits/test_item_cubit/test_item_cubit.dart';
import 'package:sintir/Core/entities/CourseEntities/CourseTestItemEntities/CourseTestEntity.dart';
import 'package:sintir/Core/entities/CourseEntities/CourseTestItemEntities/CourseTestQuestionEntity.dart';
import 'package:sintir/Core/services/PickerAssetsService.dart';
import 'package:sintir/Core/services/get_it_Service.dart';
import 'package:sintir/Core/widgets/AwesomeDialog.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/Widgets/AddSqlTestWidgets/AddCourseSQLAddQuestionImage.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/Widgets/AddSqlTestWidgets/SQLTestQuestionInputs.dart';

class Addcoursesqladdquestionlistitem extends StatefulWidget {
  const Addcoursesqladdquestionlistitem({
    super.key,
    required this.coursetestquestionentity,
    required this.coursetestentity,
  });
  final CourseTestQuestionEntity coursetestquestionentity;
  final CourseTestEntity coursetestentity;
  @override
  State<Addcoursesqladdquestionlistitem> createState() =>
      _AddcoursesqladdquestionlistitemState();
}

class _AddcoursesqladdquestionlistitemState
    extends State<Addcoursesqladdquestionlistitem> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onLongPress: () {
        removeQuestionItem(context);
      },
      child: Column(
        children: [
          SQLTestQuestionInputs(
            coursetestquestionentity: widget.coursetestquestionentity,
            courseTestEntity: widget.coursetestentity,
          ),
          const SizedBox(
            height: 5,
          ),
          Addcoursesqladdquestionimage(
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
