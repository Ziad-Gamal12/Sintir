part of 'ProfileCubit.dart';

@immutable
sealed class ProfileState {}

final class GetMyCoursesInitial extends ProfileState {}

final class GetMyCoursesLoading extends ProfileState {
  final bool isPaginate;
  GetMyCoursesLoading({required this.isPaginate});
}

final class GetMyCoursesSuccess extends ProfileState {
  final GetCoursesResonseEntity response;
  final bool isPaginate;
  GetMyCoursesSuccess({required this.response, required this.isPaginate});
}

final class GetMyCoursesFailure extends ProfileState {
  final String errmessage;
  GetMyCoursesFailure({required this.errmessage});
}
