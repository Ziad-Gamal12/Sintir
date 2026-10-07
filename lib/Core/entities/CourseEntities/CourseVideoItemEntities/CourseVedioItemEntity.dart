import 'dart:io';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:sintir/Core/entities/CourseEntities/CourseEntity.dart';
import 'package:sintir/Core/entities/CourseEntities/CourseVideoItemEntities/CourseVideoviewnavigationsrequirmentsentity.dart';
import 'package:sintir/Core/utils/imageAssets.dart';
import 'package:sintir/Features/CourseManagementAndInteractionFeature/presentation/views/displayCourseVedioVeiw.dart';

class CourseVideoItemEntity {
  String title, vedioUrl;
  int durationTime;
  String id;
  File? file;
  String? type;
  String? videoProvider, muxUploadId, muxAssetId, muxPlaybackId, status;
  List<String> availableQualities;
  String preffixImage = Assets.assetsIconsSVGIconsVideoIcon;
  void ontap(
      {required BuildContext context,
      required CourseVideoViewNavigationsRequirmentsEntity requires,
      required CourseEntity course}) {
    GoRouter.of(context)
        .push(Displaycoursevedioveiw.routeName, extra: requires);
  }

  CourseVideoItemEntity({
    required this.title,
    required this.vedioUrl,
    required this.id,
    required this.durationTime,
    this.file,
    this.type = "Video",
    this.videoProvider,
    this.muxUploadId,
    this.muxAssetId,
    this.muxPlaybackId,
    this.status,
    this.availableQualities = const [],
  });
}
