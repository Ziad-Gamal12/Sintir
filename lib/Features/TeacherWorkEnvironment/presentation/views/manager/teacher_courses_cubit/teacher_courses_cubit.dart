import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sintir/Core/entities/CourseEntities/CourseEntity.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/domain/Entities/TeacherCoursesQuery.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/domain/Repos/TeacherWorkspaceRepo.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/manager/workspace_load_status.dart';

export 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/manager/workspace_load_status.dart';

part 'teacher_courses_state.dart';

class TeacherCoursesCubit extends Cubit<TeacherCoursesState> {
  TeacherCoursesCubit({required this.repo, required this.teacherId})
    : super(
        TeacherCoursesState(
          query: TeacherCoursesQuery(sort: repo.savedSort()),
        ),
      );

  final TeacherWorkspaceRepo repo;
  final String teacherId;

  int _generation = 0;

  Future<void> load() => _fetch(silent: false);

  Future<String?> refresh() => _fetch(silent: state.isLoaded);

  void setFilter(TeacherCoursesFilter filter) =>
      _applyQuery(state.query.copyWith(filter: filter));

  void setSearch(String search) =>
      _applyQuery(state.query.copyWith(search: search));

  void setSort(TeacherCoursesSort sort) {
    if (sort == state.query.sort) return;
    _applyQuery(state.query.copyWith(sort: sort));
    unawaited(repo.saveSort(sort));
  }

  void clearFilters() => _applyQuery(
    state.query.copyWith(filter: TeacherCoursesFilter.all, search: ''),
  );

  Future<String?> _fetch({required bool silent}) async {
    final generation = ++_generation;
    if (!silent) {
      emit(
        state.copyWith(
          status: WorkspaceLoadStatus.loading,
          errorMessage: () => null,
        ),
      );
    }
    final result = await repo.getCourses(teacherId: teacherId);
    if (isClosed || generation != _generation) return null;

    return result.fold<String?>(
      (failure) {
        if (!silent) {
          emit(
            state.copyWith(
              status: WorkspaceLoadStatus.failure,
              errorMessage: () => failure.message,
            ),
          );
        }
        return failure.message;
      },
      (courses) {
        final all = List<CourseEntity>.unmodifiable(courses);
        final counts = TeacherCoursesCounts.of(all);
        var query = state.query;
        if (counts.of(query.filter) == 0) {
          query = query.copyWith(filter: TeacherCoursesFilter.all);
        }
        emit(
          state.copyWith(
            status: WorkspaceLoadStatus.loaded,
            courses: all,
            visibleCourses: List.unmodifiable(query.apply(all)),
            counts: counts,
            query: query,
            errorMessage: () => null,
          ),
        );
        return null;
      },
    );
  }

  void _applyQuery(TeacherCoursesQuery query) {
    if (query == state.query) return;
    emit(
      state.copyWith(
        query: query,
        visibleCourses: List.unmodifiable(query.apply(state.courses)),
      ),
    );
  }
}
