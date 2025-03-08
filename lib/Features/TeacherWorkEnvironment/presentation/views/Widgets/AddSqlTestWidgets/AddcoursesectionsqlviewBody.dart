// ignore_for_file: must_be_immutable, file_names

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sintir/Core/entities/CourseEntity.dart';
import 'package:sintir/Core/utils/Variables.dart';
import 'package:sintir/Features/Course%20Management%20and%20Interaction%20Feature/domain/Entities/CourseTestEntity.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/Widgets/AddSqlTestWidgets/AddCourseSectionSQlTestListView.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/Widgets/AddSqlTestWidgets/AddCourseSectionSqlTestAddQuestionsActionbutton.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/Widgets/AddcoursesectionviewWidgets/CustomAddCourseSectionSqlNameAndDuration.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/manager/AddCourseSectionCubit/AddCourseSectionCubit.dart';
import 'package:sintir/constant.dart';

class AddcoursesectionsqlviewBody extends StatelessWidget {
  const AddcoursesectionsqlviewBody({super.key, required this.courseEntity});
  final CourseEntity courseEntity;
  @override
  Widget build(BuildContext context) {
    Coursetestentity coursetestentity =
        context.read<AddCourseSectionCubit>().coursetestentity;

    return BlocBuilder<AddCourseSectionCubit, AddCourseSectionState>(
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
                      questions: coursetestentity.questions,
                    )
                  ],
                ),
                AddCourseSectionSqlTestActionbuttons(
                  courseEntity: courseEntity,
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
