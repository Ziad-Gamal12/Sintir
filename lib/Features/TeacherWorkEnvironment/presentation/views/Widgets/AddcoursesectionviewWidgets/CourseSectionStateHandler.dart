import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:sintir/Core/Managers/Cubits/CourseSectionsCubit/CourseSectionsCubit.dart';
import 'package:sintir/Core/entities/CourseEntities/CourseEntity.dart';
import 'package:sintir/Core/widgets/AwesomeDialog.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/Widgets/CourseDetailViewWidgets/CourseDetailsCourseSections_SectionWidgets/CourseDetailsCourseSectionsView.dart';

class CourseSectionStateHandler {
  final BuildContext context;
  final CourseEntity courseEntity;

  CourseSectionStateHandler(this.context, this.courseEntity);

  void handle(CourseSectionsState state) {
    switch (state) {
      case AddCourseSectionFailure(:final errMessage):
        errordialog(context, errMessage).show();
        break;

      case AddCourseSectionSuccess():
        successdialog(
          context: context,
          SuccessMessage: "تمت الإضافة بنجاح",
          btnOkOnPress: () => context.go(
              CourseDetailsCourseSectionsView.routeName,
              extra: courseEntity),
        ).show();
        break;

      default:
        break;
    }
  }
}
