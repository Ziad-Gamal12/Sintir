import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:sintir/Core/Managers/Cubits/CourseSectionsCubit/CourseSectionsCubit.dart';
import 'package:sintir/Core/Managers/Cubits/video_item_cubit/video_item_cubit.dart';
import 'package:sintir/Core/entities/CourseEntities/CourseVideoItemEntities/CourseVedioItemEntity.dart';
import 'package:sintir/Core/helper/ShowSnackBar.dart';
import 'package:sintir/Core/utils/Variables.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/domain/Entities/OptionNavigationRequirementsEntity.dart';

class VideoItemStateHandler {
  final BuildContext context;
  final CourseVideoItemEntity videoEntity;

  VideoItemStateHandler(this.context, this.videoEntity);

  void handle(VideoItemState state) {
    switch (state) {
      case AddVideoItemFailure(:final errMessage):
        ShowErrorSnackBar(context: context, message: errMessage);
        break;

      case AddVideoItemSuccess():
        showSuccessSnackBar(context: context, message: "تم اضافة الملف بنجاح");
        GoRouter.of(context).pop();
        break;

      case PickVideoFileSuccess(:final file):
        videoEntity.file = file;
        break;

      case PickVideoFileFailure():
        ShowErrorSnackBar(
          context: context,
          message: "حدث خطأ في اختيار الملف",
        );
        break;

      case UploadVideoSuccess(:final url):
        _onUploadSuccess(url);
        break;

      case UploadVideoFailure(:final errMessage):
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
    Variables.AddCourseSectionVideoItemFormKey.currentState?.save();
    final option = context.read<OptionNavigationRequirementsEntity>();
    videoEntity.vedioUrl = url;
    if (option.isNewSection == true) {
      context.read<CourseSectionsCubit>().addCourseSection(
            sectionItem: videoEntity,
            courseId: option.courseEntity.id,
            section: option.section,
          );
    } else {
      context.read<VideoItemCubit>().addVideoItem(
            courseId: option.courseEntity.id,
            sectionId: option.section.id,
            video: videoEntity,
          );
    }
  }
}
