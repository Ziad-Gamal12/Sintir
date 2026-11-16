import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:sintir/Core/entities/CourseEntities/CourseEntity.dart';
import 'package:sintir/Core/entities/CourseEntities/CourseSectionEntity.dart';
import 'package:sintir/Core/entities/CourseEntities/CourseVideoItemEntities/CourseVedioItemEntity.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/domain/Entities/VideoConsequencesViewRequirements.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/VideoConsequencesView.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/Widgets/CourseDetailViewWidgets/CourseDetailsCourseSections_SectionWidgets/SectionItemTile.dart';
import 'package:sintir/locale_keys.dart';

class CustomCourseDetailsSectionListViewVideoItem extends StatelessWidget {
  const CustomCourseDetailsSectionListViewVideoItem({
    super.key,
    required this.item,
    required this.course,
    required this.section,
  });
  final CourseVideoItemEntity item;
  final CourseSectionEntity section;
  final CourseEntity course;

  @override
  Widget build(BuildContext context) => SectionItemTile(
    course: course,
    section: section,
    itemId: item.id,
    title: item.title,
    image: item.preffixImage,
    subtitle: '${item.durationTime} ${LocaleKeys.durationMinutes}',
    onTap: () => GoRouter.of(context).push(
      VideoConsequencesView.routeName,
      extra: VideoConsequencesViewRequirements(
        courseID: course.id,
        sectionID: section.id,
        video: item,
      ),
    ),
  );
}
