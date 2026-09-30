import 'report_enums.dart';

class SendCourseReportEntity {
  final String courseId;
  final ReportType type;
  final String description;

  const SendCourseReportEntity({
    required this.courseId,
    required this.type,
    required this.description,
  });
}
