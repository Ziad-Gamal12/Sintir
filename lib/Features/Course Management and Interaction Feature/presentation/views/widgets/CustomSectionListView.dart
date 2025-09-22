import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sintir/Core/Managers/Cubits/CourseSectionsCubit/CourseSectionsCubit.dart';
import 'package:sintir/Core/entities/BottomSheetNavigationRequirmentsEntity.dart';
import 'package:sintir/Core/entities/CourseEntities/CourseEntity.dart';
import 'package:sintir/Core/entities/CourseEntities/CourseSectionEntity.dart';
import 'package:sintir/Core/entities/CourseEntities/CourseTestItemEntities/CourseTestEntity.dart';
import 'package:sintir/Core/entities/CourseEntities/CourseVideoItemEntities/CourseVedioItemEntity.dart';
import 'package:sintir/Features/Course%20Management%20and%20Interaction%20Feature/presentation/views/widgets/CustomFileListViewItem.dart';
import 'package:sintir/Features/Course%20Management%20and%20Interaction%20Feature/presentation/views/widgets/CustomTestListViewItem.dart';
import 'package:sintir/Features/Course%20Management%20and%20Interaction%20Feature/presentation/views/widgets/CustomVedioListViewItem.dart';

class CustomSectionListView extends StatefulWidget {
  const CustomSectionListView(
      {super.key, required this.section, required this.items});
  final CourseSectionEntity section;
  final List<dynamic> items;

  @override
  State<CustomSectionListView> createState() => _CustomSectionListViewState();
}

class _CustomSectionListViewState extends State<CustomSectionListView> {
  Widget getChild(dynamic item, BuildContext context) {
    bool isSubscribed = context
        .read<DisplayCourseBottomsheetNavigationRequirmentsEntity>()
        .isSubscribed;
    CourseEntity course = context
        .read<DisplayCourseBottomsheetNavigationRequirmentsEntity>()
        .course;
    if (item is CourseVideoItemEntity) {
      return CustomVedioListViewItem(
        course: course,
        isAvilabe: context
            .read<DisplayCourseBottomsheetNavigationRequirmentsEntity>()
            .isSubscribed,
        item: item,
        section: widget.section,
      );
    } else if (item is CourseTestEntity) {
      return Customtestlistviewitem(
        course: course,
        item: item,
        section: widget.section,
        isAvilabe: context
            .read<DisplayCourseBottomsheetNavigationRequirmentsEntity>()
            .isSubscribed,
      );
    } else {
      return Customfilelistviewitem(
          section: widget.section,
          item: item,
          course: course,
          isAvilabe: isSubscribed);
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CourseSectionsCubit, CourseSectionsState>(
      builder: (context, state) {
        return ListView.builder(
          itemCount: widget.items.length,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 5),
              child: getChild(widget.items[index], context),
            );
          },
        );
      },
    );
  }
}
