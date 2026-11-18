// ignore_for_file: file_names

import 'package:sintir/Core/entities/CourseEntities/ContentCreaterEntity.dart';
import 'package:sintir/Core/entities/CourseEntities/CourseRatingStatsEntity.dart';

class CourseEntity {
  String id, title, description, language, state;
  int price;
  final int studentsCount, lessonsCount, testsCount, feedBacksCount;
  String? posterUrl;
  final DateTime postedDate;
  final String subject;
  final String level;
  Contentcreaterentity? contentcreaterentity;

  /// Live only when read from `Courses/{id}`; enrollment snapshots under
  /// `Users/{uid}/Courses` keep the values from the day the student enrolled.
  final CourseRatingStatsEntity ratingStats;

  /// Set by the reviewer when the course is declined; shown to the teacher.
  String? declineReason;
  DateTime? declinedAt;
  DateTime? resubmittedAt;

  CourseEntity({
    required this.id,
    required this.state,
    this.posterUrl,
    required this.studentsCount,
    required this.subject,
    required this.level,
    required this.title,
    required this.description,
    required this.price,
    required this.language,
    required this.postedDate,
    required this.lessonsCount,
    required this.testsCount,
    required this.feedBacksCount,
    this.contentcreaterentity,
    this.ratingStats = const CourseRatingStatsEntity(),
    this.declineReason,
    this.declinedAt,
    this.resubmittedAt,
  });

  static const String loadingId = 'loading';

  factory CourseEntity.empty() => CourseEntity(
    id: loadingId,
    state: 'loading',
    title: 'loading',

    description: 'loading',
    posterUrl:
        "https://foundr.com/wp-content/uploads/2021/09/Best-online-course-platforms.png",
    price: 0,
    language: 'loading',
    subject: 'loading',
    level: 'loading',
    postedDate: DateTime.now(),
    studentsCount: 0,
    lessonsCount: 10,
    testsCount: 0,
    feedBacksCount: 0,
    contentcreaterentity: Contentcreaterentity(
      name: 'loading teacher',
      profileImageUrl: '',
      id: loadingId,
      title: 'loading',
    ),
  );
  static List<CourseEntity> fakeCourses = List.generate(
    10,
    (index) => CourseEntity.empty(),
  );
}
