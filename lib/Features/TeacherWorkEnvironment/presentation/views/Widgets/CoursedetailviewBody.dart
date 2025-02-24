// ignore_for_file: camel_case_types

import 'package:flutter/material.dart';
import 'package:sintir/Core/entities/CourseEntity.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/Widgets/CourseDetailsSectionsPAgeViewItem.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/Widgets/CourseDetailsViewRowOptions.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/Widgets/CoursedetailsReportspageviewitem.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/Widgets/CoursedetailsStudentReviewspageviewitem.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/Widgets/CoursedetailsStudentspageviewitem.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/Widgets/CustomCourseDetailsBodyCourse_Info.dart';
import 'package:sintir/constant.dart';

class CoursedetailviewBody extends StatefulWidget {
  const CoursedetailviewBody({super.key, required this.courseEntity});
  final CourseEntity courseEntity;

  @override
  State<CoursedetailviewBody> createState() => _CoursedetailviewBodyState();
}

class _CoursedetailviewBodyState extends State<CoursedetailviewBody> {
  int courrentIndex = 0;
  late PageController pageController;
  @override
  void initState() {
    pageController = PageController();
    pageController.addListener(() {
      courrentIndex = pageController.page!.toInt();
      setState(() {});
    });
    super.initState();
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> options = [
      Coursedetailssectionspageviewitem(
        courseSectionsEntity: widget.courseEntity.coursSectionsListItemEntity!,
      ),
      Coursedetailsstudentspageviewitem(
        subscribers: widget.courseEntity.subscripersIDS,
      ),
      Coursedetailsstudentreviewspageviewitem(
        reviews: widget.courseEntity.coursefedbackItemEntity,
      ),
      Coursedetailsreportspageviewitem(
        reports: widget.courseEntity.courseReports,
      ),
    ];
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: KHorizontalPadding),
      child: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: CustomCourseDetailsBodyCourse_Info(
                courseEntity: widget.courseEntity),
          ),
          const SliverToBoxAdapter(
            child: SizedBox(
              height: 20,
            ),
          ),
          CourseDetailsViewRowOptions(
              pageController: pageController,
              onChanged: (value) {
                courrentIndex = value;
                setState(() {});
              },
              courrentIndex: courrentIndex),
          SliverFillRemaining(
              hasScrollBody: true,
              child: PageView(
                  controller: pageController,
                  scrollDirection: Axis.horizontal,
                  children: options))
        ],
      ),
    );
  }
}
