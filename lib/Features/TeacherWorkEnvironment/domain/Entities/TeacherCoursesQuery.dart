// ignore_for_file: file_names

import 'package:sintir/Core/entities/CourseEntities/CourseEntity.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/domain/Entities/TeacherCourseState.dart';

enum TeacherCoursesFilter { all, published, inReview, declined, archived }

enum TeacherCoursesSort {
  newest,
  mostStudents,
  topRated;

  static TeacherCoursesSort fromName(String? name) => values.firstWhere(
    (sort) => sort.name == name,
    orElse: () => newest,
  );
}

class TeacherCoursesCounts {
  const TeacherCoursesCounts({
    this.all = 0,
    this.published = 0,
    this.inReview = 0,
    this.declined = 0,
    this.archived = 0,
  });

  final int all;
  final int published;
  final int inReview;
  final int declined;
  final int archived;

  factory TeacherCoursesCounts.of(List<CourseEntity> courses) {
    var published = 0;
    var inReview = 0;
    var declined = 0;
    var archived = 0;
    for (final course in courses) {
      switch (TeacherCourseState.fromRaw(course.state)) {
        case TeacherCourseState.published:
          published++;
        case TeacherCourseState.inReview:
          inReview++;
        case TeacherCourseState.declined:
          declined++;
        case TeacherCourseState.archived:
          archived++;
        case TeacherCourseState.hiddenByAdmin:
        case TeacherCourseState.removedByAdmin:
        case TeacherCourseState.unknown:
          break;
      }
    }
    return TeacherCoursesCounts(
      all: courses.length,
      published: published,
      inReview: inReview,
      declined: declined,
      archived: archived,
    );
  }

  int of(TeacherCoursesFilter filter) {
    switch (filter) {
      case TeacherCoursesFilter.all:
        return all;
      case TeacherCoursesFilter.published:
        return published;
      case TeacherCoursesFilter.inReview:
        return inReview;
      case TeacherCoursesFilter.declined:
        return declined;
      case TeacherCoursesFilter.archived:
        return archived;
    }
  }

  @override
  bool operator ==(Object other) =>
      other is TeacherCoursesCounts &&
      other.all == all &&
      other.published == published &&
      other.inReview == inReview &&
      other.declined == declined &&
      other.archived == archived;

  @override
  int get hashCode => Object.hash(all, published, inReview, declined, archived);
}

class TeacherCoursesQuery {
  const TeacherCoursesQuery({
    this.filter = TeacherCoursesFilter.all,
    this.search = '',
    this.sort = TeacherCoursesSort.newest,
  });

  final TeacherCoursesFilter filter;
  final String search;
  final TeacherCoursesSort sort;

  TeacherCoursesQuery copyWith({
    TeacherCoursesFilter? filter,
    String? search,
    TeacherCoursesSort? sort,
  }) => TeacherCoursesQuery(
    filter: filter ?? this.filter,
    search: search ?? this.search,
    sort: sort ?? this.sort,
  );

  List<CourseEntity> apply(List<CourseEntity> courses) {
    final needle = normalize(search);
    final result = [
      for (final course in courses)
        if (_matchesFilter(course) &&
            (needle.isEmpty || normalize(course.title).contains(needle)))
          course,
    ];
    result.sort(_compare);
    return result;
  }

  bool _matchesFilter(CourseEntity course) {
    final state = TeacherCourseState.fromRaw(course.state);
    switch (filter) {
      case TeacherCoursesFilter.all:
        return true;
      case TeacherCoursesFilter.published:
        return state == TeacherCourseState.published;
      case TeacherCoursesFilter.inReview:
        return state == TeacherCourseState.inReview;
      case TeacherCoursesFilter.declined:
        return state == TeacherCourseState.declined;
      case TeacherCoursesFilter.archived:
        return state == TeacherCourseState.archived;
    }
  }

  int _compare(CourseEntity a, CourseEntity b) {
    switch (sort) {
      case TeacherCoursesSort.newest:
        break;
      case TeacherCoursesSort.mostStudents:
        final byStudents = b.studentsCount.compareTo(a.studentsCount);
        if (byStudents != 0) return byStudents;
      case TeacherCoursesSort.topRated:
        final byRating = b.ratingStats.average.compareTo(a.ratingStats.average);
        if (byRating != 0) return byRating;
        final byCount = b.ratingStats.ratingsCount.compareTo(
          a.ratingStats.ratingsCount,
        );
        if (byCount != 0) return byCount;
    }
    final byDate = b.postedDate.compareTo(a.postedDate);
    if (byDate != 0) return byDate;
    return a.id.compareTo(b.id);
  }

  static String normalize(String input) => input
      .replaceAll(RegExp(r'[ً-ٰٟ]'), '')
      .replaceAll(RegExp('[أإآٱ]'), 'ا')
      .replaceAll('ى', 'ي')
      .replaceAll('ة', 'ه')
      .toLowerCase()
      .trim();

  @override
  bool operator ==(Object other) =>
      other is TeacherCoursesQuery &&
      other.filter == filter &&
      other.search == search &&
      other.sort == sort;

  @override
  int get hashCode => Object.hash(filter, search, sort);
}
