import 'package:sintir/Core/entities/CourseEntities/CourseTestItemEntities/CourseTestQuestionEntity.dart';

class ExamResultSolvedQuestionEntity {
  final CourseTestQuestionEntity question;
  final bool isCorrect;

  ExamResultSolvedQuestionEntity(
      {required this.question, required this.isCorrect});

  static List<ExamResultSolvedQuestionEntity> empty() => List.generate(
      6,
      (index) => ExamResultSolvedQuestionEntity(
          question: CourseTestQuestionEntity(
              questionId: "123456789",
              questionTitle: "",
              solutions: [],
              isOpened: false),
          isCorrect: false));
}
