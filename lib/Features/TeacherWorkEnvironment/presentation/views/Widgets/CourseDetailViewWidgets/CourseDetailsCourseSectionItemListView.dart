import 'package:flutter/material.dart';
import 'package:sintir/Core/entities/CourseEntities/CourseEntity.dart';
import 'package:sintir/Core/entities/CourseEntities/CourseSectionEntity.dart';
import 'package:sintir/Core/entities/CourseEntities/CourseTestItemEntities/CourseTestEntity.dart';
import 'package:sintir/Core/entities/CourseEntities/CourseVideoItemEntities/CourseVedioItemEntity.dart';
import 'package:sintir/Features/Course%20Management%20and%20Interaction%20Feature/presentation/views/widgets/CustomFileListViewItem.dart';
import 'package:sintir/Features/Course%20Management%20and%20Interaction%20Feature/presentation/views/widgets/CustomTestListViewItem.dart';
import 'package:sintir/Features/Course%20Management%20and%20Interaction%20Feature/presentation/views/widgets/CustomVedioListViewItem.dart';

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
    return ListView.builder(
      itemCount: items.length,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 5),
          child: getChild(items[index], context),
        );
      },
    );
  }

  Widget getChild(dynamic item, BuildContext context) {
    if (item is Coursevedioitementity) {
      return CustomVedioListViewItem(
        course: course,
        isAvilabe: true,
        item: item,
        section: section,
      );
    } else if (item is Coursetestentity) {
      return Customtestlistviewitem(
        course: course,
        item: item,
        section: section,
        isAvilabe: true,
      );
    } else {
      return Customfilelistviewitem(
        section: section,
        item: item,
        isAvilabe: true,
        course: course,
      );
    }
  }
}
