import 'package:dartz/dartz.dart';
import 'package:sintir/Core/entities/FetchDataResponses/CourseReportsSummaryEntity.dart';
import 'package:sintir/Core/entities/FetchDataResponses/GetCourseReportsResponseEntity.dart';
import 'package:sintir/Core/errors/Failures.dart';
import 'package:sintir/Features/CourseManagementAndInteractionFeature/domain/Entities/SendCourseReportEntity.dart';
import 'package:sintir/Features/CourseManagementAndInteractionFeature/domain/Entities/report_enums.dart';

abstract class CourseReportsRepo {
  Future<Either<Failure, GetCourseReportsResponseEntity>> getCourseReports({
    required String courseId,
    required bool isPaginate,
    ReportStatus? status,
    ReportType? type,
    ReportSortOrder sortOrder = ReportSortOrder.newestFirst,
  });
  Future<Either<Failure, CourseReportsSummaryEntity>> getCourseReportsSummary(
      {required String courseId});
  Future<Either<Failure, int>> normalizeLegacyReports(
      {required String courseId});
  Future<Either<Failure, String>> getCourseTitle({required String courseId});
  Future<Either<Failure, void>> addCourseReport(
      {required SendCourseReportEntity report});
  Future<Either<Failure, void>> updateReportStatus(
      {required String courseId,
      required String reportId,
      required ReportStatus newStatus});
}
