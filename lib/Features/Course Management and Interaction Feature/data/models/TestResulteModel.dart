import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:sintir/Core/entities/CourseEntities/CourseTestItemEntities/TestResulteEntity.dart';
import 'package:sintir/Features/Course%20Management%20and%20Interaction%20Feature/data/models/ExamResultSolvedQuestionModel.dart';
import 'package:sintir/Features/Course%20Management%20and%20Interaction%20Feature/data/models/JoinedByModel.dart';

class Testresultemodel {
  final String serialNumber;
  final DateTime joinedDate;
  final int totalQuestions;
  final int solvedQuestions;
  final Map<String, dynamic> joinedby;
  final int result;
  final List<Map<String, dynamic>> questionsSolvedList;

  Testresultemodel({
    required this.serialNumber,
    required this.joinedDate,
    required this.totalQuestions,
    required this.solvedQuestions,
    required this.joinedby,
    required this.result,
    required this.questionsSolvedList,
  });

  factory Testresultemodel.fromJson(Map<String, dynamic> json) {
    return Testresultemodel(
      serialNumber: json['serialNumber'],
      joinedDate: (json['joinedDate'] as Timestamp).toDate(),
      totalQuestions: json['totalQuestions'],
      solvedQuestions: json['solvedQuestions'],
      joinedby: json['joinedby'],
      result: json['result'],
      questionsSolvedList: (json["questionsSolvedList"] as List<dynamic>)
          .map((e) => e as Map<String, dynamic>)
          .toList(),
    );
  }

  factory Testresultemodel.fromEntity(TestresulteEntity entity,
      {bool includeCourseTest = true}) {
    return Testresultemodel(
      serialNumber: entity.serialNumber,
      joinedDate: entity.joinedDate,
      totalQuestions: entity.totalQuestions,
      solvedQuestions: entity.solvedQuestions,
      joinedby: JoinedbyModel.fromEntity(entity.joinedbyentity).toJson(),
      result: entity.result,
      questionsSolvedList: entity.questionsSolvedListEntity
          .map((e) => Examresultsolvedquestionmodel.fromEntity(e).toJson())
          .toList(),
    );
  }

  TestresulteEntity toEntity() {
    return TestresulteEntity(
      serialNumber: serialNumber,
      joinedDate: joinedDate,
      totalQuestions: totalQuestions,
      solvedQuestions: solvedQuestions,
      joinedbyentity: JoinedbyModel.fromJson(joinedby).toEntity(),
      result: result,
      questionsSolvedListEntity: questionsSolvedList
          .map((e) => Examresultsolvedquestionmodel.fromJson(e).toEntity())
          .toList(),
    );
  }

  Map<String, dynamic> toJson({bool includeCourseTest = true}) => {
        "serialNumber": serialNumber,
        "joinedDate": joinedDate,
        "totalQuestions": totalQuestions,
        "solvedQuestions": solvedQuestions,
        "joinedby": joinedby,
        "result": result,
        "questionsSolvedList": questionsSolvedList,
      };
}
