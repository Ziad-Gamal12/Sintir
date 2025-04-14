import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:sintir/Core/entities/CourseEntity.dart';
import 'package:sintir/Core/utils/imageAssets.dart';
import 'package:sintir/Features/Course%20Management%20and%20Interaction%20Feature/domain/Entities/CourseFileviewnavigationsrequirmentsentity.dart';
import 'package:sintir/Features/Course%20Management%20and%20Interaction%20Feature/domain/Entities/JoinedByEntity.dart';
import 'package:sintir/Features/Course%20Management%20and%20Interaction%20Feature/presentation/manager/update_course_sections_cubit/updatecoursesectionsCubit.dart';
import 'package:sintir/Features/Course%20Management%20and%20Interaction%20Feature/presentation/views/CourseFilePreviewer_View.dart';

class Coursefileentity {
  String title;
  String fileUrl;
  String description;
  List<JoinedByEntity> joinedBy;
  File? file;
  String? type;
  String preffixImage = Assets.assetsImagesCustomFileIcon;

  Coursefileentity(
      {this.type = "File",
      required this.description,
      required this.title,
      required this.joinedBy,
      this.file,
      required this.fileUrl});
  ontap(
      {required BuildContext context,
      required Coursefileviewnavigationsrequirmentsentity item,
      required CourseEntity course}) {
    addJoinedBy(
        joinedByEntity: context
            .read<UpdateCourseSectionsCubit>()
            .getJoinedByEntity(context));
    context
        .read<UpdateCourseSectionsCubit>()
        .updateCourseSections(course: course);

    GoRouter.of(context).push(CoursefilepreviewerView.routename, extra: item);
  }

  addJoinedBy({required JoinedByEntity joinedByEntity}) =>
      joinedBy.add(joinedByEntity);
}
