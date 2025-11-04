import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:sintir/Core/Managers/Cubits/CourseSectionsCubit/CourseSectionsCubit.dart';
import 'package:sintir/Core/entities/CourseEntities/CourseEntity.dart';
import 'package:sintir/Core/helper/ShowSnackBar.dart';

class CourseSectionStateHandler {
  final BuildContext context;
  final CourseEntity courseEntity;

  CourseSectionStateHandler(this.context, this.courseEntity);

  void handle(CourseSectionsState state) {
    switch (state) {
      case AddCourseSectionFailure(:final errMessage):
        ShowErrorSnackBar(context: context, message: errMessage);
        break;

      case AddCourseSectionSuccess():
        showSuccessSnackBar(context: context, message: "تمت الإضافة بنجاح");
        GoRouter.of(context).pop();

        break;

      default:
        break;
    }
  }
}
