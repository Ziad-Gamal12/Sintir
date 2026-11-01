import 'package:sintir/Core/entities/CourseEntities/CourseTestItemEntities/TestResulteEntity.dart';

class GetMyResultsResponseEntity {
  final List<TestResultEntity> results;
  final bool hasMore;
  final bool isPaginate;
  final int totalCount;
  final int overallAveragePercent;
  GetMyResultsResponseEntity({
    required this.results,
    required this.hasMore,
    required this.isPaginate,
    required this.totalCount,
    required this.overallAveragePercent,
  });
}
