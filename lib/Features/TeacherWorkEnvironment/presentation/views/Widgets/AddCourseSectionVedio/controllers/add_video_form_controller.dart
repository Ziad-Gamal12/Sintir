import 'dart:io';

import 'package:flutter/material.dart';
import 'package:sintir/Core/entities/CourseEntities/CourseVideoItemEntities/CourseVedioItemEntity.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/Widgets/AddCourseSectionVedio/controllers/video_preview_controller.dart';

/// Everything the "add video" form owns, in one disposable object: the title,
/// the picked video (with its preview), the comments switch, and the entity
/// that is finally uploaded. Widgets listen only to the piece they need, so
/// nothing here calls setState and the whole screen never rebuilds.
class AddVideoFormController {
  AddVideoFormController()
      : video = CourseVideoItemEntity(
          title: '',
          vedioUrl: '',
          durationTime: 0,
          id: '${DateTime.now().toIso8601String()}-Video',
        );

  static const int maxTitleLength = 80;

  final CourseVideoItemEntity video;
  final formKey = GlobalKey<FormState>();
  final titleController = TextEditingController();
  final preview = ValueNotifier<VideoPreviewController?>(null);
  final allowComments = ValueNotifier<bool>(true);

  bool isLeaveDialogOpen = false;

  late final Listenable changes =
      Listenable.merge([titleController, preview, allowComments]);

  File? get file => preview.value?.file;
  bool get hasTitle => titleController.text.trim().isNotEmpty;
  bool get canSubmit => hasTitle && file != null;
  bool get isDirty => hasTitle || file != null || !allowComments.value;

  void selectFile(File file) {
    final previous = preview.value;
    video.file = file;
    preview.value = VideoPreviewController(
      file,
      onDurationReady: _saveDuration,
    );
    previous?.dispose();
  }

  void clearFile() {
    final previous = preview.value;
    video
      ..file = null
      ..durationTime = 0;
    preview.value = null;
    previous?.dispose();
  }

  void pausePreview() => preview.value?.pause();

  bool validate() =>
      (formKey.currentState?.validate() ?? false) && file != null;

  CourseVideoItemEntity prepareForUpload() =>
      video..title = titleController.text.trim();

  // Same rule the old preview widget used: whole minutes, rounded up.
  void _saveDuration(Duration duration) =>
      video.durationTime = (duration.inSeconds / 60).ceil();

  void dispose() {
    titleController.dispose();
    allowComments.dispose();
    preview.value?.dispose();
    preview.dispose();
  }
}
