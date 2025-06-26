import 'package:sintir/Core/entities/CourseEntities/CourseTestItemEntities/ExamResultSolvedQuestionEntity.dart';
import 'package:sintir/Features/Course%20Management%20and%20Interaction%20Feature/domain/Entities/JoinedByEntity.dart';

class TestresulteEntity {
  final String serialNumber;
  final DateTime joinedDate;
  final int totalQuestions;
  final int solvedQuestions;
  final JoinedByEntity joinedbyentity;
  final int result;
  final List<ExamResultSolvedQuestionEntity> questionsSolvedListEntity;

  TestresulteEntity(
      {required this.serialNumber,
      required this.joinedDate,
      required this.totalQuestions,
      required this.solvedQuestions,
      required this.joinedbyentity,
      required this.result,
      required this.questionsSolvedListEntity});
}
