import 'package:sintir/Core/entities/CourseEntities/CourseTestItemEntities/CourseTestQuestionEntity.dart';
import 'package:sintir/Features/Course%20Management%20and%20Interaction%20Feature/data/models/CoursetestquestionsolutionModel.dart';

class CourseTestQuestionModel {
  final String? questionTitle;
  final String questionId;
  final List<Map<String, dynamic>> solutions;
  final bool isOpened;
  String? imageUrl;
  String? solutionUrl;
  String? selectedSolution;

  CourseTestQuestionModel(
      {required this.questionTitle,
      required this.solutions,
      required this.isOpened,
      required this.questionId,
      this.solutionUrl,
      this.imageUrl,
      this.selectedSolution = ""});

  factory CourseTestQuestionModel.fromJson(Map<String, dynamic> json) =>
      CourseTestQuestionModel(
          questionTitle: json["questionTitle"] ?? "",
          solutions: (json["solutions"] as List<dynamic>)
              .map((e) => e as Map<String, dynamic>)
              .toList(),
          isOpened: json["isOpened"],
          questionId: json["questionId"] ?? "",
          imageUrl: json["imageUrl"],
          solutionUrl: json["solutionUrl"],
          selectedSolution: json["selectedSolution"]);
  factory CourseTestQuestionModel.fromEntity(
          CourseTestQuestionEntity courseTestQuestionModel) =>
      CourseTestQuestionModel(
          questionTitle: courseTestQuestionModel.questionTitle,
          solutions: courseTestQuestionModel.solutions
              .map((e) => Coursetestquestionsolutionmodel.fromEntity(
                      coursetestquestionsolution: e)
                  .toJson())
              .toList(),
          questionId: courseTestQuestionModel.questionId,
          solutionUrl: courseTestQuestionModel.solutionImageUrl,
          isOpened: courseTestQuestionModel.isOpened,
          imageUrl: courseTestQuestionModel.imageUrl,
          selectedSolution: courseTestQuestionModel.selectedSolution);

  CourseTestQuestionEntity toEntity() => CourseTestQuestionEntity(
      questionTitle: questionTitle,
      solutions: solutions
          .map((e) => Coursetestquestionsolutionmodel.fromJson(e).toEntity())
          .toList(),
      isOpened: isOpened,
      questionId: questionId,
      solutionImageUrl: solutionUrl,
      imageUrl: imageUrl,
      selectedSolution: selectedSolution);
  Map<String, dynamic> toJson() => {
        "questionTitle": questionTitle,
        "solutions": solutions,
        "isOpened": isOpened,
        "imageUrl": imageUrl,
        "questionId": questionId,
        "solutionUrl": solutionUrl,
        "selectedSolution": selectedSolution
      };
}
