import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:dartz/dartz.dart';
import 'package:sintir/Core/entities/FetchDataResponses/CourseReportsSummaryEntity.dart';
import 'package:sintir/Core/entities/FetchDataResponses/GetCourseReportsResponseEntity.dart';
import 'package:sintir/Core/errors/Failures.dart';
import 'package:sintir/Core/repos/CourseReportsRepo/CourseReportsRepo.dart';
import 'package:sintir/Core/utils/Backend_EndPoints.dart';
import 'package:sintir/Features/CourseManagementAndInteractionFeature/data/models/CoursereportsitemModel.dart';
import 'package:sintir/Features/CourseManagementAndInteractionFeature/domain/Entities/SendCourseReportEntity.dart';
import 'package:sintir/Features/CourseManagementAndInteractionFeature/domain/Entities/report_enums.dart';
import 'package:sintir/locale_keys.dart';

class CourseReportsRepoimpli implements CourseReportsRepo {
  static const int pageSize = 10;
  final FirebaseFirestore firestore;
  final FirebaseAuth auth;
  final Map<String, QueryDocumentSnapshot<Map<String, dynamic>>> _cursors = {};

  CourseReportsRepoimpli({FirebaseFirestore? firestore, FirebaseAuth? auth})
      : firestore = firestore ?? FirebaseFirestore.instance,
        auth = auth ?? FirebaseAuth.instance;

  CollectionReference<Map<String, dynamic>> _reports(String courseId) =>
      firestore
          .collection(BackendEndpoints.coursesCollection)
          .doc(courseId)
          .collection(BackendEndpoints.reportsSubCollection);

  String _cursorKey(String courseId, ReportStatus? status, ReportType? type,
          ReportSortOrder sortOrder) =>
      '$courseId|${status?.key ?? 'all'}|${type?.key ?? 'all'}|${sortOrder.name}';

  @override
  Future<Either<Failure, void>> addCourseReport(
      {required SendCourseReportEntity report}) async {
    try {
      final uid = auth.currentUser?.uid;
      // TODO: throttle same-student open reports once legacy documents without
      // status can be included in the check.
      if (uid == null)
        return left(ServerFailure(message: LocaleKeys.errorOccurredMessage));
      await _reports(report.courseId).add({
        'type': report.type.key,
        'description': report.description.trim(),
        'status': ReportStatus.open.key,
        'reporterId': uid,
        'date': FieldValue.serverTimestamp(),
        'resolvedAt': null,
      });
      return right(null);
    } on FirebaseException catch (e) {
      return left(
          ServerFailure(message: e.message ?? LocaleKeys.errorOccurredMessage));
    } catch (_) {
      return left(ServerFailure(message: LocaleKeys.errorOccurredMessage));
    }
  }

  @override
  Future<Either<Failure, GetCourseReportsResponseEntity>> getCourseReports({
    required String courseId,
    required bool isPaginate,
    ReportStatus? status,
    ReportType? type,
    ReportSortOrder sortOrder = ReportSortOrder.newestFirst,
  }) async {
    final key = _cursorKey(courseId, status, type, sortOrder);
    try {
      if (!isPaginate) _cursors.remove(key);
      final cursor = _cursors[key];
      if (isPaginate && cursor == null) {
        return right(GetCourseReportsResponseEntity(
            reports: const [], hasMore: false, isPaginate: true));
      }
      Query<Map<String, dynamic>> query = _reports(courseId);
      if (status != null) query = query.where('status', isEqualTo: status.key);
      if (type != null) query = query.where('type', isEqualTo: type.key);
      query = query
          .orderBy('date', descending: sortOrder == ReportSortOrder.newestFirst)
          .limit(pageSize);
      if (cursor != null) query = query.startAfterDocument(cursor);
      final snapshot = await query.get();
      if (snapshot.docs.isNotEmpty) _cursors[key] = snapshot.docs.last;
      final reports = snapshot.docs
          .map((doc) => CoursereportsitemModel.fromJson(doc.data(), id: doc.id)
              .toEntity())
          .toList();
      return right(GetCourseReportsResponseEntity(
          reports: reports,
          hasMore: snapshot.docs.length == pageSize,
          isPaginate: isPaginate));
    } on FirebaseException catch (e) {
      return left(
          ServerFailure(message: e.message ?? LocaleKeys.errorOccurredMessage));
    } catch (_) {
      return left(ServerFailure(message: LocaleKeys.errorOccurredMessage));
    }
  }

  @override
  Future<Either<Failure, CourseReportsSummaryEntity>> getCourseReportsSummary(
      {required String courseId}) async {
    try {
      final reports = _reports(courseId);
      final counts = await Future.wait<int>([
        reports.count().get().then((snapshot) => snapshot.count ?? 0),
        reports
            .where('status', isEqualTo: ReportStatus.open.key)
            .count()
            .get()
            .then((snapshot) => snapshot.count ?? 0),
        reports
            .where('status', isEqualTo: ReportStatus.resolved.key)
            .count()
            .get()
            .then((snapshot) => snapshot.count ?? 0),
        reports
            .where('status', isEqualTo: ReportStatus.dismissed.key)
            .count()
            .get()
            .then((snapshot) => snapshot.count ?? 0),
      ]);
      return right(CourseReportsSummaryEntity(
          total: counts[0],
          open: counts[1],
          resolved: counts[2],
          dismissed: counts[3]));
    } on FirebaseException catch (e) {
      return left(
          ServerFailure(message: e.message ?? LocaleKeys.errorOccurredMessage));
    } catch (_) {
      return left(ServerFailure(message: LocaleKeys.errorOccurredMessage));
    }
  }

  // Temporary migration. Remove after every course's legacy reports are normalized.
  @override
  Future<Either<Failure, int>> normalizeLegacyReports(
      {required String courseId}) async {
    try {
      final snapshot = await _reports(courseId).get();
      final pending = <({
        DocumentReference<Map<String, dynamic>> ref,
        Map<String, dynamic> data
      })>[];
      for (final doc in snapshot.docs) {
        final data = doc.data();
        final updates = <String, dynamic>{};
        if (!data.containsKey('status'))
          updates['status'] = ReportStatus.open.key;
        if (!data.containsKey('resolvedAt')) updates['resolvedAt'] = null;
        final rawType = data['type'] as String?;
        final keyed = ReportType.fromKey(rawType);
        final parsed =
            rawType == keyed.key ? keyed : ReportType.fromLegacyLabel(rawType);
        if (rawType != parsed.key) updates['type'] = parsed.key;
        if (updates.isNotEmpty)
          pending.add((ref: doc.reference, data: updates));
      }
      for (var start = 0; start < pending.length; start += 400) {
        final batch = firestore.batch();
        for (final change in pending.skip(start).take(400))
          batch.update(change.ref, change.data);
        await batch.commit();
      }
      return right(pending.length);
    } on FirebaseException catch (e) {
      return left(
          ServerFailure(message: e.message ?? LocaleKeys.errorOccurredMessage));
    } catch (_) {
      return left(ServerFailure(message: LocaleKeys.errorOccurredMessage));
    }
  }

  @override
  Future<Either<Failure, String>> getCourseTitle(
      {required String courseId}) async {
    try {
      final snapshot = await firestore
          .collection(BackendEndpoints.coursesCollection)
          .doc(courseId)
          .get();
      return right(snapshot.data()?['title'] as String? ?? '');
    } on FirebaseException catch (e) {
      return left(
          ServerFailure(message: e.message ?? LocaleKeys.errorOccurredMessage));
    } catch (_) {
      return left(ServerFailure(message: LocaleKeys.errorOccurredMessage));
    }
  }

  @override
  Future<Either<Failure, void>> updateReportStatus(
      {required String courseId,
      required String reportId,
      required ReportStatus newStatus}) async {
    try {
      await _reports(courseId).doc(reportId).update({
        'status': newStatus.key,
        'resolvedAt': newStatus == ReportStatus.open
            ? null
            : FieldValue.serverTimestamp(),
      });
      return right(null);
    } on FirebaseException catch (e) {
      return left(
          ServerFailure(message: e.message ?? LocaleKeys.errorOccurredMessage));
    } catch (_) {
      return left(ServerFailure(message: LocaleKeys.errorOccurredMessage));
    }
  }
}
