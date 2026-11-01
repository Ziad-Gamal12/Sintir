class MyResultsOverview {
  const MyResultsOverview(
      {required this.totalCount, required this.averagePercent});
  final int totalCount;
  final int averagePercent;
}

class MyResultsOverviewCalculator {
  const MyResultsOverviewCalculator._();

  static MyResultsOverview fromDocuments(List<Map<String, dynamic>> documents,
      {int? totalCount}) {
    if (documents.isEmpty) {
      return MyResultsOverview(totalCount: totalCount ?? 0, averagePercent: 0);
    }
    var totalPercent = 0;
    for (final document in documents) {
      final total = (document['totalQuestions'] as num?)?.toInt() ?? 0;
      final answers =
          document['questionsSolvedList'] as List<dynamic>? ?? const [];
      final correct = answers
          .where((answer) =>
              answer is Map<String, dynamic> && answer['isCorrect'] == true)
          .length;
      final percent = total <= 0
          ? 0
          : (correct * 100 / total).round().clamp(0, 100).toInt();
      totalPercent += percent;
    }
    return MyResultsOverview(
      totalCount: totalCount ?? documents.length,
      averagePercent:
          (totalPercent / documents.length).round().clamp(0, 100).toInt(),
    );
  }
}
