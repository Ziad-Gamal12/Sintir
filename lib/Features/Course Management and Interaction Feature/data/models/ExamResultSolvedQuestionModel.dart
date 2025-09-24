import 'package:sintir/Core/entities/CourseEntities/CourseTestItemEntities/ExamResultSolvedQuestionEntity.dart';

class Examresultsolvedquestionmodel {
  final String selectedAnswer, rightAnswer, questionTitle, imageUrl;
  final bool isCorrect;

  Examresultsolvedquestionmodel(
      {required this.selectedAnswer,
      required this.rightAnswer,
      required this.questionTitle,
      required this.imageUrl,
      required this.isCorrect});

  factory Examresultsolvedquestionmodel.fromJson(Map<String, dynamic> json) =>
      Examresultsolvedquestionmodel(
          selectedAnswer: json["selectedAnswer"],
          imageUrl: json["imageUrl"],
          rightAnswer: json["rightAnswer"],
          questionTitle: json["questionTitle"],
          isCorrect: json["isCorrect"]);

  factory Examresultsolvedquestionmodel.fromEntity(
          ExamResultSolvedQuestionEntity entity) =>
      Examresultsolvedquestionmodel(
          selectedAnswer: entity.selectedAnswer,
          imageUrl: entity.imageUrl,
          questionTitle: entity.questionTitle,
          rightAnswer: entity.rightAnswer,
          isCorrect: entity.isCorrect);
  ExamResultSolvedQuestionEntity toEntity() => ExamResultSolvedQuestionEntity(
      selectedAnswer: selectedAnswer,
      questionTitle: questionTitle,
      imageUrl: imageUrl,
      rightAnswer: rightAnswer,
      isCorrect: isCorrect);

  Map<String, dynamic> toJson() => {
        "selectedAnswer": selectedAnswer,
        "rightAnswer": rightAnswer,
        "isCorrect": isCorrect,
        "questionTitle": questionTitle,
        "imageUrl": imageUrl
      };
}
