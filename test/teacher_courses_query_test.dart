import 'package:flutter_test/flutter_test.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/domain/Entities/TeacherCourseState.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/domain/Entities/TeacherCoursesQuery.dart';

import 'teacher_workspace_test_data.dart';

void main() {
  final courses = [
    workspaceCourse(
      'old',
      title: 'أساسيات الكيمياء',
      students: 50,
      ratingsSum: 8,
      ratingsCount: 2,
      posted: DateTime(2025, 1, 1),
    ),
    workspaceCourse(
      'new',
      title: 'English basics',
      students: 5,
      ratingsSum: 20,
      ratingsCount: 4,
      posted: DateTime(2026, 6, 1),
    ),
    workspaceCourse(
      'review',
      state: pending,
      title: 'مراجعة نهائية',
      posted: DateTime(2026, 10, 1),
    ),
    workspaceCourse('no', state: declined, posted: DateTime(2026, 2, 1)),
    workspaceCourse('gone', state: archived, posted: DateTime(2024, 1, 1)),
  ];

  List<String> ids(TeacherCoursesQuery query) =>
      query.apply(courses).map((course) => course.id).toList();

  test('maps every raw state, including declined', () {
    expect(
      TeacherCourseState.fromRaw(published),
      TeacherCourseState.published,
    );
    expect(TeacherCourseState.fromRaw(pending), TeacherCourseState.inReview);
    expect(TeacherCourseState.fromRaw(declined), TeacherCourseState.declined);
    expect(TeacherCourseState.fromRaw(archived), TeacherCourseState.archived);
    expect(TeacherCourseState.fromRaw('Rejected'), TeacherCourseState.declined);
    expect(TeacherCourseState.fromRaw(' declined '), TeacherCourseState.declined);
    expect(
      TeacherCourseState.fromRaw('Archived'),
      TeacherCourseState.hiddenByAdmin,
    );
    expect(
      TeacherCourseState.fromRaw('DeletedByAdmin'),
      TeacherCourseState.removedByAdmin,
    );
    expect(TeacherCourseState.fromRaw('Draft'), TeacherCourseState.unknown);
    expect(TeacherCourseState.fromRaw(null), TeacherCourseState.unknown);
  });

  test('only a published course can be archived', () {
    expect(TeacherCourseState.published.canArchive, isTrue);
    expect(TeacherCourseState.declined.canArchive, isFalse);
    expect(TeacherCourseState.inReview.canArchive, isFalse);
    expect(TeacherCourseState.archived.canRestore, isTrue);
    expect(TeacherCourseState.hiddenByAdmin.canRestore, isFalse);
  });

  test('counts each filter', () {
    final counts = TeacherCoursesCounts.of(courses);
    expect(counts.all, 5);
    expect(counts.of(TeacherCoursesFilter.published), 2);
    expect(counts.of(TeacherCoursesFilter.inReview), 1);
    expect(counts.of(TeacherCoursesFilter.declined), 1);
    expect(counts.of(TeacherCoursesFilter.archived), 1);
  });

  test('newest is the default order', () {
    expect(ids(const TeacherCoursesQuery()), [
      'review',
      'new',
      'no',
      'old',
      'gone',
    ]);
  });

  test('sorts by students and by rating, newest first on ties', () {
    expect(
      ids(const TeacherCoursesQuery(sort: TeacherCoursesSort.mostStudents)),
      ['old', 'new', 'review', 'no', 'gone'],
    );
    expect(
      ids(const TeacherCoursesQuery(sort: TeacherCoursesSort.topRated)),
      ['new', 'old', 'review', 'no', 'gone'],
    );
  });

  test('filters by state and searches without hamza or tashkeel', () {
    expect(
      ids(const TeacherCoursesQuery(filter: TeacherCoursesFilter.declined)),
      ['no'],
    );
    expect(ids(const TeacherCoursesQuery(search: 'اساسيات')), ['old']);
    expect(ids(const TeacherCoursesQuery(search: 'الكِيمياء')), ['old']);
    expect(ids(const TeacherCoursesQuery(search: '  ENGLISH ')), ['new']);
    expect(
      ids(
        const TeacherCoursesQuery(
          filter: TeacherCoursesFilter.published,
          search: 'مراجعة',
        ),
      ),
      isEmpty,
    );
  });

  test('unknown sort names fall back to newest', () {
    expect(
      TeacherCoursesSort.fromName('topRated'),
      TeacherCoursesSort.topRated,
    );
    expect(TeacherCoursesSort.fromName('weird'), TeacherCoursesSort.newest);
    expect(TeacherCoursesSort.fromName(null), TeacherCoursesSort.newest);
  });
}
