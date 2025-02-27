// ignore_for_file: must_be_immutable, file_names

import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sintir/Core/utils/Variables.dart';
import 'package:sintir/Features/Course%20Management%20and%20Interaction%20Feature/data/models/CourseTestModel.dart';
import 'package:sintir/Features/Course%20Management%20and%20Interaction%20Feature/domain/Entities/CourseTestEntity.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/Widgets/AddcoursesectionviewWidgets/AddCourseSectionSQlTestListView.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/Widgets/AddcoursesectionviewWidgets/AddCourseSectionSqlTestAddQuestionsActionbutton.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/Widgets/AddcoursesectionviewWidgets/CustomAddCourseSectionSqlNameAndDuration.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/manager/add_sql_test_cubit/add_sql_test_cubit.dart';
import 'package:sintir/constant.dart';

class AddcoursesectionsqlviewBody extends StatelessWidget {
  const AddcoursesectionsqlviewBody({super.key});

  @override
  Widget build(BuildContext context) {
    Coursetestentity coursetestentity =
        context.read<AddSQlTestCubit>().coursetestentity;

    return BlocBuilder<AddSQlTestCubit, AddSQlTestState>(
      builder: (context, state) {
        return Form(
          key: Variables.AddCourseSectionSqlFormKey,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: KHorizontalPadding),
            child: Stack(
              children: [
                CustomScrollView(
                  slivers: [
                    SliverToBoxAdapter(
                      child: AddCourseSectionSqlTestAddQuestionsActionbutton(
                        onPressed: () {
                          Variables.AddCourseSectionSqlFormKey.currentState!
                              .save();
                          log(Coursetestmodel.fromEntity(coursetestentity)
                              .toJson()
                              .toString());
                        },
                      ),
                    ),
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
                      questions: coursetestentity.questions,
                    )
                  ],
                ),
                AddCourseSectionSqlTestAddQuestionsActionbutton(
                  onPressed: () {
                    context.read<AddSQlTestCubit>().addNewQuestion();
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
