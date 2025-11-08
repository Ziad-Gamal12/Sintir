// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sintir/Core/entities/BottomSheetNavigationRequirmentsEntity.dart';
import 'package:sintir/Core/entities/CourseEntities/ContentCreaterEntity.dart';
import 'package:sintir/Core/utils/textStyles.dart';
import 'package:sintir/Core/widgets/CustomCourseBottomSheet/CourseContentCreatorListTile.dart';

class CourseBottomContentCreator extends StatelessWidget {
  const CourseBottomContentCreator({
    super.key,
  });
  @override
  Widget build(BuildContext context) {
    Contentcreaterentity courseContentCreater = context
        .read<DisplayCourseBottomsheetNavigationRequirmentsEntity>()
        .course
        .contentcreaterentity!;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "منشئ المحتوى",
          style:
              AppTextStyles(context).semiBold16.copyWith(color: Colors.black),
        ),
        const SizedBox(
          height: 10,
        ),
        Card(
          elevation: 4,
          color: Colors.white,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 10),
            child: CourseContentCreatorListTile(
                title: courseContentCreater.name,
                subtitle: courseContentCreater.title,
                image: courseContentCreater.profileImageUrl),
          ),
        ),
      ],
    );
  }
}
