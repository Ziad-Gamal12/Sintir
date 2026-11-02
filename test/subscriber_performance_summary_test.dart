import 'package:flutter_test/flutter_test.dart';
import 'package:sintir/Core/entities/CourseEntities/CourseTestItemEntities/CourseTestQuestionEntity.dart';
import 'package:sintir/Core/entities/CourseEntities/CourseTestItemEntities/ExamResultSolvedQuestionEntity.dart';
import 'package:sintir/Core/entities/CourseEntities/CourseTestItemEntities/TestResulteEntity.dart';
import 'package:sintir/Features/CourseManagementAndInteractionFeature/domain/Entities/JoinedByEntity.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/Widgets/CourseDetailViewWidgets/CourseDetailsCourseSubscribers_SectionWidgets/SubscriberDetails/widgets/SubscriberPerformanceSummary.dart';
import 'package:sintir/Core/widgets/results/results_status_mapper.dart';

void main() {
  group('SubscriberPerformanceSummary', () {
    test('sorts results chronologically and computes a declining trend', () {
      final later = _result('later', DateTime(2025, 12, 2), 0, 2);
      final earlier = _result('earlier', DateTime(2025, 12, 1), 2, 2);
      final summary =
          SubscriberPerformanceSummary.fromResults([later, earlier]);

      expect(summary.chronologicalResults.map((r) => r.serialNumber),
          ['earlier', 'later']);
      expect(summary.percentages, [100, 0]);
      expect(summary.trendDelta, -100);
      expect(summary.average, 50);
      expect(summary.highest, earlier);
      expect(summary.lowest, later);
    });

    test('handles stable, single, empty, and zero-total data', () {
      final same = SubscriberPerformanceSummary.fromResults([
        _result('a', DateTime(2025), 1, 2),
        _result('b', DateTime(2025, 1, 2), 1, 2),
      ]);
      expect(same.trendDelta, 0);
      expect(
          SubscriberPerformanceSummary.fromResults([
            _result('one', DateTime(2025), 1, 2),
          ]).trendDelta,
          isNull);
      final empty = SubscriberPerformanceSummary.fromResults(const []);
      expect(empty.average, 0);
      expect(empty.highest, isNull);
      expect(
          ResultsStatusMapper.percentage(_result('zero', DateTime(2025), 0, 0)),
          0);
    });

    test(
        'uses the shared My Results percentage and records source discrepancies',
        () {
      final result = _result('mismatch', DateTime(2025), 1, 2, storedResult: 2);
      final summary = SubscriberPerformanceSummary.fromResults([result]);
      expect(
          summary.percentages.single, ResultsStatusMapper.percentage(result));
      expect(summary.percentages.single, 50);
      expect(summary.resultDiscrepancyCount, 1);
    });
  });
}

TestResultEntity _result(String id, DateTime date, int correct, int total,
    {int? storedResult}) {
  final question = CourseTestQuestionEntity(
      questionId: 'q', questionTitle: '', solutions: [], isOpened: false);
  return TestResultEntity(
    serialNumber: id,
    joinedDate: date,
    totalQuestions: total,
    solvedQuestions: total,
    isPassed: correct >= total / 2,
    sectionId: 'section',
    testId: 'test',
    joinedbyentity: JoinedByEntity(
        uid: 'student', name: 'Student', imageUrl: '', joinedDate: date),
    courseId: 'course',
    courseSubject: 'Subject',
    result: storedResult ?? correct,
    questionsSolvedListEntity: List.generate(
        total,
        (i) => ExamResultSolvedQuestionEntity(
            question: question, isCorrect: i < correct)),
  );
}
