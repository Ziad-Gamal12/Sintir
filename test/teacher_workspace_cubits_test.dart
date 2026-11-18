import 'package:flutter_test/flutter_test.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/domain/Entities/TeacherCourseActivity.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/domain/Entities/TeacherCoursesQuery.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/manager/teacher_courses_cubit/teacher_courses_cubit.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/manager/teacher_workspace_insights_cubit/teacher_workspace_insights_cubit.dart';

import 'teacher_workspace_test_data.dart';

void main() {
  group('TeacherCoursesCubit', () {
    late FakeWorkspaceRepo repo;

    setUp(() {
      repo = FakeWorkspaceRepo(
        courses: [
          workspaceCourse('a', students: 3, posted: DateTime(2026, 5, 1)),
          workspaceCourse('b', students: 9, posted: DateTime(2026, 1, 1)),
          workspaceCourse(
            'c',
            state: declined,
            posted: DateTime(2026, 9, 1),
          ),
        ],
      );
    });

    List<String> visible(TeacherCoursesCubit cubit) =>
        cubit.state.visibleCourses.map((course) => course.id).toList();

    test('loads newest first with counts', () async {
      final cubit = TeacherCoursesCubit(repo: repo, teacherId: 't1');
      await cubit.load();

      expect(cubit.state.status, WorkspaceLoadStatus.loaded);
      expect(visible(cubit), ['c', 'a', 'b']);
      expect(cubit.state.counts.declined, 1);
      await cubit.close();
    });

    test('starts from the saved sort and saves a new one', () async {
      repo.sort = TeacherCoursesSort.mostStudents;
      final cubit = TeacherCoursesCubit(repo: repo, teacherId: 't1');
      await cubit.load();
      expect(visible(cubit), ['b', 'a', 'c']);

      cubit.setSort(TeacherCoursesSort.newest);
      expect(visible(cubit), ['c', 'a', 'b']);
      expect(repo.savedSorts, [TeacherCoursesSort.newest]);

      cubit.setSort(TeacherCoursesSort.newest);
      expect(repo.savedSorts, hasLength(1));
      await cubit.close();
    });

    test('filters and searches on the loaded list', () async {
      final cubit = TeacherCoursesCubit(repo: repo, teacherId: 't1');
      await cubit.load();

      cubit.setFilter(TeacherCoursesFilter.published);
      expect(visible(cubit), ['a', 'b']);
      cubit.setSearch('course b');
      expect(visible(cubit), ['b']);
      cubit.clearFilters();
      expect(cubit.state.query.search, isEmpty);
      expect(visible(cubit), ['c', 'a', 'b']);
      expect(repo.coursesCalls, 1);
      await cubit.close();
    });

    test('a first load failure shows the error', () async {
      repo.coursesFailure = 'offline';
      final cubit = TeacherCoursesCubit(repo: repo, teacherId: 't1');
      await cubit.load();

      expect(cubit.state.status, WorkspaceLoadStatus.failure);
      expect(cubit.state.errorMessage, 'offline');
      await cubit.close();
    });

    test('a failed refresh keeps the courses', () async {
      final cubit = TeacherCoursesCubit(repo: repo, teacherId: 't1');
      await cubit.load();
      repo.coursesFailure = 'offline';

      expect(await cubit.refresh(), 'offline');
      expect(cubit.state.status, WorkspaceLoadStatus.loaded);
      expect(visible(cubit), ['c', 'a', 'b']);
      await cubit.close();
    });

    test('an emptied filter falls back to all after a refresh', () async {
      final cubit = TeacherCoursesCubit(repo: repo, teacherId: 't1');
      await cubit.load();
      cubit.setFilter(TeacherCoursesFilter.declined);
      expect(visible(cubit), ['c']);

      repo.courses = [workspaceCourse('a'), workspaceCourse('b')];
      expect(await cubit.refresh(), isNull);

      expect(cubit.state.query.filter, TeacherCoursesFilter.all);
      expect(visible(cubit), ['a', 'b']);
      await cubit.close();
    });
  });

  group('TeacherWorkspaceInsightsCubit', () {
    test('reads every course in batches and builds the summary', () async {
      final courses = [
        for (var i = 0; i < 8; i++) workspaceCourse('c$i', students: 1),
      ];
      final repo = FakeWorkspaceRepo(
        activities: {
          'c0': const TeacherCourseActivity(
            courseId: 'c0',
            newStudents: 4,
            openReports: 1,
          ),
          'c7': const TeacherCourseActivity(courseId: 'c7', newStudents: 2),
        },
      );
      final cubit = TeacherWorkspaceInsightsCubit(
        repo: repo,
        clock: () => workspaceNow,
      );
      await cubit.load(courses);

      expect(repo.activityCalls, [for (var i = 0; i < 8; i++) 'c$i']);
      expect(cubit.state.status, WorkspaceLoadStatus.loaded);
      expect(cubit.state.summary?.kpis.newStudents, 6);
      expect(cubit.state.openReportsFor('c0'), 1);
      await cubit.close();
    });

    test('a failure is shown, and retry reads again', () async {
      final repo = FakeWorkspaceRepo()..activityFailure = 'offline';
      final cubit = TeacherWorkspaceInsightsCubit(
        repo: repo,
        clock: () => workspaceNow,
      );
      await cubit.load([workspaceCourse('a')]);
      expect(cubit.state.status, WorkspaceLoadStatus.failure);
      expect(cubit.state.errorMessage, 'offline');

      repo.activityFailure = null;
      await cubit.retry();
      expect(cubit.state.status, WorkspaceLoadStatus.loaded);
      expect(repo.activityCalls, ['a', 'a']);
      await cubit.close();
    });

    test('a failed silent refresh keeps the last summary', () async {
      final repo = FakeWorkspaceRepo(
        activities: {
          'a': const TeacherCourseActivity(courseId: 'a', newStudents: 3),
        },
      );
      final cubit = TeacherWorkspaceInsightsCubit(
        repo: repo,
        clock: () => workspaceNow,
      );
      await cubit.load([workspaceCourse('a', students: 3)]);
      repo.activityFailure = 'offline';

      await cubit.refresh();

      expect(cubit.state.status, WorkspaceLoadStatus.loaded);
      expect(cubit.state.summary?.kpis.newStudents, 3);
      await cubit.close();
    });

    test('an empty course list gives an empty summary', () async {
      final repo = FakeWorkspaceRepo();
      final cubit = TeacherWorkspaceInsightsCubit(
        repo: repo,
        clock: () => workspaceNow,
      );
      await cubit.load(const []);

      expect(cubit.state.status, WorkspaceLoadStatus.loaded);
      expect(cubit.state.summary?.attention, isEmpty);
      expect(repo.activityCalls, isEmpty);
      await cubit.close();
    });
  });
}
