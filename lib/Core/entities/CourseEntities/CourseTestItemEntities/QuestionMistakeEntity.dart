import 'package:sintir/Core/entities/CourseEntities/CourseTestItemEntities/CourseTestQuestionEntity.dart';
import 'package:sintir/Core/entities/CourseEntities/CourseTestItemEntities/ExamResultSolvedQuestionEntity.dart';
import 'package:sintir/Core/entities/CourseEntities/CourseTestItemEntities/MistakeProgressEntity.dart';

class QuestionMistakeEntity {
  final ExamResultSolvedQuestionEntity question;
  final MistakeProgressEntity progress;
  final String courseId, sectionId, courseSubject;
  QuestionMistakeEntity(
      {required this.question,
      required this.progress,
      required this.courseId,
      required this.courseSubject,
      required this.sectionId});

  static List<QuestionMistakeEntity> empty() => List.generate(
      6,
      (index) => QuestionMistakeEntity(
          courseId: "123456789",
          sectionId: "123456789",
          courseSubject: "",
          question: ExamResultSolvedQuestionEntity(
              question: CourseTestQuestionEntity(
                  questionId: "123456789",
                  questionTitle: "",
                  solutions: [],
                  isOpened: false),
              isCorrect: false),
          progress: MistakeProgressEntity.empty()));
  QuestionMistakeEntity copyWith(
      {ExamResultSolvedQuestionEntity? question,
      MistakeProgressEntity? progress,
      String? courseId,
      String? sectionId}) {
    return QuestionMistakeEntity(
      courseId: courseId ?? this.courseId,
      courseSubject: courseSubject,
      sectionId: sectionId ?? this.sectionId,
      question: question ?? this.question,
      progress: progress ?? this.progress,
    );
  }
}

extension MistakeGrouping on List<QuestionMistakeEntity> {
  Map<String, List<QuestionMistakeEntity>> groupByCourseSubject() {
    final Map<String, List<QuestionMistakeEntity>> grouped = {};
    for (var mistake in this) {
      if (!grouped.containsKey(mistake.courseSubject)) {
        grouped[mistake.courseSubject] = [];
      }
      grouped[mistake.courseSubject]!.add(mistake);
    }
    return grouped;
  }
}
