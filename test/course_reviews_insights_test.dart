import 'package:flutter_test/flutter_test.dart';
import 'package:sintir/Features/CourseManagementAndInteractionFeature/domain/Entities/CoursefedbackItemEntity.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/domain/Entities/CourseReviewsInsights.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/domain/Entities/CourseReviewsQuery.dart';

final _now = DateTime(2026, 11, 17, 12);

CoursefeedbackItemEntity _review(
  String uid, {
  int? rating,
  required int daysAgo,
}) {
  return CoursefeedbackItemEntity(
    userImage: '',
    name: 'Student $uid',
    uid: uid,
    fedBack: '',
    datePosted: _now.subtract(Duration(days: daysAgo)),
    rating: rating,
  );
}

CourseReviewsInsights _compute(
  List<CoursefeedbackItemEntity> reviews, {
  double overall = 4,
  bool isComplete = true,
  DateTime? lastSeen,
}) => CourseReviewsInsights.compute(
  reviews: reviews,
  isComplete: isComplete,
  overallAverage: overall,
  now: _now,
  lastSeen: lastSeen,
);

void main() {
  group('fetchSince', () {
    test('first visit and recent visits read the last 30 days', () {
      final window = _now.subtract(const Duration(days: 30));
      expect(CourseReviewsInsights.fetchSince(now: _now), window);
      expect(
        CourseReviewsInsights.fetchSince(
          now: _now,
          lastSeen: _now.subtract(const Duration(days: 3)),
        ),
        window,
      );
    });

    test('an older visit reads back to it, at most 90 days', () {
      final lastSeen = _now.subtract(const Duration(days: 45));
      expect(
        CourseReviewsInsights.fetchSince(now: _now, lastSeen: lastSeen),
        lastSeen,
      );
      expect(
        CourseReviewsInsights.fetchSince(
          now: _now,
          lastSeen: _now.subtract(const Duration(days: 200)),
        ),
        _now.subtract(const Duration(days: 90)),
      );
    });
  });

  group('trend against the course average', () {
    test('up, down and steady need at least three recent ratings', () {
      expect(
        _compute([
          _review('a', rating: 5, daysAgo: 1),
          _review('b', rating: 5, daysAgo: 2),
          _review('c', rating: 4, daysAgo: 3),
        ]).trend,
        CourseReviewsTrend.up,
      );
      expect(
        _compute([
          _review('a', rating: 3, daysAgo: 1),
          _review('b', rating: 3, daysAgo: 2),
          _review('c', rating: 4, daysAgo: 3),
        ]).trend,
        CourseReviewsTrend.down,
      );
      expect(
        _compute([
          _review('a', rating: 4, daysAgo: 1),
          _review('b', rating: 4, daysAgo: 2),
          _review('c', rating: 4, daysAgo: 3),
        ]).trend,
        CourseReviewsTrend.steady,
      );
      expect(
        _compute([
          _review('a', rating: 1, daysAgo: 1),
          _review('b', rating: 1, daysAgo: 2),
        ]).trend,
        CourseReviewsTrend.unknown,
      );
    });

    test('a 0.1 gap counts even with floating point noise', () {
      final ratings = [5, 4, 4, 4, 5, 4, 4, 5, 4, 4];
      final insights = _compute([
        for (var i = 0; i < ratings.length; i++)
          _review('r$i', rating: ratings[i], daysAgo: i + 1),
      ], overall: 4.2);
      expect(insights.recentAverage, closeTo(4.3, 0.0001));
      expect(insights.trend, CourseReviewsTrend.up);
    });

    test('old and unrated reviews stay out of the 30 day average', () {
      final insights = _compute([
        _review('a', rating: 5, daysAgo: 2),
        _review('b', daysAgo: 3),
        _review('c', rating: 1, daysAgo: 40),
      ]);
      expect(insights.recentRatingsCount, 1);
      expect(insights.recentAverage, 5);
      expect(insights.hasRecentRatings, isTrue);
    });
  });

  group('new since last visit', () {
    test('is hidden on the first visit', () {
      final insights = _compute([_review('a', rating: 5, daysAgo: 1)]);
      expect(insights.newCount, isNull);
      expect(insights.newCountIsPartial, isFalse);
    });

    test('counts every review posted after the visit, rated or not', () {
      final insights = _compute([
        _review('a', rating: 5, daysAgo: 1),
        _review('b', daysAgo: 2),
        _review('c', rating: 2, daysAgo: 6),
      ], lastSeen: _now.subtract(const Duration(days: 4)));
      expect(insights.newCount, 2);
      expect(insights.newCountIsPartial, isFalse);
    });

    test('is partial when the read was cut or the visit is too old', () {
      final recentVisit = _now.subtract(const Duration(days: 4));
      expect(
        _compute(
          [_review('a', daysAgo: 1)],
          isComplete: false,
          lastSeen: recentVisit,
        ).newCountIsPartial,
        isTrue,
      );
      final oldVisit = _now.subtract(const Duration(days: 120));
      expect(
        _compute([_review('a', daysAgo: 1)], lastSeen: oldVisit)
            .newCountIsPartial,
        isTrue,
      );
    });
  });

  group('query', () {
    test('values compare by content and keep separate cache keys', () {
      expect(CourseReviewsQuery.stars(3), CourseReviewsQuery.stars(3));
      expect(CourseReviewsQuery.stars(3), isNot(CourseReviewsQuery.stars(4)));
      expect(CourseReviewsQuery.newest.isNewest, isTrue);
      expect(CourseReviewsQuery.lowestRated.isNewest, isFalse);
      expect(
        {
          CourseReviewsQuery.newest.cacheKey,
          CourseReviewsQuery.lowestRated.cacheKey,
          CourseReviewsQuery.stars(1).cacheKey,
          CourseReviewsQuery.stars(5).cacheKey,
        },
        hasLength(4),
      );
      expect(() => CourseReviewsQuery.stars(0), throwsRangeError);
      expect(() => CourseReviewsQuery.stars(6), throwsRangeError);
    });
  });
}
