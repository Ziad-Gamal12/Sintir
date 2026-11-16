import 'package:flutter/material.dart';
import 'package:sintir/Core/entities/CourseEntities/CourseEntity.dart';
import 'package:sintir/Core/entities/CourseEntities/CourseSectionEntity.dart';
import 'package:sintir/Core/helper/ShowSnackBar.dart';
import 'package:sintir/Features/CourseManagementAndInteractionFeature/domain/Entities/CourseFileEntity.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/Widgets/CourseDetailViewWidgets/CourseDetailsCourseSections_SectionWidgets/SectionItemTile.dart';

class CustomCourseDetailsSectionListViewFileItem extends StatelessWidget {
  const CustomCourseDetailsSectionListViewFileItem({
    super.key,
    required this.item,
    required this.section,
    required this.course,
  });
  final CourseFileEntity item;
  final CourseSectionEntity section;
  final CourseEntity course;
  @override
  Widget build(BuildContext context) => SectionItemTile(
    course: course,
    section: section,
    itemId: item.id,
    teacherId: course.contentcreaterentity?.id ?? '',
    title: item.title,
    image: item.preffixImage,
    subtitle: item.description,
    onTap: () => CustomSnackBar.show(
      context,
      message: "${item.title} , ${item.description}",
      type: SnackType.info,
    ),
  );
}
