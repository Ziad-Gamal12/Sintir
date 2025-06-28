// ignore_for_file: camel_case_types

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sintir/Core/Managers/Cubits/CourseFeedBacksCubit/course_feed_backs_cubit.dart';
import 'package:sintir/Core/Managers/Cubits/CourseReportsCubit/course_reports_cubit.dart';
import 'package:sintir/Core/Managers/Cubits/CourseSectionsCubit/CourseSectionsCubit.dart';
import 'package:sintir/Core/Managers/Cubits/CourseSubscribtionsCubit/CourseSubscribtionsCubit.dart';
import 'package:sintir/Core/entities/CourseEntities/CourseEntity.dart';
import 'package:sintir/Core/entities/CourseEntities/CourseSectionEntity.dart';
import 'package:sintir/Core/entities/CourseEntities/SubscriberEntity.dart';
import 'package:sintir/Core/helper/ShowSnackBar.dart';
import 'package:sintir/Features/Course%20Management%20and%20Interaction%20Feature/domain/Entities/CourseReportsItemEntity.dart';
import 'package:sintir/Features/Course%20Management%20and%20Interaction%20Feature/domain/Entities/CoursefedbackItemEntity.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/Widgets/CourseDetailViewWidgets/CourseDetailsSectionsPAgeViewItem.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/Widgets/CourseDetailViewWidgets/CourseDetailsViewRowOptions.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/Widgets/CourseDetailViewWidgets/CoursedetailsReportspageviewitem.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/Widgets/CourseDetailViewWidgets/CoursedetailsStudentReviewspageviewitem.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/Widgets/CourseDetailViewWidgets/CoursedetailsStudentspageviewitem.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/Widgets/CourseDetailViewWidgets/CustomCourseDetailsBodyCourse_Info.dart';
import 'package:sintir/constant.dart';

class CourseDetailViewBody extends StatefulWidget {
  const CourseDetailViewBody({super.key, required this.courseEntity});
  final CourseEntity courseEntity;

  @override
  State<CourseDetailViewBody> createState() => _CourseDetailViewBodyState();
}

class _CourseDetailViewBodyState extends State<CourseDetailViewBody> {
  late PageController pageController;
  int currentIndex = 0;

  @override
  void initState() {
    super.initState();
    pageController = PageController();
    pageController.addListener(() {
      final newIndex = pageController.page?.toInt() ?? 0;
      if (currentIndex != newIndex) {
        setState(() {
          currentIndex = newIndex;
        });
      }
    });
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  List<CourseSectionEntity> courseSections = [];
  List<Subscriberentity> courseSubscripers = [];
  List<CoursefeedbackItemEntity> courseFeedBacks = [];
  List<Coursereportsitementity> courseReports = [];
  bool isFechedCourseSectoins = false;
  bool isFechedCourseSubscripers = false;
  bool isFechedCourseFeedBacks = false;
  bool isFechedCourseReports = false;

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener<CourseSectionsCubit, CourseSectionsState>(
            listener: (context, state) {
          if (state is GetCourseSectionsSuccess) {
            courseSections = state.sections;
            isFechedCourseSectoins = true;
          } else if (state is GetCourseSectionsFailure) {
            ShowErrorSnackBar(context: context, errMessage: state.errMessage);
          }
        }),
        BlocListener<CourseSubscribtionsCubit, CourseSubscribtionsState>(
            listener: (context, state) {
          if (state is GetCourseSubscribersSuccess) {
            courseSubscripers = state.subscribers;
            isFechedCourseSubscripers = true;
          } else if (state is GetCourseSubscribersFailure) {
            ShowErrorSnackBar(context: context, errMessage: state.errMessage);
          }
        }),
        BlocListener<CourseFeedBacksCubit, CourseFeedBacksState>(
            listener: (context, state) {
          if (state is CourseFeedBacksGetFeedBackSuccess) {
            courseFeedBacks = state.feedBacks;
            isFechedCourseFeedBacks = true;
          } else if (state is CourseFeedBacksGetFeedBackFailure) {
            ShowErrorSnackBar(context: context, errMessage: state.errMessage);
          }
        }),
        BlocListener<CourseReportsCubit, CourseReportsState>(
            listener: (context, state) {
          if (state is CourseReportsGetReportSuccess) {
            courseReports = state.reports;
            isFechedCourseReports = true;
          } else if (state is CourseReportsGetReportFailure) {
            ShowErrorSnackBar(context: context, errMessage: state.errMessage);
          }
        }),
      ],
      child: Padding(
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
            ),
            SliverFillRemaining(
                hasScrollBody: true,
                child: PageView(
                    controller: pageController,
                    scrollDirection: Axis.horizontal,
                    physics: const NeverScrollableScrollPhysics(),
                    children: [
                      Coursedetailssectionspageviewitem(
                        courseEntity: widget.courseEntity,
                        isFetchedCourseSections: isFechedCourseSectoins,
                      ),
                      Coursedetailsstudentspageviewitem(
                        isFetchedCourseSubscribers: isFechedCourseSubscripers,
                      ),
                      CourseDetailsStudentsReviewsPageViewItem(
                        courseId: widget.courseEntity.id,
                        isFetchedCourseFeedBacks: isFechedCourseFeedBacks,
                      ),
                      CourseDetailsCourseReportsPageViewItem(
                        courseId: widget.courseEntity.id,
                        isFetchedCourseReports: isFechedCourseReports,
                      ),
                    ]))
          ],
        ),
      ),
    );
  }
}
