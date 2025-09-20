import 'dart:io';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:sintir/Core/entities/CourseEntities/CourseEntity.dart';
import 'package:sintir/Core/entities/CourseEntities/CourseVideoItemEntities/CourseVideoviewnavigationsrequirmentsentity.dart';
import 'package:sintir/Core/utils/imageAssets.dart';
import 'package:sintir/Features/Course%20Management%20and%20Interaction%20Feature/presentation/views/displayCourseVedioVeiw.dart';

class CourseVideoItemEntity {
  String title, vedioUrl;
  int durationTime;
  String id;
  File? file;
  String? type;
  String preffixImage = Assets.assetsImagesVideoIcon;
  void ontap(
      {required BuildContext context,
      required Coursevideoviewnavigationsrequirmentsentity requires,
      required CourseEntity course}) {
    GoRouter.of(context)
        .push(Displaycoursevedioveiw.routeName, extra: requires);
  }

  CourseVideoItemEntity(
      {required this.title,
      required this.vedioUrl,
      required this.id,
      required this.durationTime,
      this.file,
      this.type = "Video"});
}
