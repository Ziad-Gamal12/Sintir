import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:sintir/Features/Course%20Management%20and%20Interaction%20Feature/data/models/CourseTestModel.dart';
import 'package:sintir/Features/Course%20Management%20and%20Interaction%20Feature/data/models/ExamResultSolvedQuestionModel.dart';
import 'package:sintir/Features/Course%20Management%20and%20Interaction%20Feature/data/models/JoinedByModel.dart';
import 'package:sintir/Features/Course%20Management%20and%20Interaction%20Feature/domain/Entities/CourseTestEntity.dart';
import 'package:sintir/Features/Course%20Management%20and%20Interaction%20Feature/domain/Entities/TestResulteEntity.dart';

class Testresultemodel {
  final String serialNumber;
  final DateTime joinedDate;
  final Coursetestentity coursetest;
  final int totalQuestions;
  final int solvedQuestions;
  final bool isdelivered;
  final Map<String, dynamic> joinedby;
  final int result;
  final List<Map<String, dynamic>> questionsSolvedList;

  Testresultemodel({
    required this.serialNumber,
    required this.joinedDate,
    required this.coursetest,
    required this.totalQuestions,
    required this.solvedQuestions,
    required this.isdelivered,
    required this.joinedby,
    required this.result,
    required this.questionsSolvedList,
  });

  factory Testresultemodel.fromJson(Map<String, dynamic> json) {
    return Testresultemodel(
      serialNumber: json['serialNumber'],
      joinedDate: (json['joinedDate'] as Timestamp).toDate(),
      coursetest: Coursetestmodel.fromJson(json['coursetest']).toEntity(),
      totalQuestions: json['totalQuestions'],
      solvedQuestions: json['solvedQuestions'],
      isdelivered: json['isdelivered'],
      joinedby: json['joinedby'],
      result: json['result'],
      questionsSolvedList: (json["questionsSolvedList"] as List<dynamic>)
          .map((e) => e as Map<String, dynamic>)
          .toList(),
    );
  }

  factory Testresultemodel.fromEntity(Testresulteentity entity,
      {bool includeCourseTest = true}) {
    return Testresultemodel(
      serialNumber: entity.serialNumber,
      joinedDate: entity.joinedDate,
      coursetest: includeCourseTest
          ? entity.coursetestentity
          : Coursetestentity.empty(),
      totalQuestions: entity.totalQuestions,
      solvedQuestions: entity.solvedQuestions,
      isdelivered: entity.isdelivered,
      joinedby: JoinedbyModel.fromEntity(entity.joinedbyentity).toJson(),
      result: entity.result,
      questionsSolvedList: entity.questionsSolvedListEntity
          .map((e) => Examresultsolvedquestionmodel.fromEntity(e).toJson())
          .toList(),
    );
  }

  Testresulteentity toEntity() {
    return Testresulteentity(
      serialNumber: serialNumber,
      joinedDate: joinedDate,
      coursetestentity: coursetest,
      totalQuestions: totalQuestions,
      solvedQuestions: solvedQuestions,
      isdelivered: isdelivered,
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
        "coursetest": includeCourseTest
            ? Coursetestmodel.fromEntity(coursetest).toJson()
            : null,
        "totalQuestions": totalQuestions,
        "solvedQuestions": solvedQuestions,
        "isdelivered": isdelivered,
        "joinedby": joinedby,
        "result": result,
        "questionsSolvedList": questionsSolvedList,
      };
}
