// ignore_for_file: camel_case_types, file_names

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:sintir/Core/entities/CourseEntities/CourseEntity.dart';
import 'package:sintir/Core/helper/ShowBottomSheet.dart';
import 'package:sintir/Core/utils/Variables.dart';
import 'package:sintir/Core/utils/textStyles.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/Widgets/CourseDetailViewWidgets/CourseDetailsCourseInfoSectionWidgets/CustomCourseDetails_EditeCoureInfoWidget.dart';

class CustomCourseDetailsBodyCourse_Info extends StatelessWidget {
  const CustomCourseDetailsBodyCourse_Info({
    super.key,
    required this.courseEntity,
  });

  final CourseEntity courseEntity;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
            child: ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: AspectRatio(
            aspectRatio: 150 / 180,
            child: CachedNetworkImage(
              imageUrl: courseEntity.posterUrl!,
              fit: BoxFit.cover,
            ),
          ),
        )),
        const SizedBox(
          width: 10,
        ),
        Expanded(
            child: SizedBox(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Expanded(
                    child: SizedBox(
                      child: Text(
                        courseEntity.title,
                        overflow: TextOverflow.ellipsis,
                        style: AppTextStyles(context)
                            .semiBold20
                            .copyWith(color: Colors.black),
                      ),
                    ),
                  ),
                  IconButton(
                      onPressed: () {
                        showCustomBottomSheet(
                            scaffoldKey: Variables.courseDeatilsViewScaffoldKey,
                            child: IntrinsicHeight(
                                child: EditCourseInfoSection(
                              course: courseEntity,
                            )),
                            context: context);
                      },
                      icon: const Icon(
                        Icons.edit,
                        color: Colors.black,
                      )),
                ],
              ),
              Text(
                "تاريخ اللنشر  (${courseEntity.postedDate})",
                style: AppTextStyles(context)
                    .regular10
                    .copyWith(color: const Color(0xff818181)),
              ),
              Text(
                "الوصف:",
                style: AppTextStyles(context)
                    .semiBold12
                    .copyWith(color: const Color(0xff818181)),
              ),
              Text(
                courseEntity.description,
                overflow: TextOverflow.ellipsis,
                maxLines: 6,
                style: AppTextStyles(context)
                    .regular10
                    .copyWith(color: const Color(0xff818181)),
              ),
            ],
          ),
        ))
      ],
    );
  }
}
