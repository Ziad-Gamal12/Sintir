part of 'search_cubit.dart';

@immutable
sealed class SearchState {}

final class SearchInitial extends SearchState {}

final class SearchLoading extends SearchState {}

final class SearchSuccess extends SearchState {
  final SearchResponse searchResponse;

  SearchSuccess({required this.searchResponse});
}

final class SearchFailure extends SearchState {
  final String errorMessage;

  SearchFailure({required this.errorMessage});
}

// getDefaultCourses
final class GetDefaultCoursesLoading extends SearchState {}

final class GetDefaultCoursesSuccess extends SearchState {
  final SearchResponse searchResponse;

  GetDefaultCoursesSuccess({required this.searchResponse});
}

final class GetDefaultCoursesFailure extends SearchState {
  final String errorMessage;

  GetDefaultCoursesFailure({required this.errorMessage});
}

// getDefaultTeachers
final class GetDefaultTeachersLoading extends SearchState {}

final class GetDefaultTeachersSuccess extends SearchState {
  final SearchResponse searchResponse;

  GetDefaultTeachersSuccess({required this.searchResponse});
}

final class GetDefaultTeachersFailure extends SearchState {
  final String errorMessage;

  GetDefaultTeachersFailure({required this.errorMessage});
}
