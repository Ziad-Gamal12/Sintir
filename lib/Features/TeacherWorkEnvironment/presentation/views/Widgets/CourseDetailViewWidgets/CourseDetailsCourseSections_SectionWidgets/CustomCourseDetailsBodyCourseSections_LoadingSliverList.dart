import 'package:flutter/material.dart';
import 'package:sintir/Core/entities/CourseEntities/CourseEntity.dart';
import 'package:sintir/Core/entities/CourseEntities/CourseSectionEntity.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/Widgets/CourseDetailViewWidgets/CourseDetailsCourseSections_SectionWidgets/CustomCourseSectionsListViewItem.dart';
import 'package:skeletonizer/skeletonizer.dart';

class CustomCourseDetailsBodyCourseSectionsLoadingSliverList
    extends StatelessWidget {
  const CustomCourseDetailsBodyCourseSectionsLoadingSliverList(
      {super.key, required this.course});
  final CourseEntity course;
  @override
  Widget build(BuildContext context) {
    return SliverList.builder(
      itemCount: gateFakLoadingCourseSections().length,
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 5),
          child: Skeletonizer(
            enabled: true,
            child: CustomCourseDetailsSectionsListViewitem(
              course: course,
              sectionItem: gateFakLoadingCourseSections()[index],
            ),
          ),
        );
      },
    );
  }

  List<CourseSectionEntity> gateFakLoadingCourseSections() {
    return List.generate(6, (index) => CourseSectionEntity.empty());
  }
}
