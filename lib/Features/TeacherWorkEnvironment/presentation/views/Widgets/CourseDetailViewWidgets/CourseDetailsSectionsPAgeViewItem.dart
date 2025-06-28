import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sintir/Core/Managers/Cubits/CourseSectionsCubit/CourseSectionsCubit.dart';
import 'package:sintir/Core/entities/CourseEntities/CourseEntity.dart';
import 'package:sintir/Core/entities/CourseEntities/CourseSectionEntity.dart';
import 'package:sintir/Core/widgets/CustomEmptyWidget.dart';
import 'package:sintir/Core/widgets/CustomListORGridTextHeader.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/Widgets/CourseDetailViewWidgets/CustomAddNewCourseSectionButton.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/Widgets/CourseDetailViewWidgets/CustomCourseDetailsBodyCourseSections_SliverList.dart';
import 'package:skeletonizer/skeletonizer.dart';

class Coursedetailssectionspageviewitem extends StatefulWidget {
  const Coursedetailssectionspageviewitem(
      {super.key,
      required this.courseEntity,
      required this.isFetchedCourseSections,
      required this.courseSections});
  final CourseEntity courseEntity;
  final List<CourseSectionEntity> courseSections;
  final bool isFetchedCourseSections;
  @override
  State<Coursedetailssectionspageviewitem> createState() =>
      _CoursedetailssectionspageviewitemState();
}

class _CoursedetailssectionspageviewitemState
    extends State<Coursedetailssectionspageviewitem> {
  @override
  void initState() {
    super.initState();
    if (!widget.isFetchedCourseSections) {
      BlocProvider.of<CourseSectionsCubit>(context)
          .getCourseSections(courseId: widget.courseEntity.id);
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CourseSectionsCubit, CourseSectionsState>(
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
                  if (widget.courseSections.isNotEmpty)
                    CustomCourseDetailsBodyCourseSections_SliverList(
                        courseSections: widget.courseSections,
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
