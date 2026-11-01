import 'package:flutter_test/flutter_test.dart';
import 'package:sintir/Core/entities/CourseEntities/CourseTestItemEntities/CourseTestQuestionEntity.dart';
import 'package:sintir/Core/entities/CourseEntities/CourseTestItemEntities/ExamResultSolvedQuestionEntity.dart';
import 'package:sintir/Core/entities/CourseEntities/CourseTestItemEntities/TestResulteEntity.dart';
import 'package:sintir/Features/CourseManagementAndInteractionFeature/domain/Entities/JoinedByEntity.dart';
import 'package:sintir/Features/MyResults/Presentation/Views/Widgets/results_status_mapper.dart';

void main() {
  group('ResultsStatusMapper', () {
    test('maps performance tier boundaries', () {
      expect(ResultsStatusMapper.performanceTier(85),
          ResultsPerformanceTier.excellent);
      expect(
          ResultsStatusMapper.performanceTier(84), ResultsPerformanceTier.good);
      expect(
          ResultsStatusMapper.performanceTier(65), ResultsPerformanceTier.good);
      expect(ResultsStatusMapper.performanceTier(64),
          ResultsPerformanceTier.steady);
      expect(ResultsStatusMapper.performanceTier(50),
          ResultsPerformanceTier.steady);
      expect(ResultsStatusMapper.performanceTier(49),
          ResultsPerformanceTier.followUp);
    });

    test('returns zero when total questions are zero', () {
      expect(ResultsStatusMapper.percentage(_result(total: 0, answers: [])), 0);
    });

    test('rounds and clamps the result percentage', () {
      expect(ResultsStatusMapper.percentage(_result(total: 3, answers: [true])),
          33);
      expect(
          ResultsStatusMapper.percentage(
              _result(total: 1, answers: [true, true])),
          100);
    });
  });
}

TestResultEntity _result({required int total, required List<bool> answers}) =>
    TestResultEntity(
      serialNumber: '1',
      joinedDate: DateTime(2026),
      totalQuestions: total,
      solvedQuestions: answers.length,
      isPassed: true,
      joinedbyentity: JoinedByEntity.empty(),
      result: 0,
      questionsSolvedListEntity: answers.map(_answer).toList(),
      courseId: '',
      sectionId: '',
      testId: '',
      courseSubject: '',
    );

ExamResultSolvedQuestionEntity _answer(bool isCorrect) =>
    ExamResultSolvedQuestionEntity(
      question: CourseTestQuestionEntity(
        questionId: 'question',
        questionTitle: '',
        solutions: [],
        isOpened: false,
      ),
      isCorrect: isCorrect,
    );
