import 'package:sintir/Core/entities/CourseEntities/CourseTestItemEntities/CourseTestQuestionEntity.dart';
import 'package:sintir/Core/entities/CourseEntities/CourseTestItemEntities/ExamResultSolvedQuestionEntity.dart';
import 'package:sintir/Core/entities/CourseEntities/CourseTestItemEntities/MistakeProgressEntity.dart';

class QuestionMistakeEntity {
  final ExamResultSolvedQuestionEntity question;
  final MistakeProgressEntity progress;
  final String courseId, sectionId;
  QuestionMistakeEntity(
      {required this.question,
      required this.progress,
      required this.courseId,
      required this.sectionId});

  static List<QuestionMistakeEntity> empty() => List.generate(
      6,
      (index) => QuestionMistakeEntity(
          courseId: "123456789",
          sectionId: "123456789",
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
      sectionId: sectionId ?? this.sectionId,
      question: question ?? this.question,
      progress: progress ?? this.progress,
    );
  }
}
