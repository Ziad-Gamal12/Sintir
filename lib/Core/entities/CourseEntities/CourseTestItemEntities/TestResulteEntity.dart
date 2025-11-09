import 'package:sintir/Core/entities/CourseEntities/CourseTestItemEntities/ExamResultSolvedQuestionEntity.dart';
import 'package:sintir/Features/Course%20Management%20and%20Interaction%20Feature/domain/Entities/JoinedByEntity.dart';

class TestResultEntity {
  final String serialNumber;
  final DateTime joinedDate;
  final int totalQuestions;
  final int solvedQuestions;
  bool isPassed;
  final JoinedByEntity joinedbyentity;
  final int result;
  final List<ExamResultSolvedQuestionEntity> questionsSolvedListEntity;
  final String courseId;
  TestResultEntity(
      {required this.serialNumber,
      required this.joinedDate,
      required this.totalQuestions,
      required this.isPassed,
      required this.solvedQuestions,
      required this.joinedbyentity,
      required this.courseId,
      required this.result,
      required this.questionsSolvedListEntity});
  static TestResultEntity empty() {
    return TestResultEntity(
      serialNumber: "123456789",
      joinedDate: DateTime.now(),
      totalQuestions: 0,
      courseId: "00000",
      solvedQuestions: 0,
      joinedbyentity: JoinedByEntity.empty(),
      result: 0,
      isPassed: false,
      questionsSolvedListEntity: [],
    );
  }
}
