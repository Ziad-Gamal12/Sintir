import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:sintir/Core/utils/imageAssets.dart';
import 'package:sintir/Features/Course%20Management%20and%20Interaction%20Feature/presentation/views/CourseFilePreviewer_View.dart';

class Coursefileentity {
  final String title;
  final String filePath;
  final String description;
  String? type;
  String preffixImage = Assets.assetsImagesCustomFileIcon;

  Coursefileentity(
      {this.type = "File",
      required this.description,
      required this.title,
      required this.filePath});
  ontap({required BuildContext context, required Coursefileentity item}) {
    GoRouter.of(context).push(CoursefilepreviewerView.routename, extra: item);
  }
}
