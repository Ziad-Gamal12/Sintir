import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:sintir/Core/Managers/Cubits/CourseSectionsCubit/CourseSectionsCubit.dart';
import 'package:sintir/Core/Managers/Cubits/file_item_cubit/file_item_cubit.dart';
import 'package:sintir/Core/entities/CourseEntities/CourseEntity.dart';
import 'package:sintir/Core/helper/ShowSnackBar.dart';
import 'package:sintir/Core/widgets/AwesomeDialog.dart';
import 'package:sintir/Features/Course%20Management%20and%20Interaction%20Feature/domain/Entities/CourseFileEntity.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/domain/Entities/OptionNavigationRequirementsEntity.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/Widgets/CourseDetailViewWidgets/CourseDetailsCourseSections_SectionWidgets/CourseDetailsCourseSectionsView.dart';

class FileItemStateHandler {
  final BuildContext context;
  final CourseFileEntity fileEntity;
  final GlobalKey<FormState> formKey;
  final CourseEntity courseEntity;

  FileItemStateHandler(
    this.context,
    this.fileEntity,
    this.courseEntity,
    this.formKey,
  );

  void handle(FileItemState state) {
    switch (state) {
      case AddFileItemFailure(:final errMessage):
        errordialog(context, errMessage).show();
        break;

      case AddFileItemSuccess():
        successdialog(
          context: context,
          SuccessMessage: "تم اضافة الملف بنجاح",
          btnOkOnPress: () => context.go(
              CourseDetailsCourseSectionsView.routeName,
              extra: courseEntity),
        ).show();
        break;

      case PickFileSuccess(:final file):
        fileEntity.file = file;
        break;

      case PickFileFailure():
        ShowErrorSnackBar(
          context: context,
          message: "حدث خطأ في اختيار الملف",
        );
        break;

      case UplaodFileSuccess(:final url):
        _onUploadSuccess(url);
        break;

      case UplaodFileFailure(:final errMessage):
        ShowErrorSnackBar(
          context: context,
          message: errMessage,
        );
        break;

      default:
        break;
    }
  }

  void _onUploadSuccess(String url) {
    formKey.currentState?.save();

    final option = context.read<OptionNavigationRequirementsEntity>();
    fileEntity.fileUrl = url;

    if (option.isNewSection) {
      context.read<CourseSectionsCubit>().addCourseSection(
            sectionItem: fileEntity,
            courseId: option.courseEntity.id,
            section: option.section,
          );
    } else {
      context.read<CourseSectionsCubit>().addSectionItem(
            courseId: option.courseEntity.id,
            sectionId: option.section.id,
            sectionItem: fileEntity,
          );
    }
  }
}
