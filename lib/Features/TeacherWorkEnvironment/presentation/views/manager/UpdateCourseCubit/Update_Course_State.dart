part of 'Update_Course_Cubit.dart';

sealed class UpdateCourseState {}

class UpdateCourseInitial extends UpdateCourseState {}

class UpdateCourseLoading extends UpdateCourseState {}

class UpdateCourseSuccess extends UpdateCourseState {}

class UpdateCourseFailure extends UpdateCourseState {
  final String errmessage;
  UpdateCourseFailure(this.errmessage);
}

final class UpdateCourseCubitAssetPicked extends UpdateCourseState {
  File? file;

  UpdateCourseCubitAssetPicked({required this.file});
}

final class UpdateCourseCubitAssetLoading extends UpdateCourseState {}

final class UpdateCourseCubitAssetFailure extends UpdateCourseState {
  final String errmessage;
  UpdateCourseCubitAssetFailure(this.errmessage);
}
