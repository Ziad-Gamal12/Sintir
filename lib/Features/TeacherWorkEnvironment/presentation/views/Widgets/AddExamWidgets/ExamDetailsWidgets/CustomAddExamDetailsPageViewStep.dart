import 'package:flutter/material.dart';
import 'package:sintir/Core/entities/CourseEntities/CourseTestItemEntities/CourseTestEntity.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/Widgets/AddExamWidgets/ExamDetailsWidgets/CustomAddCourseSectionExamNameAndDuration.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/Widgets/AddExamWidgets/ExamDetailsWidgets/CustomAddCourseSectionExamNameAndDurationHeader.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/Widgets/AddExamWidgets/ExamDetailsWidgets/ExamNumbersOfAttemptsTextField.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/Widgets/AddExamWidgets/ExamDetailsWidgets/HideExamResultSwitcher.dart';
import 'package:sintir/constant.dart';

class CustomExamDetailsPageViewStep extends StatelessWidget {
  const CustomExamDetailsPageViewStep(
      {super.key,
      required this.coursetestentity,
      required this.examDetailsFormKey});
  final CourseTestEntity coursetestentity;
  final GlobalKey<FormState> examDetailsFormKey;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: KHorizontalPadding),
      child: Form(
        key: examDetailsFormKey,
        child: Column(
          children: [
            const SizedBox(
              height: 20,
            ),
            const CustomAddCourseSectionExamNameAndDurationHeader(),
            const SizedBox(
              height: 10,
            ),
            CustomAddCourseSectionExamNameAndDuration(
              coursetestentity: coursetestentity,
            ),
            const SizedBox(
              height: 20,
            ),
            ExamNumbersOfAttemptsTextField(
              coursetestentity: coursetestentity,
            ),
            const SizedBox(
              height: 20,
            ),
            HideExamResultSwitcher(
              isHiddin: !coursetestentity.showResult,
              onChanged: (value) {
                coursetestentity.showResult = !value;
              },
            )
          ],
        ),
      ),
    );
  }
}
