// ignore_for_file: must_be_immutable, file_names

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sintir/Core/Managers/Cubits/test_item_cubit/test_item_cubit.dart';
import 'package:sintir/Core/entities/CourseEntities/CourseTestItemEntities/CourseTestEntity.dart';
import 'package:sintir/Core/entities/CourseEntities/CourseTestItemEntities/CourseTestQuestionEntity.dart';
import 'package:sintir/Core/entities/CourseEntities/CourseTestItemEntities/CourseTestQuestionSolutionEntity.dart';
import 'package:sintir/Core/utils/Variables.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/Widgets/AddExamWidgets/AddCourseSectionExamActionButtons.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/Widgets/AddExamWidgets/AddCourseSectionExamListview.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/Widgets/AddExamWidgets/AddCourseSectionExamListviewHeader.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/Widgets/AddExamWidgets/AddQuestionButton.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/Widgets/AddExamWidgets/CustomAddCourseSectionExamNameAndDurationHeader.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/Widgets/AddcoursesectionviewWidgets/CustomAddCourseSectionExamNameAndDuration.dart';
import 'package:sintir/constant.dart';

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
  CourseTestEntity coursetestentity = CourseTestEntity(
    type: "Test",
    id: "${DateTime.now().toIso8601String()}-Test",
    questions: [
      CourseTestQuestionEntity(isOpened: false, questionTitle: "", solutions: [
        Coursetestquestionsolutionentity(answer: "", isCorrect: false)
      ])
    ],
    title: Variables.AddExamName.text,
    durationTime: int.tryParse(Variables.AddExamDuration.text) ?? 0,
  );

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TestItemCubit, TestItemState>(
      builder: (context, state) {
        return Form(
          key: Variables.AddCourseSectionExamFormKey,
          child: Stack(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: KHorizontalPadding,
                  vertical: 10,
                ),
                child: CustomScrollView(
                  slivers: [
                    const SliverToBoxAdapter(
                      child: CustomAddCourseSectionExamNameAndDurationHeader(),
                    ),
                    SliverToBoxAdapter(
                      child: CustomAddCourseSectionExamNameAndDuration(
                        coursetestentity: coursetestentity,
                      ),
                    ),
                    const SliverToBoxAdapter(
                        child: AddCourseSectionExamListviewHeader()),
                    AddCourseSectionExamListview(
                      coursetestentity: coursetestentity,
                    ),
                    SliverToBoxAdapter(
                      child:
                          AddQuestionButton(coursetestentity: coursetestentity),
                    )
                  ],
                ),
              ),
              AddCourseSectionExamActionButtons(
                courseTestEntity: coursetestentity,
              ),
            ],
          ),
        );
      },
    );
  }
}
