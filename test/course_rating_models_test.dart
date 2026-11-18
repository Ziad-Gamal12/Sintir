import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sintir/Core/entities/CourseEntities/CourseEntity.dart';
import 'package:sintir/Core/entities/CourseEntities/CourseRatingStatsEntity.dart';
import 'package:sintir/Core/models/CourseModel.dart';
import 'package:sintir/Core/repos/CourseFeedBacksRepo/CourseFeedBacksRepoImpli.dart';
import 'package:sintir/Features/CourseManagementAndInteractionFeature/data/models/CourseFedBacksModel.dart';

void main() {
  group('CourseRatingStatsEntity', () {
    test('reads the stats the edge function writes', () {
      final stats = CourseRatingStatsEntity.fromJson({
        'ratingsSum': 9,
        'ratingsCount': 2,
        'averageRating': 4.5,
        'ratingDistribution': {'1': 0, '2': 0, '3': 0, '4': 1, '5': 1},
        'feedBacksCount': 3,
      });
      expect(stats.hasRatings, isTrue);
      expect(stats.average, 4.5);
      expect(stats.countFor(5), 1);
      expect(stats.countFor(1), 0);
      expect(stats.shareOf(4), 0.5);
      expect(stats.feedBacksCount, 3);
    });

    test('courses created before ratings read as empty stats', () {
      final stats = CourseRatingStatsEntity.fromJson({
        'title': 'Math',
        'feedBacksCount': 7,
      });
      expect(stats.hasRatings, isFalse);
      expect(stats.average, 0);
      expect(stats.shareOf(5), 0);
      expect(stats.feedBacksCount, 7);
      expect(CourseRatingStatsEntity.fromJson(null).ratingsCount, 0);
    });

    test('numbers stored as integers or doubles both work', () {
      expect(
        CourseRatingStatsEntity.fromJson({
          'ratingsSum': 10,
          'ratingsCount': 2,
        }).average,
        5,
      );
      expect(
        CourseRatingStatsEntity.fromJson({
          'ratingsSum': 8.0,
          'ratingsCount': 2.0,
        }).average,
        4,
      );
    });

    test('corrupted values never produce impossible numbers', () {
      final stats = CourseRatingStatsEntity.fromJson({
        'ratingsSum': -4,
        'ratingsCount': '3',
        'feedBacksCount': double.nan,
        'ratingDistribution': {'5': -1, '4': 2.9, '9': 4},
      });
      expect(stats.ratingsCount, 0);
      expect(stats.ratingsSum, 0);
      expect(stats.feedBacksCount, 0);
      expect(stats.countFor(5), 0);
      expect(stats.countFor(4), 2);

      expect(
        CourseRatingStatsEntity.fromJson({
          'ratingsSum': 40,
          'ratingsCount': 2,
        }).average,
        5,
      );
      expect(
        CourseRatingStatsEntity.fromJson({
          'ratingsSum': 5,
          'ratingsCount': 1,
          'ratingDistribution': {'5': 3},
        }).shareOf(5),
        1,
      );
    });
  });

  group('Coursemodel', () {
    test('parses rating stats but never writes them back', () {
      final model = Coursemodel.fromJson({
        ..._courseJson,
        'ratingsSum': 14,
        'ratingsCount': 3,
        'ratingDistribution': {'4': 1, '5': 2},
      });
      expect(model.toEntity().ratingStats.ratingsCount, 3);
      expect(model.toJson().containsKey('ratingsSum'), isFalse);
      expect(model.toJson().containsKey('ratingDistribution'), isFalse);
    });

    test('editable fields exclude counters and rating stats', () {
      final entity = Coursemodel.fromJson(_courseJson).toEntity();
      entity.title = 'New title';
      final editable = Coursemodel.fromEntity(
        courseEntity: entity,
      ).toEditableJson();
      expect(editable.keys.toSet(), {
        'title',
        'description',
        'posterUrl',
        'price',
        'language',
        'subject',
        'level',
        'state',
      });
      expect(editable['title'], 'New title');
    });

    test('CourseEntity defaults to empty rating stats', () {
      expect(CourseEntity.empty().ratingStats.hasRatings, isFalse);
    });
  });

  group('Coursefeedbacksmodel', () {
    final posted = DateTime(2026, 9, 6, 12);

    test('reads an old review that has no rating', () {
      final review = Coursefeedbacksmodel.fromJson({
        'uid': 's1',
        'name': 'Ziad Gamal',
        'userImage': 'https://img.example/s1.png',
        'fedBack': 'مدرس ممتاز',
        'datePosted': Timestamp.fromDate(posted),
      }).toEntity();
      expect(review.rating, isNull);
      expect(review.updatedAt, isNull);
      expect(review.fedBack, 'مدرس ممتاز');
      expect(review.datePosted, posted);
    });

    test('reads a rated review from Firestore', () {
      final review = Coursefeedbacksmodel.fromJson({
        'uid': 's1',
        'name': 'Ziad Gamal',
        'userImage': '',
        'fedBack': '',
        'rating': 4,
        'datePosted': Timestamp.fromDate(posted),
        'updatedAt': Timestamp.fromDate(posted.add(const Duration(days: 1))),
      }).toEntity();
      expect(review.rating, 4);
      expect(review.updatedAt, posted.add(const Duration(days: 1)));
    });

    test('reads the edge function response with ISO dates', () {
      final review = Coursefeedbacksmodel.fromJson({
        'uid': 's1',
        'name': 'Ziad Gamal',
        'userImage': '',
        'fedBack': 'great',
        'rating': 5,
        'datePosted': '2026-11-17T10:00:00.000Z',
        'updatedAt': '2026-11-17T10:00:03.000Z',
      }).toEntity();
      expect(review.rating, 5);
      expect(review.datePosted.toUtc(), DateTime.utc(2026, 11, 17, 10));
      expect(review.updatedAt!.toUtc(), DateTime.utc(2026, 11, 17, 10, 0, 3));
    });

    test('only whole ratings from 1 to 5 count', () {
      for (final bad in <Object?>[
        0,
        6,
        4.5,
        '5',
        null,
        double.nan,
        double.infinity,
      ]) {
        expect(Coursefeedbacksmodel.parseRating(bad), isNull, reason: '$bad');
      }
      expect(Coursefeedbacksmodel.parseRating(3), 3);
      expect(Coursefeedbacksmodel.parseRating(3.0), 3);
    });

    test('a page skips unreadable documents instead of failing', () {
      final page = parseCourseFeedbacks([
        {'uid': 'ok', 'rating': 5, 'datePosted': Timestamp.fromDate(posted)},
        {'name': 'no uid', 'datePosted': Timestamp.fromDate(posted)},
        {'uid': 'no-date'},
        'not a map',
        {
          'uid': 'legacy',
          'name': 7,
          'fedBack': 'old',
          'datePosted': Timestamp.fromDate(posted),
        },
      ]);
      expect(page.map((review) => review.uid).toList(), ['ok', 'legacy']);
      expect(page.last.name, '');
      expect(page.last.rating, isNull);
    });
  });
}

final Map<String, dynamic> _courseJson = {
  'id': 'course-1',
  'title': 'Math',
  'description': 'Algebra',
  'language': 'Arabic',
  'state': 'Published',
  'price': 170,
  'studentsCount': 12,
  'lessonsCount': 4,
  'testsCount': 2,
  'feedBacksCount': 3,
  'posterUrl': 'https://img.example/poster.png',
  'postedDate': Timestamp.fromDate(DateTime(2026, 1, 1)),
  'subject': 'Math',
  'level': 'Secondary',
  'contentcreaterentity': {
    'id': 'teacher-1',
    'name': 'Mohamed Ashref',
    'profileImageUrl': '',
    'title': 'Math teacher',
  },
};
