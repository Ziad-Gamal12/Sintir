part of 'my_courses_cubit.dart';

@immutable
sealed class MyCoursesState {}

final class MyCoursesInitial extends MyCoursesState {}

final class GetMyCoursesInitial extends MyCoursesState {}

final class GetMyCoursesLoading extends MyCoursesState {
  final bool isPaginate;
  GetMyCoursesLoading({required this.isPaginate});
}

final class GetMyCoursesSuccess extends MyCoursesState {
  final GetCoursesResonseEntity response;
  final bool isPaginate;
  GetMyCoursesSuccess({required this.response, required this.isPaginate});
}

final class GetMyCoursesFailure extends MyCoursesState {
  final String errmessage;
  GetMyCoursesFailure({required this.errmessage});
}
