import 'package:flutter/material.dart';
import 'package:sintir/Core/entities/CourseEntities/CourseEntity.dart';
import 'package:sintir/Core/entities/CourseEntities/CourseSectionEntity.dart';
import 'package:sintir/Core/entities/CourseEntities/CourseTestItemEntities/CourseTestEntity.dart';
import 'package:sintir/Core/entities/CourseEntities/CourseVideoItemEntities/CourseVedioItemEntity.dart';
import 'package:sintir/Core/utils/imageAssets.dart';
import 'package:sintir/Core/widgets/CustomTrashIcon.dart';
import 'package:sintir/Core/widgets/customListTileWidget.dart';
import 'package:sintir/Features/Course%20Management%20and%20Interaction%20Feature/domain/Entities/CourseFileEntity.dart';
import 'package:sintir/Features/Course%20Management%20and%20Interaction%20Feature/presentation/views/widgets/CustomContainerSectionItem.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/Widgets/CourseDetailViewWidgets/CourseDetailsCourseSections_SectionWidgets/CustomCourseDetailsSectionListViewFileItem.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/Widgets/CourseDetailViewWidgets/CourseDetailsCourseSections_SectionWidgets/CustomCourseDetailsSectionListViewTestItem.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/Widgets/CourseDetailViewWidgets/CourseDetailsCourseSections_SectionWidgets/CustomCourseDetailsSectionListViewVideoItem.dart';

class CourseSectionItem extends StatelessWidget {
  const CourseSectionItem({
    super.key,
    required this.item,
    required this.course,
    required this.section,
  });

  final dynamic item;
  final CourseEntity course;
  final CourseSectionEntity section;

  @override
  Widget build(BuildContext context) {
    if (item is CourseVideoItemEntity) {
      return CustomCourseDetailsSectionListViewVideoItem(
        course: course,
        item: item,
        section: section,
      );
    } else if (item is CourseTestEntity) {
      return CustomCourseDetailsSectionListViewTestItem(
        course: course,
        item: item,
        section: section,
      );
    } else if (item is CourseFileEntity) {
      return CustomCourseDetailsSectionListViewFileItem(
        section: section,
        item: item,
        course: course,
      );
    } else {
      return Customcontainersectionitem(
          child: Customlisttilewidget(
              title: "unknown",
              image: Assets.assetsIconsSVGIconsVideoIcon,
              subtitle: " (Unknown)",
              trailing: Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: CustomTrashIcon(isLoading: false, onpressed: () {}))));
    }
  }
}
