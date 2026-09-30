part of 'course_reports_cubit.dart';

@immutable
sealed class CourseReportsState {
  const CourseReportsState();
}

final class CourseReportsInitial extends CourseReportsState {
  const CourseReportsInitial();
}

final class CourseReportsGetReportLoading extends CourseReportsState {
  final bool isPaginate;
  final List<CourseReportsItemEntity> reports;
  const CourseReportsGetReportLoading(
      {this.isPaginate = false, this.reports = const []});
}

final class CourseReportsGetReportSuccess extends CourseReportsState {
  final GetCourseReportsResponseEntity response;
  final List<CourseReportsItemEntity> reports;
  final CourseReportsSummaryEntity summary;
  final String courseTitle;
  const CourseReportsGetReportSuccess(
      {required this.response,
      required this.reports,
      required this.summary,
      required this.courseTitle});
}

final class CourseReportsGetReportFailure extends CourseReportsState {
  final String errMessage;
  final List<CourseReportsItemEntity> reports;
  const CourseReportsGetReportFailure(
      {required this.errMessage, required this.reports});
}

final class CourseReportsUpdateStatusLoading extends CourseReportsState {
  const CourseReportsUpdateStatusLoading();
}

final class CourseReportsUpdateStatusSuccess extends CourseReportsState {
  final List<CourseReportsItemEntity> reports;
  final CourseReportsSummaryEntity summary;
  const CourseReportsUpdateStatusSuccess(
      {required this.reports, required this.summary});
}

final class CourseReportsUpdateStatusFailure extends CourseReportsState {
  final String errMessage;
  final List<CourseReportsItemEntity> reports;
  const CourseReportsUpdateStatusFailure(
      {required this.errMessage, required this.reports});
}

final class CourseReportsAddReportLoading extends CourseReportsState {
  const CourseReportsAddReportLoading();
}

final class CourseReportsAddReportSuccess extends CourseReportsState {
  const CourseReportsAddReportSuccess();
}

final class CourseReportsAddReportFailure extends CourseReportsState {
  final String errMessage;
  const CourseReportsAddReportFailure({required this.errMessage});
}
