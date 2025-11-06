import 'package:sintir/Core/entities/CourseEntities/CourseTestItemEntities/ExamResultSolvedQuestionEntity.dart';

class GetMyMistakesResponseEntity {
  final List<ExamResultSolvedQuestionEntity> questionsSolvedListEntity;
  final bool hasMore;
  final bool isPaginate;
  GetMyMistakesResponseEntity({
    required this.questionsSolvedListEntity,
    required this.hasMore,
    required this.isPaginate,
  });
}
