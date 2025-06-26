part of 'course_reports_cubit.dart';

@immutable
sealed class CourseReportsState {}

final class CourseReportsInitial extends CourseReportsState {}

final class CourseReportsAddReportLoading extends CourseReportsState {}

final class CourseReportsAddReportSuccess extends CourseReportsState {}

final class CourseReportsAddReportFailure extends CourseReportsState {
  final String errMessage;
  CourseReportsAddReportFailure({required this.errMessage});
}

final class CourseReportsGetReportLoading extends CourseReportsState {}

final class CourseReportsGetReportSuccess extends CourseReportsState {
  final List<Coursereportsitementity> reports;
  CourseReportsGetReportSuccess({required this.reports});
}

final class CourseReportsGetReportFailure extends CourseReportsState {
  final String errMessage;
  CourseReportsGetReportFailure({required this.errMessage});
}
