import 'dart:io';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:sintir/Core/entities/CourseEntities/CourseEntity.dart';
import 'package:sintir/Core/utils/imageAssets.dart';
import 'package:sintir/Features/Course%20Management%20and%20Interaction%20Feature/domain/Entities/CourseFileviewnavigationsrequirmentsentity.dart';
import 'package:sintir/Features/Course%20Management%20and%20Interaction%20Feature/presentation/views/CourseFilePreviewer_View.dart';

class CourseFileEntity {
  String title;
  String fileUrl;
  String description;
  String id;
  File? file;
  String? type;
  String preffixImage = Assets.assetsIconsSVGIconsCustomFileIcon;

  CourseFileEntity(
      {this.type = "File",
      required this.description,
      required this.title,
      required this.id,
      this.file,
      required this.fileUrl});
  void ontap(
      {required BuildContext context,
      required Coursefileviewnavigationsrequirmentsentity item,
      required CourseEntity course}) {
    GoRouter.of(context).push(CoursefilepreviewerView.routename, extra: item);
  }
}
