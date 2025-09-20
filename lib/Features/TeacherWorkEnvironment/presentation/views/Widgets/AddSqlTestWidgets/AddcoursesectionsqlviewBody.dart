// ignore_for_file: must_be_immutable, file_names

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sintir/Core/Managers/Cubits/test_item_cubit/test_item_cubit.dart';
import 'package:sintir/Core/entities/CourseEntities/CourseTestItemEntities/CourseTestEntity.dart';
import 'package:sintir/Core/entities/CourseEntities/CourseTestItemEntities/CourseTestQuestionEntity.dart';
import 'package:sintir/Core/entities/CourseEntities/CourseTestItemEntities/CourseTestQuestionSolutionEntity.dart';
import 'package:sintir/Core/utils/Variables.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/Widgets/AddSqlTestWidgets/AddCourseSectionSQlTestListView.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/Widgets/AddSqlTestWidgets/AddCourseSectionSqlTestAddQuestionsActionbutton.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/Widgets/AddcoursesectionviewWidgets/CustomAddCourseSectionSqlNameAndDuration.dart';
import 'package:sintir/constant.dart';

class AddcoursesectionsqlviewBody extends StatelessWidget {
  const AddcoursesectionsqlviewBody({
    super.key,
  });
  @override
  Widget build(BuildContext context) {
    CourseTestEntity coursetestentity = CourseTestEntity(
      type: "Test",
      id: "${DateTime.now().toIso8601String()}-Test",
      questions: [
        CourseTestQuestionEntity(
            isOpened: false,
            questionTitle: "",
            solutions: [
              Coursetestquestionsolutionentity(answer: "0", isCorrect: false)
            ])
      ],
      title: Variables.AddsqlTestName.text,
      durationTime: int.tryParse(Variables.AddsqlTestDuration.text) ?? 0,
    );
    return BlocBuilder<TestItemCubit, TestItemState>(
      builder: (context, state) {
        return Form(
          key: Variables.AddCourseSectionSQLtestFormKey,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: KHorizontalPadding),
            child: Stack(
              children: [
                CustomScrollView(
                  slivers: [
                    SliverToBoxAdapter(
                      child: CustomAddCourseSectionSqlNameAndDuration(
                        coursetestentity: coursetestentity,
                      ),
                    ),
                    const SliverToBoxAdapter(
                      child: SizedBox(
                        height: 10,
                      ),
                    ),
                    Addcoursesectionsqltestlistview(
                      coursetestentity: coursetestentity,
                    )
                  ],
                ),
                AddCourseSectionSqlTestActionbuttons(
                  courseTestEntity: coursetestentity,
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
