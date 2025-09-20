import 'package:sintir/Core/entities/CourseEntities/CourseTestItemEntities/CourseTestQuestionEntity.dart';
import 'package:sintir/Features/Course%20Management%20and%20Interaction%20Feature/data/models/CoursetestquestionsolutionModel.dart';

class Coursetestquestionmodel {
  final String? questionTitle;
  final List<Map<String, dynamic>> solutions;
  final bool isOpened;
  String? imageUrl;
  String? selectedSolution;

  Coursetestquestionmodel(
      {required this.questionTitle,
      required this.solutions,
      required this.isOpened,
      this.imageUrl,
      this.selectedSolution = ""});

  factory Coursetestquestionmodel.fromJson(Map<String, dynamic> json) =>
      Coursetestquestionmodel(
          questionTitle: json["questionTitle"] ?? "",
          solutions: (json["solutions"] as List<dynamic>)
              .map((e) => e as Map<String, dynamic>)
              .toList(),
          isOpened: json["isOpened"],
          imageUrl: json["imageUrl"],
          selectedSolution: json["selectedSolution"]);
  factory Coursetestquestionmodel.fromEntity(
          CourseTestQuestionEntity courseTestQuestionModel) =>
      Coursetestquestionmodel(
          questionTitle: courseTestQuestionModel.questionTitle,
          solutions: courseTestQuestionModel.solutions
              .map((e) => Coursetestquestionsolutionmodel.fromEntity(
                      coursetestquestionsolution: e)
                  .toJson())
              .toList(),
          isOpened: courseTestQuestionModel.isOpened,
          imageUrl: courseTestQuestionModel.imageUrl,
          selectedSolution: courseTestQuestionModel.selectedSolution);

  CourseTestQuestionEntity toEntity() => CourseTestQuestionEntity(
      questionTitle: questionTitle,
      solutions: solutions
          .map((e) => Coursetestquestionsolutionmodel.fromJson(e).toEntity())
          .toList(),
      isOpened: isOpened,
      imageUrl: imageUrl,
      selectedSolution: selectedSolution);
  Map<String, dynamic> toJson() => {
        "questionTitle": questionTitle,
        "solutions": solutions,
        "isOpened": isOpened,
        "imageUrl": imageUrl,
        "selectedSolution": selectedSolution
      };
}
