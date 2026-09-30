import 'package:sintir/Features/CourseManagementAndInteractionFeature/domain/Entities/CourseReportsItemEntity.dart';

class GetCourseReportsResponseEntity {
  final List<CourseReportsItemEntity> reports;
  final bool hasMore;
  final bool isPaginate;
  const GetCourseReportsResponseEntity(
      {required this.reports, required this.hasMore, required this.isPaginate});
}
