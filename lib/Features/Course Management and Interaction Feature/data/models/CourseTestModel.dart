import 'package:sintir/Features/Course%20Management%20and%20Interaction%20Feature/data/models/CoursetestquestionModel.dart';
import 'package:sintir/Features/Course%20Management%20and%20Interaction%20Feature/domain/Entities/CourseTestEntity.dart';

class Coursetestmodel {
  final int durationTime;
  final String title;
  final List<Map<String, dynamic>> questions;
  String? type;
  Coursetestmodel(
      {required this.durationTime,
      required this.title,
      required this.questions,
      this.type = "Test"});
  factory Coursetestmodel.fromJson(Map<String, dynamic> json) =>
      Coursetestmodel(
          durationTime: json["durationTime"],
          title: json["title"],
          questions: (json["questions"] as List<dynamic>)
              .map((e) => e as Map<String, dynamic>)
              .toList(),
          type: json["type"]);

  factory Coursetestmodel.fromEntity(Coursetestentity coursetestentity) =>
      Coursetestmodel(
        durationTime: coursetestentity.durationTime,
        title: coursetestentity.title,
        questions: coursetestentity.questions
            .map((e) => Coursetestquestionmodel.fromEntity(e).toJson())
            .toList(),
      );
  Coursetestentity toEntity() {
    return Coursetestentity(
      durationTime: durationTime,
      title: title,
      questions: questions
          .map((e) => Coursetestquestionmodel.fromJson(e).toEntity())
          .toList(),
    );
  }

  Map<String, dynamic> toJson() => {
        "durationTime": durationTime,
        "title": title,
        "questions": questions,
        "type": type
      };
}
