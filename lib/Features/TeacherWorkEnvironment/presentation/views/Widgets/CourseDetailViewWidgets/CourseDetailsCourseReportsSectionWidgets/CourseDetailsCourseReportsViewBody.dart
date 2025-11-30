// ignore_for_file: unused_field

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sintir/Core/Managers/Cubits/CourseReportsCubit/course_reports_cubit.dart';
import 'package:sintir/Core/widgets/CustomEmptyWidget.dart';
import 'package:sintir/Core/widgets/CustomErrorWidget.dart';
import 'package:sintir/Features/Course%20Management%20and%20Interaction%20Feature/domain/Entities/CourseReportsItemEntity.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/Widgets/CourseDetailViewWidgets/CourseDetailsCourseReportsSectionWidgets/CourseDetailsCourseLoadingReportsListView.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/Widgets/CourseDetailViewWidgets/CourseDetailsCourseReportsSectionWidgets/CourseDetailsCourseReportsListView.dart';
import 'package:sintir/locale_keys.dart';

class CourseDetailsCourseReportsViewBody extends StatefulWidget {
  const CourseDetailsCourseReportsViewBody({
    super.key,
    required this.courseId,
  });

  final String courseId;

  @override
  State<CourseDetailsCourseReportsViewBody> createState() =>
      _CourseDetailsCourseReportsViewBodyState();
}

class _CourseDetailsCourseReportsViewBodyState
    extends State<CourseDetailsCourseReportsViewBody>
    with AutomaticKeepAliveClientMixin {
  late ScrollController scrollController;
  List<CourseReportEntity> reports = [];
  bool hasMore = true;

  VoidCallback? _scrollListener;

  @override
  void initState() {
    super.initState();
    scrollController = ScrollController();
    final cubit = context.read<CourseReportsCubit>();

    cubit.getCourseReports(courseId: widget.courseId, isPaginate: false);

    _scrollListener = () {
      if (_shouldFetchMoreReports(cubit)) {
        cubit.getCourseReports(courseId: widget.courseId, isPaginate: true);
      }
    };

    scrollController.addListener(_scrollListener!);
  }

  bool _shouldFetchMoreReports(CourseReportsCubit cubit) {
    return scrollController.position.pixels >=
            scrollController.position.maxScrollExtent - 200 &&
        hasMore &&
        cubit.state is! CourseReportsGetReportLoading;
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
    return BlocConsumer<CourseReportsCubit, CourseReportsState>(
      listener: (context, state) {
        if (state is CourseReportsGetReportSuccess) {
          if (state.response.isPaginate) {
            setState(() {
              reports.addAll(state.response.reports);
            });
          } else {
            setState(() {
              reports = state.response.reports;
            });
          }
          hasMore = state.response.hasMore;
        }
      },
      builder: (context, state) {
        if (state is CourseReportsGetReportFailure) {
          return Center(
            child: CustomErrorWidget(errormessage: state.errMessage),
          );
        } else if (state is CourseReportsGetReportLoading && reports.isEmpty) {
          return CourseDetailsCourseLoadingReportsListView();
        } else if (reports.isNotEmpty) {
          return CourseDetailsCourseReportsListView(
              scrollController: scrollController, reports: reports);
        } else if (state is! CourseReportsGetReportLoading) {
          return CustomEmptyWidget(
            text: LocaleKeys.emptyContent,
          );
        } else {
          return const Padding(
            padding: EdgeInsets.symmetric(vertical: 10),
            child: Center(child: CircularProgressIndicator()),
          );
        }
      },
    );
  }

  @override
  bool get wantKeepAlive => true;
}
