// ignore_for_file: camel_case_types

import 'package:flutter/material.dart';
import 'package:sintir/Core/entities/CourseEntities/CourseEntity.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/Widgets/CourseDetailViewWidgets/CourseDetailsCourseInfoSectionWidgets/CustomCourseDetailsBodyCourse_Info.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/Widgets/CourseDetailViewWidgets/CourseDetailsRowOptionsSectionWidgets/CourseDetailsViewRowOptions.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/Widgets/CourseDetailViewWidgets/CustomCourseDetialsPageView.dart';
import 'package:sintir/constant.dart';

class CourseDetailViewBody extends StatefulWidget {
  const CourseDetailViewBody({super.key, required this.courseEntity});
  final CourseEntity courseEntity;

  @override
  State<CourseDetailViewBody> createState() => _CourseDetailViewBodyState();
}

class _CourseDetailViewBodyState extends State<CourseDetailViewBody>
    with AutomaticKeepAliveClientMixin {
  late PageController pageController;
  late ScrollController scrollController;

  int currentIndex = 0;

  @override
  void initState() {
    super.initState();
    _initControllers();
  }

  void _initControllers() {
    pageController = PageController();
    pageController.addListener(() {
      final newIndex = pageController.page?.toInt() ?? 0;
      if (currentIndex != newIndex) {
        setState(() {
          currentIndex = newIndex;
        });
      }
    });
    scrollController = ScrollController();
  }

  @override
  void dispose() {
    pageController.dispose();
    scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: KHorizontalPadding),
      child: CustomScrollView(
        controller: scrollController,
        slivers: [
          SliverToBoxAdapter(
            child: CustomCourseDetailsBodyCourse_Info(
              courseEntity: widget.courseEntity,
            ),
          ),
          const SliverToBoxAdapter(child: SizedBox(height: 20)),
          CourseDetailsViewRowOptions(pageController: pageController),
          SliverFillRemaining(
            hasScrollBody: true,
            child: CustomCourseDetialsPageView(
              pageController: pageController,
              course: widget.courseEntity,
              scrollController: scrollController,
            ),
          ),
        ],
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
