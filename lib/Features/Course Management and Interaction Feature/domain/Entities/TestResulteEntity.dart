import 'package:sintir/Features/Course%20Management%20and%20Interaction%20Feature/domain/Entities/CourseTestEntity.dart';
import 'package:sintir/Features/Course%20Management%20and%20Interaction%20Feature/domain/Entities/ExamResultSolvedQuestionEntity.dart';
import 'package:sintir/Features/Course%20Management%20and%20Interaction%20Feature/domain/Entities/JoinedByEntity.dart';

class Testresulteentity {
  final String serialNumber;
  final DateTime joinedDate;
  final Coursetestentity coursetestentity;
  final int totalQuestions;
  final int solvedQuestions;
  final bool isdelivered;
  final JoinedByEntity joinedbyentity;
  final int result;
  final List<ExamResultSolvedQuestionEntity> questionsSolvedListEntity;

  Testresulteentity(
      {required this.serialNumber,
      required this.joinedDate,
      required this.coursetestentity,
      required this.totalQuestions,
      required this.solvedQuestions,
      required this.isdelivered,
      required this.joinedbyentity,
      required this.result,
      required this.questionsSolvedListEntity});
}
