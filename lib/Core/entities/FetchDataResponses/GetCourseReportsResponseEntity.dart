import 'package:sintir/Features/Course%20Management%20and%20Interaction%20Feature/domain/Entities/CourseReportsItemEntity.dart';

class GetCourseReportsResponseEntity {
  final List<CourseReportEntity> reports;
  final bool hasMore;
  final bool isPaginate;

  GetCourseReportsResponseEntity(
      {required this.reports, required this.hasMore, required this.isPaginate});
}
