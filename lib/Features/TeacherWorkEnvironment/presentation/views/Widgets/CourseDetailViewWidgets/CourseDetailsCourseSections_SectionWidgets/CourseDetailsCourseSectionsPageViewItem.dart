import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sintir/Core/Managers/Cubits/CourseSectionsCubit/CourseSectionsCubit.dart';
import 'package:sintir/Core/entities/CourseEntities/CourseEntity.dart';
import 'package:sintir/Core/entities/CourseEntities/CourseSectionEntity.dart';
import 'package:sintir/Core/widgets/CustomEmptyWidget.dart';
import 'package:sintir/Core/widgets/CustomListORGridTextHeader.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/Widgets/CourseDetailViewWidgets/CourseDetailsCourseSections_SectionWidgets/CustomAddNewCourseSectionButton.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/Widgets/CourseDetailViewWidgets/CourseDetailsCourseSections_SectionWidgets/CustomCourseDetailsBodyCourseSections_SliverList.dart';
import 'package:skeletonizer/skeletonizer.dart';

class CourseDetailsCourseSectionsPageViewItem extends StatefulWidget {
  const CourseDetailsCourseSectionsPageViewItem({
    super.key,
    required this.courseEntity,
    required this.isFetchedCourseSections,
  });
  final CourseEntity courseEntity;
  final bool isFetchedCourseSections;
  @override
  State<CourseDetailsCourseSectionsPageViewItem> createState() =>
      _CourseDetailsCourseSectionsPageViewItemState();
}

class _CourseDetailsCourseSectionsPageViewItemState
    extends State<CourseDetailsCourseSectionsPageViewItem> {
  List<CourseSectionEntity> courseSections = [];

  @override
  void initState() {
    super.initState();
    //Edite this condition to fetch course sections one time
    if (!widget.isFetchedCourseSections || courseSections.isEmpty) {
      BlocProvider.of<CourseSectionsCubit>(context)
          .getCourseSections(courseId: widget.courseEntity.id);
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CourseSectionsCubit, CourseSectionsState>(
      listener: (context, state) {
        if (state is GetCourseSectionsSuccess) {
          courseSections = state.sections;
        }
      },
      builder: (context, state) {
        return Skeletonizer(
          enabled: state is GetCourseSectionsLoading,
          child: Stack(
            children: [
              CustomScrollView(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                slivers: [
                  const SliverToBoxAdapter(
                    child: SizedBox(
                      height: 20,
                    ),
                  ),
                  SliverToBoxAdapter(
                    child: CustomListORGridTextHeader(
                      text: "المحتوى",
                    ),
                  ),
                  const SliverToBoxAdapter(
                    child: SizedBox(
                      height: 10,
                    ),
                  ),
                  if (courseSections.isNotEmpty)
                    CustomCourseDetailsBodyCourseSections_SliverList(
                        courseSections: courseSections,
                        course: widget.courseEntity)
                  else
                    const SliverToBoxAdapter(child: CustomEmptyWidget())
                ],
              ),
              CustomAddNewCourseSectionButton(course: widget.courseEntity)
            ],
          ),
        );
      },
    );
  }
}
