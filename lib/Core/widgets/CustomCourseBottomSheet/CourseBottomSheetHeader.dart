// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:sintir/Core/entities/BottomSheetNavigationRequirmentsEntity.dart';
import 'package:sintir/Core/entities/CourseEntities/ContentCreaterEntity.dart';
import 'package:sintir/Core/widgets/CustomCourseBottomSheet/CourseContentCreatorListTile.dart';

class CourseBottomSheetHeader extends StatelessWidget {
  const CourseBottomSheetHeader({
    super.key,
  });
  @override
  Widget build(BuildContext context) {
    Contentcreaterentity courseContentCreater = context
        .read<DisplayCourseBottomsheetNavigationRequirmentsEntity>()
        .course
        .contentcreaterentity!;
    return Row(
      children: [
        IntrinsicWidth(
          child: CourseContentCreatorListTile(
              title: courseContentCreater.name,
              subtitle: courseContentCreater.title,
              image: courseContentCreater.profileImageUrl),
        ),
        const Spacer(),
        IconButton(
            onPressed: () {
              GoRouter.of(context).pop();
            },
            icon: const Icon(FontAwesomeIcons.xmark))
      ],
    );
  }
}
