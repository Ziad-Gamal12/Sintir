part of 'user_cubit.dart';

@immutable
sealed class UserState {}

final class UserInitial extends UserState {}

final class GetUserDataSuccess extends UserState {}

final class GetUserDataFailed extends UserState {
  final String message;
  GetUserDataFailed({required this.message});
}

final class GetUserDataLoading extends UserState {}

final class GetMyCoursesInitial extends UserState {}

final class GetMyCourseLoading extends UserState {}

final class GetMyCourseFailure extends UserState {
  final String errMessage;

  GetMyCourseFailure({required this.errMessage});
}

final class GetMyCourseSuccess extends UserState {
  final List<CourseEntity> courses;

  GetMyCourseSuccess({required this.courses});
}
