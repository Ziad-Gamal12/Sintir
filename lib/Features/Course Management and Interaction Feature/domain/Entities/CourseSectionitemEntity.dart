import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:sintir/Core/utils/Backend_EndPoints.dart';
import 'package:sintir/Features/Course%20Management%20and%20Interaction%20Feature/presentation/views/courseTestView.dart';
import 'package:sintir/Features/Course%20Management%20and%20Interaction%20Feature/presentation/views/displayCourseVedioVeiw.dart';

class CourseSectionitemEntity {
  final String preffixImage;
  final String title;
  final int durationTime;
  final String itemType;

  CourseSectionitemEntity(
      {required this.preffixImage,
      required this.itemType,
      required this.title,
      required this.durationTime});
  VoidCallback navigationScreen({required BuildContext context}) {
    if (itemType == BackendEndpoints.vedioType) {
      return () {
        GoRouter.of(context).push(Displaycoursevedioveiw.routeName);
      };
    } else if (itemType == BackendEndpoints.testType) {
      return () {
        GoRouter.of(context).push(Coursetestview.routename);
      };
    } else {
      return () {
        GoRouter.of(context).pop();
      };
    }
  }
}
