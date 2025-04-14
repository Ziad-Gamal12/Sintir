part of 'updatecoursesectionsCubit.dart';

@immutable
sealed class UpdateCourseSectionsState {}

final class UpdateCourseSectionsInitial extends UpdateCourseSectionsState {}

final class UpdateCourseSectionsLoading extends UpdateCourseSectionsState {}

final class UpdateCourseSectionsSuccess extends UpdateCourseSectionsState {}

final class UpdateCourseSectionsFailure extends UpdateCourseSectionsState {
  final String errMessage;
  UpdateCourseSectionsFailure({required this.errMessage});
}
