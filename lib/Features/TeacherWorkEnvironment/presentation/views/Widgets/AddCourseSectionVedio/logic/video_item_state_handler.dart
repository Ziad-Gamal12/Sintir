import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sintir/Core/Managers/Cubits/CourseSectionsCubit/CourseSectionsCubit.dart';
import 'package:sintir/Core/Managers/Cubits/video_item_cubit/video_item_cubit.dart';
import 'package:sintir/Core/entities/CourseEntities/CourseVideoItemEntities/VideoUploadSessionEntity.dart';
import 'package:sintir/Core/helper/ShowSnackBar.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/domain/Entities/OptionNavigationRequirementsEntity.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/Widgets/CourseDetailViewWidgets/CourseDetailsCourseSections_SectionWidgets/CourseDetailsCourseSectionsView.dart';
import 'package:sintir/locale_keys.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/Widgets/AddCourseSectionVedio/controllers/add_video_form_controller.dart';

/// Side effects of [VideoItemCubit] states: snackbars, navigation, syncing the
/// form, and the step that adds the uploaded video to the course section.
class VideoItemStateHandler {
  const VideoItemStateHandler(this.context, this.form);

  final BuildContext context;
  final AddVideoFormController form;

  void handle(VideoItemState state) {
    switch (state) {
      case PickVideoFileSuccess(:final file):
        form.selectFile(file);
      case PickVideoFileFailure(:final errMessage):
        _showError(errMessage);
      case UploadVideoLoading():
        form.pausePreview();
      case UploadVideoSuccess(:final session):
        _addUploadedVideo(session);
      case UploadVideoFailure(:final errMessage):
        _showError(errMessage);
      case AddVideoItemSuccess():
        CustomSnackBar.show(
          context,
          message: LocaleKeys.videoAddedSuccessfully,
          type: SnackType.success,
        );
        Navigator.popUntil(
          context,
          ModalRoute.withName(CourseDetailsCourseSectionsView.routeName),
        );
      case AddVideoItemFailure(:final errMessage):
        _showError(errMessage);
      default:
        break;
    }
  }

  void _showError(String message) {
    CustomSnackBar.show(context, message: message, type: SnackType.error);
  }

  void _addUploadedVideo(VideoUploadSessionEntity session) {
    final option = context.read<OptionNavigationRequirementsEntity>();
    final video = form.video
      ..vedioUrl = ''
      ..id = session.videoId
      ..videoProvider = 'mux'
      ..muxUploadId = session.uploadId
      ..status = 'uploading'
      ..type = 'Video';

    if (option.isNewSection == true) {
      context.read<CourseSectionsCubit>().addCourseSection(
            sectionItem: video,
            courseId: option.courseEntity.id,
            section: option.section,
          );
    } else {
      context.read<VideoItemCubit>().addVideoItem(
            courseId: option.courseEntity.id,
            sectionId: option.section.id,
            video: video,
          );
    }
  }
}
