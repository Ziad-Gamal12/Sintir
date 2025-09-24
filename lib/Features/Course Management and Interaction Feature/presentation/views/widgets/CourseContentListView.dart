import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sintir/Core/entities/BottomSheetNavigationRequirmentsEntity.dart';
import 'package:sintir/Core/entities/CourseEntities/CourseSectionEntity.dart';
import 'package:sintir/Core/widgets/CustomCourseSectionItem/CustomContentListViewitem.dart';

class CourseContentListView extends StatelessWidget {
  const CourseContentListView({
    super.key,
    required this.courseSectionsEntity,
  });
  final List<CourseSectionEntity> courseSectionsEntity;
  @override
  Widget build(BuildContext context) {
    return SliverList.builder(
      itemCount: courseSectionsEntity.length,
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 8),
          child: CustomContentListViewitem(
            course: context
                .read<DisplayCourseBottomsheetNavigationRequirmentsEntity>()
                .course,
            sectionItem: courseSectionsEntity[index],
          ),
        );
      },
    );
  }
}
