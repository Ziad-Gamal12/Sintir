// ignore_for_file: file_names

import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sintir/Core/entities/CourseEntities/CourseCouponEntity.dart';
import 'package:sintir/Core/entities/CourseEntities/CourseEntity.dart';
import 'package:sintir/Core/errors/Failures.dart';
import 'package:sintir/Core/models/CourseCouponModel.dart';
import 'package:sintir/Core/models/CourseModel.dart';
import 'package:sintir/Core/repos/CourseFeedBacksRepo/CourseFeedBacksRepoImpli.dart';
import 'package:sintir/Core/utils/Backend_EndPoints.dart';
import 'package:sintir/Features/CourseManagementAndInteractionFeature/domain/Entities/CoursefedbackItemEntity.dart';
import 'package:sintir/Features/CourseManagementAndInteractionFeature/domain/Entities/report_enums.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/domain/Entities/TeacherCourseActivity.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/domain/Entities/TeacherCourseState.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/domain/Entities/TeacherCoursesQuery.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/domain/Entities/TeacherWorkspaceSummary.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/domain/Repos/TeacherCourseReviewsRepo.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/domain/Repos/TeacherWorkspaceRepo.dart';
import 'package:sintir/locale_keys.dart';

class TeacherWorkspaceRepoImpl implements TeacherWorkspaceRepo {
  TeacherWorkspaceRepoImpl({
    required this.preferences,
    required this.reviewsRepo,
    FirebaseFirestore? firestore,
  }) : firestore = firestore ?? FirebaseFirestore.instance;

  final FirebaseFirestore firestore;
  final SharedPreferences preferences;
  final TeacherCourseReviewsRepo reviewsRepo;

  static const String sortKey = 'teacher_courses_sort';
  static const String teacherIdField = 'contentcreaterentity.id';
  static const String joinedDateField = 'joinedDate';
  static const String transactionDateField = 'created_at';
  static const String transactionAmountField = 'amount';
  static const String reportStatusField = 'status';
  static const String feedbackDateField = 'datePosted';
  static const int recentReviewsLimit = 20;
  static const int couponsLimit = 50;

  CollectionReference<Map<String, dynamic>> get _courses =>
      firestore.collection(BackendEndpoints.coursesCollection);

  @override
  Future<Either<Failure, List<CourseEntity>>> getCourses({
    required String teacherId,
  }) async {
    try {
      final snapshot = await _courses
          .where(teacherIdField, isEqualTo: teacherId)
          .get();
      final courses = <CourseEntity>[];
      for (final doc in snapshot.docs) {
        try {
          courses.add(
            Coursemodel.fromJson({...doc.data(), 'id': doc.id}).toEntity(),
          );
        } catch (error, stackTrace) {
          log(
            'Skipped malformed course ${doc.id}',
            name: 'TeacherWorkspaceRepo',
            error: error,
            stackTrace: stackTrace,
          );
        }
      }
      return right(courses);
    } on FirebaseException catch (error) {
      return left(ServerFailure(message: _messageFor(error)));
    } catch (_) {
      return left(ServerFailure(message: LocaleKeys.errorOccurredMessage));
    }
  }

  @override
  Future<Either<Failure, TeacherCourseActivity>> getCourseActivity({
    required CourseEntity course,
    required DateTime now,
  }) async {
    try {
      final doc = _courses.doc(course.id);
      final state = TeacherCourseState.fromRaw(course.state);
      final hasStudents = course.studentsCount > 0;
      final windowStart = now.subtract(TeacherWorkspaceSummary.activityWindow);
      final previousStart = windowStart.subtract(
        TeacherWorkspaceSummary.activityWindow,
      );
      final reviewsSince =
          reviewsRepo.lastSeenAt(course.id) ??
          now.subtract(TeacherWorkspaceSummary.firstVisitReviewsWindow);

      final subscribers = doc.collection(
        BackendEndpoints.subscribersSubCollection,
      );
      final newStudents = hasStudents
          ? _count(
              subscribers.where(
                joinedDateField,
                isGreaterThanOrEqualTo: Timestamp.fromDate(windowStart),
              ),
            )
          : Future.value(0);
      final previousNewStudents = hasStudents
          ? _count(
              subscribers
                  .where(
                    joinedDateField,
                    isGreaterThanOrEqualTo: Timestamp.fromDate(previousStart),
                  )
                  .where(
                    joinedDateField,
                    isLessThan: Timestamp.fromDate(windowStart),
                  ),
            )
          : Future.value(0);
      final grossRevenue = hasStudents
          ? _sum(
              doc
                  .collection(BackendEndpoints.transactionsSubCollection)
                  .where(
                    transactionDateField,
                    isGreaterThanOrEqualTo: Timestamp.fromDate(windowStart),
                  ),
              transactionAmountField,
            )
          : Future.value(0.0);
      final openReports = state.isLive
          ? _count(
              doc
                  .collection(BackendEndpoints.reportsSubCollection)
                  .where(
                    reportStatusField,
                    isEqualTo: ReportStatus.open.key,
                  ),
            )
          : Future.value(0);
      final recentReviews = course.ratingStats.hasRatings
          ? _recentReviews(doc, reviewsSince)
          : Future.value(const <CoursefeedbackItemEntity>[]);
      final coupons = state == TeacherCourseState.published
          ? _coupons(doc)
          : Future.value(const <CourseCouponEntity>[]);

      final results = await Future.wait<Object>([
        newStudents,
        previousNewStudents,
        grossRevenue,
        openReports,
        recentReviews,
        coupons,
      ]);
      return right(
        TeacherCourseActivity(
          courseId: course.id,
          newStudents: results[0] as int,
          previousNewStudents: results[1] as int,
          grossRevenue: results[2] as double,
          openReports: results[3] as int,
          recentReviews: results[4] as List<CoursefeedbackItemEntity>,
          coupons: results[5] as List<CourseCouponEntity>,
        ),
      );
    } on FirebaseException catch (error) {
      return left(ServerFailure(message: _messageFor(error)));
    } catch (_) {
      return left(ServerFailure(message: LocaleKeys.errorOccurredMessage));
    }
  }

  Future<int> _count(Query<Map<String, dynamic>> query) async {
    final snapshot = await query.count().get();
    return snapshot.count ?? 0;
  }

  Future<double> _sum(Query<Map<String, dynamic>> query, String field) async {
    final snapshot = await query.aggregate(sum(field)).get();
    return snapshot.getSum(field) ?? 0;
  }

  Future<List<CoursefeedbackItemEntity>> _recentReviews(
    DocumentReference<Map<String, dynamic>> doc,
    DateTime since,
  ) async {
    final snapshot = await doc
        .collection(BackendEndpoints.feedBacksSubCollection)
        .where(feedbackDateField, isGreaterThan: Timestamp.fromDate(since))
        .orderBy(feedbackDateField, descending: true)
        .limit(recentReviewsLimit)
        .get();
    return parseCourseFeedbacks([
      for (final review in snapshot.docs) review.data(),
    ]);
  }

  Future<List<CourseCouponEntity>> _coupons(
    DocumentReference<Map<String, dynamic>> doc,
  ) async {
    final snapshot = await doc
        .collection(BackendEndpoints.couponsSubCollection)
        .limit(couponsLimit)
        .get();
    final coupons = <CourseCouponEntity>[];
    for (final coupon in snapshot.docs) {
      try {
        coupons.add(CourseCouponModel.fromJson(coupon.data()).toEntity());
      } catch (_) {
        continue;
      }
    }
    return coupons;
  }

  String _messageFor(FirebaseException error) {
    if (error.code == 'unavailable') return LocaleKeys.noInternet;
    return LocaleKeys.errorOccurredMessage;
  }

  @override
  TeacherCoursesSort savedSort() =>
      TeacherCoursesSort.fromName(preferences.getString(sortKey));

  @override
  Future<void> saveSort(TeacherCoursesSort sort) async {
    try {
      await preferences.setString(sortKey, sort.name);
    } catch (_) {
      return;
    }
  }
}
