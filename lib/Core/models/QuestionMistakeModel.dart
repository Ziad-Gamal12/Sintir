import 'package:sintir/Core/entities/CourseEntities/CourseTestItemEntities/QuestionMistakeEntity.dart';
import 'package:sintir/Core/models/MistakeProgressModel.dart';
import 'package:sintir/Features/Course%20Management%20and%20Interaction%20Feature/data/models/ExamResultSolvedQuestionModel.dart';

class QuestionMistakeModel {
  final Map<String, dynamic> question;
  final Map<String, dynamic> progress;
  final String courseId, sectionId, courseSubject;

  QuestionMistakeModel(
      {required this.question,
      required this.progress,
      required this.courseSubject,
      required this.courseId,
      required this.sectionId});

  factory QuestionMistakeModel.fromJson(Map<String, dynamic> json) {
    return QuestionMistakeModel(
      question: json['question'],
      progress: json['progress'],
      courseId: json['courseId'] ?? "",
      sectionId: json['sectionId'] ?? "",
      courseSubject: json['courseSubject'] ?? "",
    );
  }
  factory QuestionMistakeModel.fromEntity(QuestionMistakeEntity entity) {
    return QuestionMistakeModel(
      question:
          ExamResultSolvedQuestionModel.fromEntity(entity.question).toJson(),
      progress: MistakeProgressModel.fromEntity(entity.progress).toJson(),
      courseId: entity.courseId,
      sectionId: entity.sectionId,
      courseSubject: entity.courseSubject,
    );
  }
  QuestionMistakeEntity toEntity() {
    return QuestionMistakeEntity(
        question: ExamResultSolvedQuestionModel.fromJson(question).toEntity(),
        progress: MistakeProgressModel.fromJson(progress).toEntity(),
        courseSubject: courseSubject,
        courseId: courseId,
        sectionId: sectionId);
  }

  Map<String, dynamic> toJson() {
    return {
      'question': question,
      'courseId': courseId,
      'sectionId': sectionId,
      'progress': progress,
      'courseSubject': courseSubject,
    };
  }
}
