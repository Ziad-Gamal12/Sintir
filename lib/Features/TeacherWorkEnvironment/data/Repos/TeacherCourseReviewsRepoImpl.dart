// ignore_for_file: file_names

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sintir/Core/entities/CourseEntities/CourseRatingStatsEntity.dart';
import 'package:sintir/Core/entities/FetchDataResponses/GetCourseFeedBacksResponseEntity.dart';
import 'package:sintir/Core/entities/FireStoreEntities/FireStoreRequirmentsEntity.dart';
import 'package:sintir/Core/errors/Exceptioons.dart';
import 'package:sintir/Core/errors/Failures.dart';
import 'package:sintir/Core/repos/CourseFeedBacksRepo/CourseFeedBacksRepo.dart';
import 'package:sintir/Core/repos/CourseFeedBacksRepo/CourseFeedBacksRepoImpli.dart';
import 'package:sintir/Core/services/DataBaseService.dart';
import 'package:sintir/Core/utils/Backend_EndPoints.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/domain/Entities/CourseReviewsQuery.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/domain/Repos/TeacherCourseReviewsRepo.dart';
import 'package:sintir/locale_keys.dart';

class TeacherCourseReviewsRepoImpl implements TeacherCourseReviewsRepo {
  TeacherCourseReviewsRepoImpl({
    required this.databaseservice,
    required this.feedBacksRepo,
    required this.preferences,
  });

  final DataBaseService databaseservice;
  final CourseFeedBacksRepo feedBacksRepo;
  final SharedPreferences preferences;

  static const int pageSize = 15;
  static const int recentLimit = 300;
  static const String seenKeyPrefix = 'teacher_reviews_seen_';

  final Map<String, DocumentSnapshot<Object?>> _cursors = {};

  static Map<String, dynamic> pageQuery(
    CourseReviewsQuery query,
    DocumentSnapshot<Object?>? cursor,
  ) {
    final star = query.star;
    return {
      if (star != null)
        'filters': <Map<String, dynamic>>[
          {'field': 'rating', 'operator': '==', 'value': star},
        ],
      if (query.lowestFirst)
        'orderBy': <Map<String, dynamic>>[
          {'field': 'rating', 'descending': false},
          {'field': 'datePosted', 'descending': true},
        ]
      else
        'orderBy': 'datePosted',
      'descending': true,
      'limit': pageSize,
      'startAfter': cursor,
    };
  }

  static Map<String, dynamic> sinceQuery(DateTime since) => {
    'filters': <Map<String, dynamic>>[
      {
        'field': 'datePosted',
        'operator': '>=',
        'value': Timestamp.fromDate(since),
      },
    ],
    'orderBy': 'datePosted',
    'descending': true,
    'limit': recentLimit,
  };

  FireStoreRequirmentsEntity _feedbacks(String courseId) =>
      FireStoreRequirmentsEntity(
        collection: BackendEndpoints.coursesCollection,
        docId: courseId,
        subCollection: BackendEndpoints.feedBacksSubCollection,
      );

  @override
  Future<Either<Failure, GetCourseFeedBacksResponseEntity>> getReviews({
    required String courseId,
    required CourseReviewsQuery query,
    required bool isPaginate,
  }) async {
    final key = '$courseId|${query.cacheKey}';
    final cursor = isPaginate ? _cursors[key] : null;
    if (isPaginate && cursor == null) {
      return right(
        GetCourseFeedBacksResponseEntity(
          feedBacks: [],
          hasMore: false,
          isPaginate: true,
        ),
      );
    }
    return _fetch(
      courseId: courseId,
      options: pageQuery(query, cursor),
      isPaginate: isPaginate,
      onCursor: (lastDoc) {
        if (lastDoc != null) {
          _cursors[key] = lastDoc;
        } else if (!isPaginate) {
          _cursors.remove(key);
        }
      },
    );
  }

  @override
  Future<Either<Failure, GetCourseFeedBacksResponseEntity>> getReviewsSince({
    required String courseId,
    required DateTime since,
  }) {
    return _fetch(
      courseId: courseId,
      options: sinceQuery(since),
      isPaginate: false,
    );
  }

  Future<Either<Failure, GetCourseFeedBacksResponseEntity>> _fetch({
    required String courseId,
    required Map<String, dynamic> options,
    required bool isPaginate,
    void Function(DocumentSnapshot<Object?>? lastDoc)? onCursor,
  }) async {
    try {
      final response = await databaseservice.getData(
        requirements: _feedbacks(courseId),
        query: options,
      );
      final rawList = response.listData;
      if (rawList == null) {
        return left(ServerFailure(message: LocaleKeys.dataNotFound));
      }
      onCursor?.call(response.lastDocumentSnapshot);
      return right(
        GetCourseFeedBacksResponseEntity(
          feedBacks: parseCourseFeedbacks(rawList),
          hasMore: response.hasMore ?? false,
          isPaginate: isPaginate,
        ),
      );
    } on CustomException catch (e) {
      return left(ServerFailure(message: e.message));
    } catch (_) {
      return left(ServerFailure(message: LocaleKeys.errorOccurredMessage));
    }
  }

  @override
  Future<Either<Failure, CourseRatingStatsEntity>> getRatingStats({
    required String courseId,
  }) => feedBacksRepo.getCourseRatingStats(courseId: courseId);

  @override
  DateTime? lastSeenAt(String courseId) {
    final millis = preferences.getInt('$seenKeyPrefix$courseId');
    if (millis == null || millis <= 0) return null;
    return DateTime.fromMillisecondsSinceEpoch(millis);
  }

  @override
  Future<void> markSeen(String courseId, DateTime at) async {
    try {
      await preferences.setInt(
        '$seenKeyPrefix$courseId',
        at.millisecondsSinceEpoch,
      );
    } catch (_) {
      return;
    }
  }
}
