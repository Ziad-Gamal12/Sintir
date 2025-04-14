import 'package:flutter/material.dart';
import 'package:sintir/Core/widgets/CustomContentListViewitem.dart';
import 'package:sintir/Features/Course%20Management%20and%20Interaction%20Feature/domain/Entities/CoursSectionsListItemEntity.dart';

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
            sectionItem: courseSectionsEntity[index],
          ),
        );
      },
    );
  }
}
