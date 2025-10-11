import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sintir/Core/Managers/Cubits/CourseSectionsCubit/CourseSectionsCubit.dart';
import 'package:sintir/Core/entities/CourseEntities/CourseEntity.dart';
import 'package:sintir/Core/entities/CourseEntities/CourseSectionEntity.dart';
import 'package:sintir/Core/widgets/CustomEmptyWidget.dart';
import 'package:sintir/Core/widgets/CustomErrorWidget.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/Widgets/CourseDetailViewWidgets/CourseDetailsCourseSections_SectionWidgets/CustomAddNewCourseSectionButton.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/Widgets/CourseDetailViewWidgets/CourseDetailsCourseSections_SectionWidgets/CustomCourseDetailsBodyCourseSections_LoadingSliverList.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/Widgets/CourseDetailViewWidgets/CourseDetailsCourseSections_SectionWidgets/CustomCourseDetailsBodyCourseSections_SliverList.dart';
import 'package:sintir/constant.dart';

class CourseDetailsCourseSectionsViewBody extends StatefulWidget {
  const CourseDetailsCourseSectionsViewBody({
    super.key,
    required this.courseEntity,
  });

  final CourseEntity courseEntity;
  @override
  State<CourseDetailsCourseSectionsViewBody> createState() =>
      _CourseDetailsCourseSectionsViewBodyState();
}

class _CourseDetailsCourseSectionsViewBodyState
    extends State<CourseDetailsCourseSectionsViewBody>
    with AutomaticKeepAliveClientMixin {
  List<CourseSectionEntity> courseSections = [];
  late ScrollController scrollController;
  bool hasMore = true;
  VoidCallback? _scrollListener;

  @override
  void initState() {
    super.initState();
    scrollController = ScrollController();
    final cubit = context.read<CourseSectionsCubit>();
    cubit.getCourseSections(
        isPaginate: false, courseId: widget.courseEntity.id);

    _scrollListener = () {
      if (!mounted) return;
      if (_shouldFetchMoreSections(cubit)) {
        cubit.getCourseSections(
            isPaginate: true, courseId: widget.courseEntity.id);
      }
    };

    scrollController.addListener(_scrollListener!);
  }

  bool _shouldFetchMoreSections(CourseSectionsCubit cubit) {
    return scrollController.position.pixels >=
            scrollController.position.maxScrollExtent - 200 &&
        hasMore &&
        cubit.state is! GetCourseSectionsLoading;
  }

  @override
  void dispose() {
    if (_scrollListener != null) {
      scrollController.removeListener(_scrollListener!);
    }
    scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
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
        return Stack(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: KHorizontalPadding,
                vertical: KVerticalPadding,
              ),
              child: CustomScrollView(
                controller: scrollController,
                slivers: [
                  if (state is GetCourseSectionsLoading &&
                      courseSections.isEmpty)
                    CustomCourseDetailsBodyCourseSectionsLoadingSliverList(
                      course: widget.courseEntity,
                    )
                  else if (courseSections.isNotEmpty)
                    CustomCourseDetailsBodyCourseSections_SliverList(
                      courseSections: courseSections,
                      course: widget.courseEntity,
                    )
                  else if (state is! GetCourseSectionsLoading)
                    SliverToBoxAdapter(
                        child: CustomEmptyWidget(
                      text: "لا يوجد محتوى في هذا الدورة",
                    )),
                ],
              ),
            ),
            CustomAddNewCourseSectionButton(course: widget.courseEntity),
          ],
        );
      },
    );
  }

  @override
  bool get wantKeepAlive => true;
}
