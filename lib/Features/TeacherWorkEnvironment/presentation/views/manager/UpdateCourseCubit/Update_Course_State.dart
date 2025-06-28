sealed class UpdateCourseState {}

class UpdateCourseInitial extends UpdateCourseState {}

class UpdateCourseLoading extends UpdateCourseState {}

class UpdateCourseSuccess extends UpdateCourseState {}

class UpdateCourseFailure extends UpdateCourseState {
  final String errmessage;
  UpdateCourseFailure(this.errmessage);
}
