import 'package:sintir/Core/entities/CourseEntities/CourseTestItemEntities/CourseTestEntity.dart';
import 'package:sintir/Features/CourseManagementAndInteractionFeature/data/models/CoursetestquestionModel.dart';

class Coursetestmodel {
  final int durationTime;
  final String title;
  final List<Map<String, dynamic>> questions;
  final String id;
  final bool showResult;
  final int? numberOfAttempts;
  String? type;
  Coursetestmodel(
      {required this.durationTime,
      required this.title,
      required this.id,
      required this.numberOfAttempts,
      required this.showResult,
      required this.questions,
      this.type = "Test"});
  factory Coursetestmodel.fromJson(Map<String, dynamic> json) =>
      Coursetestmodel(
        durationTime: json["durationTime"],
        title: json["title"],
        showResult: json["showResult"],
        numberOfAttempts: json["numberOfAttempts"],
        questions: (json["questions"] as List<dynamic>)
            .map((e) => e as Map<String, dynamic>)
            .toList(),
        type: json["type"],
        id: json["id"],
      );

  factory Coursetestmodel.fromEntity(CourseTestEntity coursetestentity,
          {bool includeResults = true}) =>
      Coursetestmodel(
        id: coursetestentity.id,
        durationTime: coursetestentity.durationTime,
        type: coursetestentity.type,
        numberOfAttempts: coursetestentity.numberOfAttempts,
        showResult: coursetestentity.showResult,
        title: coursetestentity.title,
        questions: coursetestentity.questions
            .map((e) => CourseTestQuestionModel.fromEntity(e).toJson())
            .toList(),
      );
  CourseTestEntity toEntity() {
    return CourseTestEntity(
      id: id,
      durationTime: durationTime,
      type: type,
      numberOfAttempts: numberOfAttempts,
      showResult: showResult,
      title: title,
      questions: questions
          .map((e) => CourseTestQuestionModel.fromJson(e).toEntity())
          .toList(),
    );
  }

  Map<String, dynamic> toPublicJson() => {
        ...toJson(),
        "questions": questions.map(_publicQuestion).toList(),
        "questionsCount": questions.length,
      };

  Map<String, dynamic> toAnswerKeyJson() => {
        "testId": id,
        "questions": questions,
        "updatedAt": DateTime.now(),
      };

  static Map<String, dynamic> _publicQuestion(Map<String, dynamic> question) {
    final solutions = question["solutions"];
    return {
      "questionTitle": question["questionTitle"],
      "questionId": question["questionId"],
      "imageUrl": question["imageUrl"],
      "isOpened": false,
      "selectedSolution": "",
      "solutions": solutions is List
          ? solutions
              .whereType<Map>()
              .map((solution) => {"answer": solution["answer"]})
              .toList()
          : const [],
    };
  }

  Map<String, dynamic> toJson() => {
        "durationTime": durationTime,
        "title": title,
        "showResult": showResult,
        "numberOfAttempts": numberOfAttempts,
        "questions": questions,
        "type": type,
        "id": id
      };
}
