part of 'get_courses_cubit.dart';

@immutable
sealed class GetCoursesState {}

final class GetCoursesInitial extends GetCoursesState {}

final class GetCoursesSuccess extends GetCoursesState {
  final List<CourseEntity> courses;

  GetCoursesSuccess({required this.courses});
}

final class GetCoursesloading extends GetCoursesState {}

final class GetCoursesFailure extends GetCoursesState {
  final String errmessage;

  GetCoursesFailure({required this.errmessage});
}
