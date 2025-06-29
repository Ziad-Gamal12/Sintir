import 'dart:io';

import 'package:flutter/material.dart';
import 'package:sintir/Core/entities/CourseEntities/CourseVideoItemEntities/CourseVedioItemEntity.dart';
import 'package:sintir/Core/widgets/Video%20Previewer%20Widgets/CustomDisplayingVedioWidget.dart';

class VideoPreviewWidget extends StatelessWidget {
  final File videoFile;
  final CourseVideoItemEntity coursevedioitementity;

  const VideoPreviewWidget(
      {required this.videoFile,
      super.key,
      required this.coursevedioitementity});

  @override
  Widget build(BuildContext context) {
    return CustomDisplayingVideoWidget(
      durtationChanged: (value) {
        coursevedioitementity.durationTime = value;
      },
      file: videoFile,
    );
  }
}
