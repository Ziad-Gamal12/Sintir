import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/Widgets/AddCourseViewWidgets/AddCoursePoster.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/manager/AddCourseCubit/add_course_cubit.dart';

import 'course_code_input.dart';
import 'course_description_input.dart';
import 'course_language_selector.dart';
import 'course_level_selector.dart';
import 'course_price_input.dart';
import 'course_subject_selector.dart';
import 'course_title_input.dart';

class CourseInputsCard extends StatelessWidget {
  final TextEditingController titleController;
  final TextEditingController descriptionController;
  final TextEditingController priceController;

  final ValueChanged<String?> onLevelChange;
  final ValueChanged<String?> onSubjectChange;
  final ValueChanged<String?> onLanguageChange;

  const CourseInputsCard({
    super.key,
    required this.titleController,
    required this.descriptionController,
    required this.priceController,
    required this.onLevelChange,
    required this.onSubjectChange,
    required this.onLanguageChange,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: 14,
      children: [
        CourseTitleInput(controller: titleController),
        CourseDescriptionInput(controller: descriptionController),
        CoursePriceInput(controller: priceController),
        CourseLevelSelector(onChanged: onLevelChange),
        Row(
          spacing: 14,

          children: [
            Expanded(
              child: Column(
                children: [
                  CourseSubjectSelector(onChanged: onSubjectChange),
                  const SizedBox(height: 14),
                  CourseLanguageSelector(onChanged: onLanguageChange),
                ],
              ),
            ),
            Expanded(
              child: Addcourseposter(
                coursePosterImage: context
                    .watch<AddCourseCubitCubit>()
                    .coursePosterImage,
                onTap: () {
                  context.read<AddCourseCubitCubit>().pickCoursePosterImage();
                },
              ),
            ),
          ],
        ),
      ],
    );
  }
}
