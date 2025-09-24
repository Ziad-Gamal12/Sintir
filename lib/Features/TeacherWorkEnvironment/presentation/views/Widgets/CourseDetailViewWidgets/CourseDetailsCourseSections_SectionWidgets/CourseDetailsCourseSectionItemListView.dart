import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sintir/Core/Managers/Cubits/CourseSectionsCubit/CourseSectionsCubit.dart';
import 'package:sintir/Core/entities/CourseEntities/CourseEntity.dart';
import 'package:sintir/Core/entities/CourseEntities/CourseSectionEntity.dart';
import 'package:sintir/Core/entities/CourseEntities/CourseTestItemEntities/CourseTestEntity.dart';
import 'package:sintir/Core/entities/CourseEntities/CourseVideoItemEntities/CourseVedioItemEntity.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/Widgets/CourseDetailViewWidgets/CourseDetailsCourseSections_SectionWidgets/CustomAddNewCourseSectionItemButton.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/Widgets/CourseDetailViewWidgets/CourseDetailsCourseSections_SectionWidgets/CustomCourseDetailsSectionListViewFileItem.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/Widgets/CourseDetailViewWidgets/CourseDetailsCourseSections_SectionWidgets/CustomCourseDetailsSectionListViewTestItem.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/Widgets/CourseDetailViewWidgets/CourseDetailsCourseSections_SectionWidgets/CustomCourseDetailsSectionListViewVideoItem.dart';
import 'package:skeletonizer/skeletonizer.dart';

class CourseDetailsCourseSectionItemListView extends StatelessWidget {
  const CourseDetailsCourseSectionItemListView(
      {super.key,
      required this.section,
      required this.course,
      required this.items});
  final CourseSectionEntity section;
  final CourseEntity course;
  final List<dynamic> items;
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CourseSectionsCubit, CourseSectionsState>(
        builder: (context, state) {
      return Column(
        children: [
          CustomAddNewCourseSectionItemButton(
            courseId: course.id,
            section: section,
          ),
          const SizedBox(
            height: 10,
          ),
          Skeletonizer(
            enabled: state is GetSectionItemsLoading,
            child: ListView.builder(
              itemCount: items.length,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 5),
                  child: getChild(items[index], context),
                );
              },
            ),
          )
        ],
      );
    });
  }

  Widget getChild(dynamic item, BuildContext context) {
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
    } else {
      return CustomCourseDetailsSectionListViewFileItem(
        section: section,
        item: item,
        course: course,
      );
    }
  }
}
