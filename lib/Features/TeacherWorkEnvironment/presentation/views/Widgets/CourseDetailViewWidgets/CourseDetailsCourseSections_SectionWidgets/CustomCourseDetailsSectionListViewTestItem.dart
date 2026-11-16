import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:sintir/Core/entities/CourseEntities/CourseEntity.dart';
import 'package:sintir/Core/entities/CourseEntities/CourseSectionEntity.dart';
import 'package:sintir/Core/entities/CourseEntities/CourseTestItemEntities/CourseTestEntity.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/domain/Entities/TestConsequencesViewRequirements.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/ExamConsequencesView.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/Widgets/CourseDetailViewWidgets/CourseDetailsCourseSections_SectionWidgets/SectionItemTile.dart';
import 'package:sintir/locale_keys.dart';

class CustomCourseDetailsSectionListViewTestItem extends StatelessWidget {
  const CustomCourseDetailsSectionListViewTestItem({
    super.key,
    required this.item,
    required this.section,
    required this.course,
  });
  final CourseTestEntity item;
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
      TestConsequencesView.routeName,
      extra: TestConsequencesViewRequirements(
        courseID: course.id,
        sectionID: section.id,
        test: item,
      ),
    ),
  );
}
