import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sintir/Core/Managers/Cubits/CourseSectionsCubit/CourseSectionsCubit.dart';
import 'package:sintir/Core/entities/CourseEntities/CourseEntity.dart';
import 'package:sintir/Core/entities/CourseEntities/CourseSectionEntity.dart';
import 'package:sintir/Core/widgets/CustomEmptyWidget.dart';
import 'package:sintir/Core/widgets/CustomErrorWidget.dart';
import 'package:sintir/Core/widgets/CustomListORGridTextHeader.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/Widgets/CourseDetailViewWidgets/CourseDetailsCourseSections_SectionWidgets/CustomAddNewCourseSectionButton.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/Widgets/CourseDetailViewWidgets/CourseDetailsCourseSections_SectionWidgets/CustomCourseDetailsBodyCourseSections_SliverList.dart';
import 'package:skeletonizer/skeletonizer.dart';

class CourseDetailsCourseSectionsPageViewItem extends StatefulWidget {
  const CourseDetailsCourseSectionsPageViewItem({
    super.key,
    required this.courseEntity,
    required this.scrollController,
  });

  final CourseEntity courseEntity;
  final ScrollController scrollController;

  @override
  State<CourseDetailsCourseSectionsPageViewItem> createState() =>
      _CourseDetailsCourseSectionsPageViewItemState();
}

class _CourseDetailsCourseSectionsPageViewItemState
    extends State<CourseDetailsCourseSectionsPageViewItem> {
  List<CourseSectionEntity> courseSections = [];
  bool hasMore = true;

  @override
  void initState() {
    super.initState();
    context
        .read<CourseSectionsCubit>()
        .getCourseSections(isPaginate: false, courseId: widget.courseEntity.id);

    widget.scrollController.addListener(() {
      final cubit = context.read<CourseSectionsCubit>();
      if (_shouldFetchMoreSections(cubit)) {
        cubit.getCourseSections(
            isPaginate: true, courseId: widget.courseEntity.id);
      }
    });
  }

  bool _shouldFetchMoreSections(CourseSectionsCubit cubit) {
    return widget.scrollController.position.pixels >=
            widget.scrollController.position.maxScrollExtent - 200 &&
        hasMore &&
        cubit.state is! GetCourseSectionsLoading;
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CourseSectionsCubit, CourseSectionsState>(
      listener: (context, state) {
        if (state is GetCourseSectionsSuccess) {
          if (state.response.isPaginate) {
            setState(() {
              courseSections.addAll(state.response.sections);
            });
          } else {
            setState(() {
              courseSections = state.response.sections;
            });
          }
          hasMore = state.response.hasMore;
        }
      },
      builder: (context, state) {
        if (state is GetCourseSectionsFailure) {
          return Center(
            child: CustomErrorWidget(errormessage: state.errMessage),
          );
        }
        return Skeletonizer(
          enabled: state is GetCourseSectionsLoading && courseSections.isEmpty,
          child: Stack(
            children: [
              CustomScrollView(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                slivers: [
                  const SliverToBoxAdapter(child: SizedBox(height: 20)),
                  SliverToBoxAdapter(
                    child: CustomListORGridTextHeader(text: "المحتوى"),
                  ),
                  const SliverToBoxAdapter(child: SizedBox(height: 10)),
                  if (courseSections.isNotEmpty)
                    CustomCourseDetailsBodyCourseSections_SliverList(
                      courseSections: courseSections,
                      course: widget.courseEntity,
                    )
                  else if (state is! GetCourseSectionsLoading)
                    const SliverToBoxAdapter(child: CustomEmptyWidget()),
                ],
              ),
              CustomAddNewCourseSectionButton(course: widget.courseEntity),
            ],
          ),
        );
      },
    );
  }
}
