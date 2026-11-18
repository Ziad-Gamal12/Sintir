class CourseRatingStatsEntity {
  const CourseRatingStatsEntity({
    this.ratingsSum = 0,
    this.ratingsCount = 0,
    this.feedBacksCount = 0,
    this.distribution = const {},
  });

  static const String sumField = 'ratingsSum';
  static const String countField = 'ratingsCount';
  static const String distributionField = 'ratingDistribution';
  static const String feedBacksCountField = 'feedBacksCount';

  final int ratingsSum;
  final int ratingsCount;

  final int feedBacksCount;

  final Map<int, int> distribution;

  bool get hasRatings => ratingsCount > 0;

  double get average {
    if (ratingsCount <= 0 || ratingsSum <= 0) return 0;
    return (ratingsSum / ratingsCount).clamp(1, 5).toDouble();
  }

  int countFor(int star) => distribution[star] ?? 0;

  double shareOf(int star) {
    if (ratingsCount <= 0) return 0;
    return (countFor(star) / ratingsCount).clamp(0, 1).toDouble();
  }

  factory CourseRatingStatsEntity.fromJson(Map<String, dynamic>? json) {
    if (json == null) return const CourseRatingStatsEntity();
    final distribution = <int, int>{};
    final rawDistribution = json[distributionField];
    if (rawDistribution is Map) {
      for (var star = 1; star <= 5; star++) {
        final count = _nonNegativeInt(rawDistribution['$star']);
        if (count > 0) distribution[star] = count;
      }
    }
    final ratingsCount = _nonNegativeInt(json[countField]);
    return CourseRatingStatsEntity(
      ratingsSum: ratingsCount == 0 ? 0 : _nonNegativeInt(json[sumField]),
      ratingsCount: ratingsCount,
      feedBacksCount: _nonNegativeInt(json[feedBacksCountField]),
      distribution: Map<int, int>.unmodifiable(distribution),
    );
  }

  static int _nonNegativeInt(Object? value) {
    if (value is! num || !value.isFinite || value <= 0) return 0;
    return value.floor();
  }
}
