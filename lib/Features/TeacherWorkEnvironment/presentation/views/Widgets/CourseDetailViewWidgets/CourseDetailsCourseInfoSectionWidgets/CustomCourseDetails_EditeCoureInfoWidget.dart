// ignore_for_file: must_be_immutable, file_names

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:sintir/Core/entities/CourseEntities/CourseEntity.dart';
import 'package:sintir/Core/helper/ShowSnackBar.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/Widgets/CourseDetailViewWidgets/CourseDetailsCourseInfoSectionWidgets/EditCourseInfoSectionHeader.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/Widgets/CourseDetailViewWidgets/CourseDetailsCourseInfoSectionWidgets/edit_course_description_field.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/Widgets/CourseDetailViewWidgets/CourseDetailsCourseInfoSectionWidgets/edit_course_poster.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/Widgets/CourseDetailViewWidgets/CourseDetailsCourseInfoSectionWidgets/edit_course_save_button.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/Widgets/CourseDetailViewWidgets/CourseDetailsCourseInfoSectionWidgets/edit_course_title_field.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/manager/UpdateCourseCubit/Update_Course_Cubit.dart';
import 'package:sintir/locale_keys.dart';

class EditCourseInfoSection extends StatelessWidget {
  EditCourseInfoSection({super.key, required this.course});
  final CourseEntity course;
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  File? coursePoster;
  @override
  Widget build(BuildContext context) {
    return BlocListener<UpdateCourseCubit, UpdateCourseState>(
        listener: (context, state) {
          if (state is UpdateCourseSuccess) {
            GoRouter.of(context).pop();
            CustomSnackBar.show(
              context,
              message: LocaleKeys.operationSuccessful,
              type: SnackType.success,
            );
          } else if (state is UpdateCourseFailure) {
            CustomSnackBar.show(
              context,
              message: state.errmessage,
              type: SnackType.error,
            );
          } else if (state is UpdateCourseCubitAssetPicked) {
            coursePoster = state.file;
          } else if (state is UpdateCourseCubitAssetFailure) {
            CustomSnackBar.show(
              context,
              message: state.errmessage,
              type: SnackType.error,
            );
          }
        },
        child: Provider.value(
          value: course,
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Form(
              key: formKey,
              child: Column(
                children: [
                  const EditCourseInfoSectionHeader(),
                  const SizedBox(height: 20),
                  const EditCourseTitleField(),
                  const SizedBox(height: 10),
                  const EditCourseDescriptionField(),
                  const SizedBox(height: 20),
                  EditCoursePoster(
                    coursePosterUrl: course.posterUrl ?? "",
                  ),
                  const SizedBox(height: 40),
                  EditCourseSaveButton(
                    formKey: formKey,
                    course: course,
                  ),
                ],
              ),
            ),
          ),
        ));
  }
}
