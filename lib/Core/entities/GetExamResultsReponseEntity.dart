import 'package:sintir/Core/entities/CourseEntities/CourseTestItemEntities/TestResulteEntity.dart';

class GetExamResultsReponseEntity {
  final List<TestResultEntity> results;
  final bool hasMore;
  final bool isPaginate;
  GetExamResultsReponseEntity(
      {required this.results, required this.hasMore, required this.isPaginate});
}
