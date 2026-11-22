import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:sintir/Core/entities/CourseEntities/CourseEntity.dart';
import 'package:sintir/Core/helper/ShowSnackBar.dart';
import 'package:sintir/Core/widgets/CustomButton.dart';
import 'package:sintir/Core/widgets/Custom_Loading_Widget.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/manager/UpdateCourseCubit/Update_Course_Cubit.dart';
import 'package:sintir/constant.dart';
import 'package:sintir/locale_keys.dart';

class EditCourseSaveButton extends StatelessWidget {
  const EditCourseSaveButton({
    super.key,
    required this.course,
    required this.formKey,
  });
  final CourseEntity course;
  final GlobalKey<FormState> formKey;
  @override
  Widget build(BuildContext context) {
    return BlocSelector<UpdateCourseCubit, UpdateCourseState, bool>(
      selector: (state) {
        return state is UpdateCourseLoading;
      },
      builder: (context, isLoading) {
        return Custom_Loading_Widget(
          isLoading: isLoading ? true : false,
          child: Custombutton(
            text: LocaleKeys.save,
            color: KMainColor,
            textColor: Colors.white,
            onPressed: () {
              if (isLoading) return;
              if (formKey.currentState != null) {
                if (formKey.currentState!.validate()) {
                  formKey.currentState!.save();
                  context.read<UpdateCourseCubit>().updateCourse(
                    courseEntity: course,
                  );
                }
              } else {
                CustomSnackBar.show(
                  context,
                  message: LocaleKeys.fileSelectionError,
                  type: SnackType.error,
                );
              }
            },
          ),
        );
      },
    );
  }
}
