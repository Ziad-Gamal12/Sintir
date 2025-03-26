import 'dart:io';

import 'package:flutter/material.dart';
import 'package:sintir/Core/widgets/Video%20Previewer%20Widgets/CustomDisplayingVedioWidget.dart';
import 'package:sintir/Features/Course%20Management%20and%20Interaction%20Feature/domain/Entities/CourseVedioItemEntity.dart';

class VideoPreviewWidget extends StatelessWidget {
  final File videoFile;
  final Coursevedioitementity coursevedioitementity;

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
