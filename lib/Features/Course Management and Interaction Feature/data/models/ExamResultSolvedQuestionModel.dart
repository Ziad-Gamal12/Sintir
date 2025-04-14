import 'package:sintir/Features/Course%20Management%20and%20Interaction%20Feature/domain/Entities/ExamResultSolvedQuestionEntity.dart';

class Examresultsolvedquestionmodel {
  final String selectedAnswer, rightAnswer;
  final bool isCorrect;

  Examresultsolvedquestionmodel(
      {required this.selectedAnswer,
      required this.rightAnswer,
      required this.isCorrect});

  factory Examresultsolvedquestionmodel.fromJson(Map<String, dynamic> json) =>
      Examresultsolvedquestionmodel(
          selectedAnswer: json["selectedAnswer"],
          rightAnswer: json["rightAnswer"],
          isCorrect: json["isCorrect"]);

  factory Examresultsolvedquestionmodel.fromEntity(
          ExamResultSolvedQuestionEntity entity) =>
      Examresultsolvedquestionmodel(
          selectedAnswer: entity.selectedAnswer,
          rightAnswer: entity.rightAnswer,
          isCorrect: entity.isCorrect);
  ExamResultSolvedQuestionEntity toEntity() => ExamResultSolvedQuestionEntity(
      selectedAnswer: selectedAnswer,
      rightAnswer: rightAnswer,
      isCorrect: isCorrect);

  Map<String, dynamic> toJson() => {
        "selectedAnswer": selectedAnswer,
        "rightAnswer": rightAnswer,
        "isCorrect": isCorrect
      };
}
