part of 'get_courses_cubit.dart';

@immutable
sealed class GetCoursesState {}

final class GetCoursesInitial extends GetCoursesState {}

final class GetPopularCoursesSuccess extends GetCoursesState {
  final GetCoursesResonseEntity resonseEntity;

  GetPopularCoursesSuccess({required this.resonseEntity});
}

final class GetPopularCoursesLoading extends GetCoursesState {}

final class GetPopularCoursesFailure extends GetCoursesState {
  final String errmessage;

  GetPopularCoursesFailure({required this.errmessage});
}

final class GetRecentCoursesSuccess extends GetCoursesState {
  final GetCoursesResonseEntity resonseEntity;

  GetRecentCoursesSuccess({required this.resonseEntity});
}

final class GetRecentCoursesLoading extends GetCoursesState {}

final class GetRecentCoursesFailure extends GetCoursesState {
  final String errmessage;

  GetRecentCoursesFailure({required this.errmessage});
}

final class GetUserInerestCoursesSuccess extends GetCoursesState {
  final GetCoursesResonseEntity resonseEntity;

  GetUserInerestCoursesSuccess({required this.resonseEntity});
}

final class GetUserInerestCoursesLoading extends GetCoursesState {}

final class GetUserInerestCoursesFailure extends GetCoursesState {
  final String errmessage;

  GetUserInerestCoursesFailure({required this.errmessage});
}
