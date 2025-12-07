// ignore_for_file: must_be_immutable, file_names

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sintir/Core/entities/CourseEntities/CourseTestItemEntities/CourseTestEntity.dart';
import 'package:sintir/Core/entities/CourseEntities/CourseTestItemEntities/CourseTestQuestionEntity.dart';
import 'package:sintir/Core/entities/CourseEntities/CourseTestItemEntities/CourseTestQuestionSolutionEntity.dart';
import 'package:sintir/Core/utils/Variables.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/domain/Entities/OptionNavigationRequirementsEntity.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/Widgets/AddExamWidgets/AddCourseSectionExamActionButtons.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/Widgets/AddExamWidgets/CustomAddExamStepsPageView.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/Widgets/AddExamWidgets/CustomAddExamStepsRow.dart';

class AddCourseSectionExamViewBody extends StatefulWidget {
  const AddCourseSectionExamViewBody({
    super.key,
  });

  @override
  State<AddCourseSectionExamViewBody> createState() =>
      _AddCourseSectionExamViewBodyState();
}

class _AddCourseSectionExamViewBodyState
    extends State<AddCourseSectionExamViewBody> {
  late CourseTestEntity coursetestentity;
  final GlobalKey<FormState> examDetailsFormKey = GlobalKey<FormState>();
  final GlobalKey<FormState> questionsFormKey = GlobalKey<FormState>();
  final PageController pageController = PageController();

  final ValueNotifier<int> currentIndexNotifier = ValueNotifier<int>(0);

  @override
  void initState() {
    super.initState();
    coursetestentity = CourseTestEntity(
      type: "Test",
      showResult: true,
      numberOfAttempts: null,
      id: "${DateTime.now().toIso8601String()}-Test",
      questions: [
        CourseTestQuestionEntity(
            isOpened: false,
            questionTitle: "",
            solutions: [
              CourseTestQuestionSolutionEntity(answer: "", isCorrect: false)
            ])
      ],
      title: "",
      durationTime: 0,
    );
    pageController.addListener(() {
      int next = pageController.page?.round() ?? 0;
      if (currentIndexNotifier.value != next) {
        currentIndexNotifier.value = next;
      }
    });
  }

  @override
  void dispose() {
    pageController.dispose();
    currentIndexNotifier.dispose();
    coursetestentity.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final requirements = context.watch<OptionNavigationRequirementsEntity>();
    return Form(
      key: Variables.AddCourseSectionExamFormKey,
      child: Column(
        children: [
          ValueListenableBuilder<int>(
            valueListenable: currentIndexNotifier,
            builder: (_, index, __) => CustomAddExamStepsRow(
              pageController: pageController,
              currentStep: index,
            ),
          ),
          Expanded(
            child: Stack(
              children: [
                Positioned.fill(
                  child: CustomAddExamStepsPageView(
                    pageController: pageController,
                    courseEntity: requirements.courseEntity,
                    courseTestEntity: coursetestentity,
                    isNewSection: requirements.isNewSection,
                    section: requirements.section,
                    examDetailsFormKey: examDetailsFormKey,
                    questionsFormKey: questionsFormKey,
                  ),
                ),
                ValueListenableBuilder<int>(
                  valueListenable: currentIndexNotifier,
                  builder: (_, index, __) => AddCourseSectionExamActionButtons(
                    currentStep: index,
                    examDetailsFormKey: examDetailsFormKey,
                    questionsFormKey: questionsFormKey,
                    pageController: pageController,
                    courseTestEntity: coursetestentity,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
