import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sintir/Core/Managers/Cubits/CourseSectionsCubit/CourseSectionsCubit.dart';
import 'package:sintir/Core/entities/CourseEntities/CourseEntity.dart';
import 'package:sintir/Core/entities/CourseEntities/CourseSectionEntity.dart';
import 'package:sintir/Core/helper/ShowSnackBar.dart';
import 'package:sintir/Core/utils/textStyles.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/Widgets/CourseDetailViewWidgets/CourseDetailsCourseSections_SectionWidgets/section_expanded_content.dart.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/Widgets/CourseDetailViewWidgets/CourseDetailsCourseSections_SectionWidgets/section_header_tile.dartd.dart';

class CustomCourseDetailsSectionsListViewItem extends StatefulWidget {
  const CustomCourseDetailsSectionsListViewItem({
    super.key,
    required this.sectionItem,
    required this.course,
  });

  final CourseSectionEntity sectionItem;
  final CourseEntity course;

  @override
  State<CustomCourseDetailsSectionsListViewItem> createState() =>
      _CustomCourseDetailsSectionsListViewItemState();
}

class _CustomCourseDetailsSectionsListViewItemState
    extends State<CustomCourseDetailsSectionsListViewItem> {
  List<dynamic> sectionLessons = [];
  late ExpandableController _controller;

  @override
  void initState() {
    super.initState();
    _controller = ExpandableController();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _fetchSectionItems(BuildContext context) {
    if (sectionLessons.isEmpty) {
      context.read<CourseSectionsCubit>().getSectionItems(
            sectionId: widget.sectionItem.id,
            courseId: widget.course.id,
          );
    }
    _controller.toggle();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<CourseSectionsCubit, CourseSectionsState>(
      listener: customCourseDetailsSectionsListViewItemListener,
      child: Container(
        margin: const EdgeInsets.only(bottom: 8),
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.grey.shade100,
              blurRadius: 7,
              spreadRadius: 1,
            ),
          ],
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: Colors.grey, width: .5),
          color: Colors.grey.shade100,
        ),
        child: ExpandablePanel(
          controller: _controller,
          theme: const ExpandableThemeData(hasIcon: false),
          header: SectionHeaderTile(
            title: widget.sectionItem.title,
            courseId: widget.course.id,
            sectionId: widget.sectionItem.id,
            subtitle: widget.sectionItem.subtitle,
            onTap: () => _fetchSectionItems(context),
          ),
          collapsed: const SizedBox(),
          expanded: SectionExpandedContent(
            sectionItem: widget.sectionItem,
            sectionLessons: sectionLessons,
            course: widget.course,
          ),
        ),
      ),
    );
  }

  void customCourseDetailsSectionsListViewItemListener(context, state) {
    if (state is GetSectionItemsSuccess &&
        state.sectionId == widget.sectionItem.id) {
      setState(() => sectionLessons = state.items);
    } else if (state is GetSectionItemsFailure) {
      ShowSnackBar(
        context: context,
        child: Text(
          state.errMessage,
          style: AppTextStyles(context).regular14.copyWith(color: Colors.white),
        ),
        backgroundColor: Colors.red,
      );
    }
  }
}
