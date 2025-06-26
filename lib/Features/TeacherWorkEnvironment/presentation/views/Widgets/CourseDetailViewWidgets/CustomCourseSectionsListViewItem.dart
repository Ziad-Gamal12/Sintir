// ignore_for_file: file_names

import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sintir/Core/Managers/Cubits/CourseSectionsCubit/CourseSectionsCubit.dart';
import 'package:sintir/Core/entities/CourseEntities/CourseEntity.dart';
import 'package:sintir/Core/entities/CourseEntities/CourseSectionEntity.dart';
import 'package:sintir/Core/helper/ShowSnackBar.dart';
import 'package:sintir/Core/utils/imageAssets.dart';
import 'package:sintir/Core/utils/textStyles.dart';
import 'package:sintir/Core/widgets/customListTileWidget.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/Widgets/CourseDetailViewWidgets/CourseDetailsCourseSectionItemListView.dart';

class CustomCourseDetailsSectionsListViewitem extends StatefulWidget {
  const CustomCourseDetailsSectionsListViewitem(
      {super.key, required this.sectionItem, required this.course});
  final CourseSectionEntity sectionItem;
  final CourseEntity course;

  @override
  State<CustomCourseDetailsSectionsListViewitem> createState() =>
      _CustomCourseDetailsSectionsListViewitemState();
}

class _CustomCourseDetailsSectionsListViewitemState
    extends State<CustomCourseDetailsSectionsListViewitem> {
  List<dynamic> sectionLessons = [];
  @override
  void initState() {
    super.initState();
    if (sectionLessons.isEmpty) {
      BlocProvider.of<CourseSectionsCubit>(context).getSectionItems(
        sectionId: widget.sectionItem.id,
        courseId: widget.course.id,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<CourseSectionsCubit, CourseSectionsState>(
      listener: (context, state) {
        if (state is GetSectionItemsSuccess &&
            state.sectionId == widget.sectionItem.id) {
          sectionLessons.addAll(state.items);
        } else if (state is GetSectionItemsFailure) {
          ShowSnackBar(
              context: context,
              child: Text(state.errMessage,
                  style: AppTextStyles.regular14.copyWith(color: Colors.white)),
              backgroundColor: Colors.red);
        }
      },
      child: Container(
        padding: const EdgeInsets.all(12),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.grey.shade100,
              blurRadius: 7,
              spreadRadius: 1,
            ),
          ],
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: Colors.black, width: .5),
          color: Colors.grey.shade100,
        ),
        child: ExpandablePanel(
          theme: const ExpandableThemeData(),
          header: Customlisttilewidget(
            title: widget.sectionItem.title,
            image: Assets.assetsImagesSectionIcon,
            subtitle: widget.sectionItem.subtitle,
          ),
          collapsed: const SizedBox(),
          expanded: Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8),
            ),
            child: CourseDetailsCourseSectionItemListView(
              section: widget.sectionItem,
              items: sectionLessons,
              course: widget.course,
            ),
          ),
        ),
      ),
    );
  }
}
