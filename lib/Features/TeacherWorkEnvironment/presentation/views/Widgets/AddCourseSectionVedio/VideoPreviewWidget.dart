import 'dart:io';

import 'package:flutter/material.dart';
import 'package:sintir/Core/entities/CourseEntities/CourseVideoItemEntities/CourseVedioItemEntity.dart';
import 'package:sintir/Core/widgets/VideoPreviewerWidgets/CustomDisplayingVedioWidget.dart';

class VideoPreviewWidget extends StatelessWidget {
  final File videoFile;
  final CourseVideoItemEntity coursevedioitementity;

  const VideoPreviewWidget(
      {required this.videoFile,
      super.key,
      required this.coursevedioitementity});

  @override
  Widget build(BuildContext context) {
    return PremiumVideoPlayer(
      onDurationChanged: (value) {
        final totalSeconds = value.inSeconds;

        final minutes = totalSeconds / 60;

        coursevedioitementity.durationTime = minutes.ceil();
      },
      file: videoFile,
    );
  }
}
