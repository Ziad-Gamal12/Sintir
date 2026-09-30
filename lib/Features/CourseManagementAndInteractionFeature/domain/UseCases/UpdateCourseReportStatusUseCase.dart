import 'package:dartz/dartz.dart';
import 'package:sintir/Core/errors/Failures.dart';
import 'package:sintir/Core/repos/CourseReportsRepo/CourseReportsRepo.dart';
import 'package:sintir/Features/CourseManagementAndInteractionFeature/domain/Entities/report_enums.dart';

class UpdateCourseReportStatusUseCase {
  final CourseReportsRepo repository;
  const UpdateCourseReportStatusUseCase(this.repository);
  Future<Either<Failure, void>> call(
          {required String courseId,
          required String reportId,
          required ReportStatus status}) =>
      repository.updateReportStatus(
          courseId: courseId, reportId: reportId, newStatus: status);
}
