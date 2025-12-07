import 'package:flutter/material.dart';
import 'package:sintir/Core/entities/CourseEntities/CourseEntity.dart';
import 'package:sintir/Core/entities/CourseEntities/CourseSectionEntity.dart';
import 'package:sintir/Core/entities/CourseEntities/CourseTestItemEntities/CourseTestEntity.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/domain/Entities/navigateExamReviewRequirmentsEntity.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/Widgets/AddExamWidgets/ExamDetailsWidgets/CustomAddExamDetailsPageViewStep.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/Widgets/AddExamWidgets/ExamQuestionsWidgets/CustomAddExamQuestionsPageViewStep.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/Widgets/AddExamWidgets/ReviewExamWidgets/ReviewExamSectionViewBody.dart';

class CustomAddExamStepsPageView extends StatefulWidget {
  const CustomAddExamStepsPageView(
      {super.key,
      required this.courseTestEntity,
      required this.courseEntity,
      required this.isNewSection,
      required this.examDetailsFormKey,
      required this.questionsFormKey,
      required this.pageController,
      required this.section});
  final CourseTestEntity courseTestEntity;
  final CourseEntity courseEntity;
  final bool isNewSection;
  final CourseSectionEntity section;
  final GlobalKey<FormState> examDetailsFormKey;
  final GlobalKey<FormState> questionsFormKey;
  final PageController pageController;
  @override
  State<CustomAddExamStepsPageView> createState() =>
      _CustomAddExamStepsPageViewState();
}

class _CustomAddExamStepsPageViewState
    extends State<CustomAddExamStepsPageView> {
  late List<Widget> steps;
  @override
  void initState() {
    super.initState();
    steps = [
      CustomExamDetailsPageViewStep(
        coursetestentity: widget.courseTestEntity,
        examDetailsFormKey: widget.examDetailsFormKey,
      ),
      CustomAddExamQuestionsPageViewStep(
        coursetestentity: widget.courseTestEntity,
        questionsFormKey: widget.questionsFormKey,
      ),
      ReviewExamSectionViewBody(
        navigateExamReviewRequirmentsEntity:
            NavigateExamReviewRequirmentsEntity(
          courseEntity: widget.courseEntity,
          section: widget.section,
          isNewSection: widget.isNewSection,
          coursetestentity: widget.courseTestEntity,
        ),
      )
    ];
  }

  @override
  Widget build(BuildContext context) {
    return PageView(
      controller: widget.pageController,
      children: steps,
    );
  }
}
