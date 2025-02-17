part of 'get_courses_cubit.dart';

@immutable
sealed class GetCoursesState {}

final class GetCoursesInitial extends GetCoursesState {}

final class GetPopularCoursesSuccess extends GetCoursesState {
  final List<CourseEntity> courses;

  GetPopularCoursesSuccess({required this.courses});
}

final class GetRecentCoursesSuccess extends GetCoursesState {
  final List<CourseEntity> courses;

  GetRecentCoursesSuccess({required this.courses});
}

final class GetCoursesLoading extends GetCoursesState {}

final class GetCoursesFailure extends GetCoursesState {
  final String errmessage;

  GetCoursesFailure({required this.errmessage});
}
