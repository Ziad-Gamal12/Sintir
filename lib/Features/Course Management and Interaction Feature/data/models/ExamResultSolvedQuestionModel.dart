import 'package:sintir/Core/entities/CourseEntities/CourseTestItemEntities/ExamResultSolvedQuestionEntity.dart';
import 'package:sintir/Features/Course%20Management%20and%20Interaction%20Feature/data/models/CoursetestquestionModel.dart';

class ExamResultSolvedQuestionModel {
  final Map<String, dynamic> question;
  final bool isCorrect;

  ExamResultSolvedQuestionModel(
      {required this.question, required this.isCorrect});

  factory ExamResultSolvedQuestionModel.fromJson(Map<String, dynamic> json) =>
      ExamResultSolvedQuestionModel(
          question: json["question"] as Map<String, dynamic>,
          isCorrect: json["isCorrect"]);

  factory ExamResultSolvedQuestionModel.fromEntity(
          ExamResultSolvedQuestionEntity entity) =>
      ExamResultSolvedQuestionModel(
          question:
              CourseTestQuestionModel.fromEntity(entity.question).toJson(),
          isCorrect: entity.isCorrect);
  ExamResultSolvedQuestionEntity toEntity() => ExamResultSolvedQuestionEntity(
      question: CourseTestQuestionModel.fromJson(question).toEntity(),
      isCorrect: isCorrect);

  Map<String, dynamic> toJson() => {
        "isCorrect": isCorrect,
        "question": question,
      };
}
