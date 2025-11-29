import 'package:flutter/material.dart';
import 'package:sintir/Core/Managers/Cubits/CourseSectionsCubit/CourseSectionsCubit.dart';
import 'package:sintir/Core/entities/CourseEntities/CourseEntity.dart';
import 'package:sintir/Core/helper/ShowSnackBar.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/Widgets/CourseDetailViewWidgets/CourseDetailsCourseSections_SectionWidgets/CourseDetailsCourseSectionsView.dart';
import 'package:sintir/locale_keys.dart';

class CourseSectionStateHandler {
  final BuildContext context;
  final CourseEntity courseEntity;

  CourseSectionStateHandler(this.context, this.courseEntity);

  void handle(CourseSectionsState state) {
    switch (state) {
      case AddCourseSectionFailure(:final errMessage):
        CustomSnackBar.show(
          context,
          message: errMessage,
          type: SnackType.error,
        );
        break;

      case AddCourseSectionSuccess():
        CustomSnackBar.show(
          context,
          message: LocaleKeys.sectionAddedSuccessfully,
          type: SnackType.success,
        );
        Navigator.popUntil(context,
            ModalRoute.withName(CourseDetailsCourseSectionsView.routeName));

        break;

      default:
        break;
    }
  }
}
