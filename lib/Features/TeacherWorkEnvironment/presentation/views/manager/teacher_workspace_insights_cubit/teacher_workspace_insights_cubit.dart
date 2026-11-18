import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sintir/Core/entities/CourseEntities/CourseEntity.dart';
import 'package:sintir/Core/errors/Failures.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/domain/Entities/TeacherCourseActivity.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/domain/Entities/TeacherWorkspaceSummary.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/domain/Repos/TeacherWorkspaceRepo.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/manager/workspace_load_status.dart';

export 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/manager/workspace_load_status.dart';

part 'teacher_workspace_insights_state.dart';

class TeacherWorkspaceInsightsCubit
    extends Cubit<TeacherWorkspaceInsightsState> {
  TeacherWorkspaceInsightsCubit({
    required this.repo,
    DateTime Function()? clock,
  }) : _clock = clock ?? DateTime.now,
       super(const TeacherWorkspaceInsightsState());

  final TeacherWorkspaceRepo repo;
  final DateTime Function() _clock;

  static const int batchSize = 6;

  List<CourseEntity> _courses = const [];
  int _generation = 0;

  Future<void> load(List<CourseEntity> courses, {bool silent = false}) async {
    _courses = [
      for (final course in courses)
        if (course.id != CourseEntity.loadingId) course,
    ];
    final generation = ++_generation;
    final keepVisible = silent && state.summary != null;
    if (!keepVisible) {
      emit(
        const TeacherWorkspaceInsightsState(
          status: WorkspaceLoadStatus.loading,
        ),
      );
    }

    final now = _clock();
    final activities = <TeacherCourseActivity>[];
    for (var start = 0; start < _courses.length; start += batchSize) {
      final batch = _courses.skip(start).take(batchSize);
      final results = await Future.wait(
        batch.map(
          (course) => repo.getCourseActivity(course: course, now: now),
        ),
      );
      if (isClosed || generation != _generation) return;
      for (final result in results) {
        final failure = result.fold<Failure?>((failure) => failure, (
          activity,
        ) {
          activities.add(activity);
          return null;
        });
        if (failure != null) {
          if (!keepVisible) {
            emit(
              TeacherWorkspaceInsightsState(
                status: WorkspaceLoadStatus.failure,
                errorMessage: failure.message,
              ),
            );
          }
          return;
        }
      }
    }

    if (isClosed || generation != _generation) return;
    emit(
      TeacherWorkspaceInsightsState(
        status: WorkspaceLoadStatus.loaded,
        summary: TeacherWorkspaceSummary.build(
          courses: _courses,
          activities: activities,
          now: now,
        ),
      ),
    );
  }

  Future<void> retry() => load(_courses);

  Future<void> refresh() => load(_courses, silent: true);
}
