import 'dart:io';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:sintir/Core/entities/CourseEntity.dart';
import 'package:sintir/Core/utils/imageAssets.dart';
import 'package:sintir/Features/Course%20Management%20and%20Interaction%20Feature/domain/Entities/CourseVideoviewnavigationsrequirmentsentity.dart';
import 'package:sintir/Features/Course%20Management%20and%20Interaction%20Feature/domain/Entities/JoinedByEntity.dart';
import 'package:sintir/Features/Course%20Management%20and%20Interaction%20Feature/presentation/manager/update_course_sections_cubit/updatecoursesectionsCubit.dart';
import 'package:sintir/Features/Course%20Management%20and%20Interaction%20Feature/presentation/views/displayCourseVedioVeiw.dart';

class Coursevedioitementity {
  String title, vedioUrl;
  int durationTime;
  List<JoinedByEntity> joinedBy;
  File? file;
  String? type;
  String preffixImage = Assets.assetsImagesVedioIcon;
  ontap(
      {required BuildContext context,
      required Coursevideoviewnavigationsrequirmentsentity requires,
      required CourseEntity course}) {
    addJoinedBy(
        joinedByEntity: context
            .read<UpdateCourseSectionsCubit>()
            .getJoinedByEntity(context));
    context
        .read<UpdateCourseSectionsCubit>()
        .updateCourseSections(course: course);
    GoRouter.of(context)
        .push(Displaycoursevedioveiw.routeName, extra: requires);
  }

  addJoinedBy({required JoinedByEntity joinedByEntity}) =>
      joinedBy.add(joinedByEntity);
  Coursevedioitementity(
      {required this.title,
      required this.vedioUrl,
      required this.joinedBy,
      required this.durationTime,
      this.file,
      this.type = "Vedio"});
}
