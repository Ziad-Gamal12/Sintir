import 'dart:io';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:sintir/Core/utils/imageAssets.dart';
import 'package:sintir/Features/Course%20Management%20and%20Interaction%20Feature/presentation/views/CourseFilePreviewer_View.dart';

class Coursefileentity {
  String title;
  String fileUrl;
  String description;
  File? file;
  String? type;
  String preffixImage = Assets.assetsImagesCustomFileIcon;

  Coursefileentity(
      {this.type = "File",
      required this.description,
      required this.title,
      this.file,
      required this.fileUrl});
  ontap({required BuildContext context, required Coursefileentity item}) {
    GoRouter.of(context).push(CoursefilepreviewerView.routename, extra: item);
  }
}
