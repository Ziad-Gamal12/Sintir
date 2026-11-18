part of 'teacher_courses_cubit.dart';

class TeacherCoursesState {
  const TeacherCoursesState({
    this.status = WorkspaceLoadStatus.initial,
    this.courses = const [],
    this.visibleCourses = const [],
    this.counts = const TeacherCoursesCounts(),
    this.query = const TeacherCoursesQuery(),
    this.errorMessage,
  });

  final WorkspaceLoadStatus status;
  final List<CourseEntity> courses;
  final List<CourseEntity> visibleCourses;
  final TeacherCoursesCounts counts;
  final TeacherCoursesQuery query;
  final String? errorMessage;

  bool get isLoaded => status == WorkspaceLoadStatus.loaded;

  TeacherCoursesState copyWith({
    WorkspaceLoadStatus? status,
    List<CourseEntity>? courses,
    List<CourseEntity>? visibleCourses,
    TeacherCoursesCounts? counts,
    TeacherCoursesQuery? query,
    String? Function()? errorMessage,
  }) {
    return TeacherCoursesState(
      status: status ?? this.status,
      courses: courses ?? this.courses,
      visibleCourses: visibleCourses ?? this.visibleCourses,
      counts: counts ?? this.counts,
      query: query ?? this.query,
      errorMessage: errorMessage == null ? this.errorMessage : errorMessage(),
    );
  }
}
