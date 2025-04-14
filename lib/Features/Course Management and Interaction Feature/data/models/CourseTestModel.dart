import 'package:sintir/Core/utils/imageAssets.dart';
import 'package:sintir/Features/Course%20Management%20and%20Interaction%20Feature/data/models/CoursetestquestionModel.dart';
import 'package:sintir/Features/Course%20Management%20and%20Interaction%20Feature/data/models/JoinedByModel.dart';
import 'package:sintir/Features/Course%20Management%20and%20Interaction%20Feature/data/models/TestResulteModel.dart';
import 'package:sintir/Features/Course%20Management%20and%20Interaction%20Feature/domain/Entities/CourseTestEntity.dart';

class Coursetestmodel {
  int durationTime;
  String title;
  final List<Map<String, dynamic>> questions;
  List<Map<String, dynamic>> joinedBy;
  List<Testresultemodel> results;
  String? type;
  String preffixImage = Assets.assetsImagesExamIcon;
  Coursetestmodel(
      {required this.durationTime,
      required this.title,
      required this.questions,
      required this.joinedBy,
      required this.results,
      this.type});
  factory Coursetestmodel.fromJson(Map<String, dynamic> json) =>
      Coursetestmodel(
        joinedBy: (json["joinedBy"] as List<dynamic>)
            .map((e) => e as Map<String, dynamic>)
            .toList(),
        durationTime: json["durationTime"],
        results: (json["results"] as List<dynamic>)
            .map((e) => Testresultemodel.fromJson(e as Map<String, dynamic>))
            .toList(),
        title: json["title"],
        questions: (json["questions"] as List<dynamic>)
            .map((e) => e as Map<String, dynamic>)
            .toList(),
        type: json["type"],
      );

  factory Coursetestmodel.fromEntity(Coursetestentity coursetestentity,
          {bool includeResults = true}) =>
      Coursetestmodel(
        joinedBy: coursetestentity.joinedBy
            .map((e) => JoinedbyModel.fromEntity(e).toJson())
            .toList(),
        durationTime: coursetestentity.durationTime,
        results: includeResults
            ? coursetestentity.results
                .map((e) =>
                    Testresultemodel.fromEntity(e, includeCourseTest: false))
                .toList()
            : [],
        title: coursetestentity.title,
        questions: coursetestentity.questions
            .map((e) => Coursetestquestionmodel.fromEntity(e).toJson())
            .toList(),
      );
  Coursetestentity toEntity() {
    return Coursetestentity(
      joinedBy:
          joinedBy.map((e) => JoinedbyModel.fromJson(e).toEntity()).toList(),
      durationTime: durationTime,
      results: results.map((e) => e.toEntity()).toList(),
      title: title,
      questions: questions
          .map((e) => Coursetestquestionmodel.fromJson(e).toEntity())
          .toList(),
    );
  }

  Map<String, dynamic> toJson({bool includeResults = true}) => {
        "durationTime": durationTime,
        "title": title,
        "questions": questions,
        "type": type,
        "joinedBy": joinedBy,
        "results": includeResults
            ? results.map((e) => e.toJson(includeCourseTest: false)).toList()
            : [],
      };
}
