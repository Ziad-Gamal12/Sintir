import 'package:flutter_test/flutter_test.dart';
import 'package:sintir/Features/MyResults/Data/Repo/my_results_overview_calculator.dart';

void main() {
  group('MyResultsOverviewCalculator', () {
    test('counts and averages every supplied result document', () {
      final overview = MyResultsOverviewCalculator.fromDocuments([
        {
          'totalQuestions': 4,
          'questionsSolvedList': [
            {'isCorrect': true},
            {'isCorrect': true},
            {'isCorrect': false},
            {'isCorrect': false},
          ],
        },
        {
          'totalQuestions': 2,
          'questionsSolvedList': [
            {'isCorrect': true},
            {'isCorrect': true},
          ],
        },
        {
          'totalQuestions': 0,
          'questionsSolvedList': <Map<String, dynamic>>[],
        },
      ]);

      expect(overview.totalCount, 3);
      expect(overview.averagePercent, 50);
    });

    test('returns zero values for an empty collection', () {
      final overview = MyResultsOverviewCalculator.fromDocuments([]);

      expect(overview.totalCount, 0);
      expect(overview.averagePercent, 0);
    });
  });
}
