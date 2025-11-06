import 'package:sintir/Core/entities/CourseEntities/CourseTestItemEntities/TestResulteEntity.dart';

class GetMyResultsResponseEntity {
  final List<TestResultEntity> results;
  final bool hasMore;
  final bool isPaginate;
  GetMyResultsResponseEntity({
    required this.results,
    required this.hasMore,
    required this.isPaginate,
  });
}
