import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sintir/Core/Managers/Cubits/CourseSectionsCubit/CourseSectionsCubit.dart';
import 'package:sintir/Core/Managers/Cubits/video_item_cubit/video_item_cubit.dart';
import 'package:sintir/Core/entities/CourseEntities/CourseVideoItemEntities/CourseVedioItemEntity.dart';
import 'package:sintir/Core/helper/ShowSnackBar.dart';
import 'package:sintir/Core/utils/Variables.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/domain/Entities/OptionNavigationRequirementsEntity.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/Widgets/CourseDetailViewWidgets/CourseDetailsCourseSections_SectionWidgets/CourseDetailsCourseSectionsView.dart';

class VideoItemStateHandler {
  final BuildContext context;
  final CourseVideoItemEntity videoEntity;

  VideoItemStateHandler(this.context, this.videoEntity);

  void handle(VideoItemState state) {
    switch (state) {
      case AddVideoItemFailure(:final errMessage):
        CustomSnackBar.show(
          context,
          message: errMessage,
          type: SnackType.error,
        );
        break;

      case AddVideoItemSuccess():
        CustomSnackBar.show(
          context,
          message: "تم اضافة الفيديو بنجاح",
          type: SnackType.success,
        );
        Navigator.popUntil(context,
            ModalRoute.withName(CourseDetailsCourseSectionsView.routeName));
        break;

      case PickVideoFileSuccess(:final file):
        videoEntity.file = file;
        break;

      case PickVideoFileFailure():
        CustomSnackBar.show(
          context,
          message: "حدث خطاء في تحميل الفيديو",
          type: SnackType.error,
        );
        break;

      case UploadVideoSuccess(:final url):
        _onUploadSuccess(url);
        break;

      case UploadVideoFailure(:final errMessage):
        CustomSnackBar.show(
          context,
          message: errMessage,
          type: SnackType.error,
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
