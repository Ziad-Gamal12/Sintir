import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sintir/Core/utils/Backend_EndPoints.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/Widgets/TeacherWorkenvironmentviewWidgets/TeacherCourseCard/utils/teacher_course_card_metrics.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/Widgets/TeacherWorkenvironmentviewWidgets/TeacherCourseStatus.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/Widgets/TeacherWorkenvironmentviewWidgets/TeacherWorkEnvironmentBreakpoints.dart';

void main() {
  group('TeacherCourseStatus mapping tests', () {
    test('maps raw backend strings correctly', () {
      expect(
        TeacherCourseStatus.fromRaw(BackendEndpoints.coursePublishedState),
        TeacherCourseStatus.published,
      );
      expect(
        TeacherCourseStatus.fromRaw(BackendEndpoints.coursePendingState),
        TeacherCourseStatus.inReview,
      );
      expect(
        TeacherCourseStatus.fromRaw(BackendEndpoints.courseDeletedState),
        TeacherCourseStatus.archived,
      );
      expect(
        TeacherCourseStatus.fromRaw('loading'),
        TeacherCourseStatus.unknown,
      );
      expect(
        TeacherCourseStatus.fromRaw('unknown_state'),
        TeacherCourseStatus.unknown,
      );
      expect(TeacherCourseStatus.fromRaw(null), TeacherCourseStatus.unknown);
    });
  });

  group('TeacherWorkEnvironmentFormatters tests', () {
    test('formats numbers with Western digits and thousands separators', () {
      expect(
        TeacherWorkEnvironmentFormatters.formatAmount(1323.00),
        '1,323.00',
      );
      expect(TeacherWorkEnvironmentFormatters.formatAmount(250.0), '250.00');
      expect(TeacherWorkEnvironmentFormatters.formatPrice(1300), '1,300');
      expect(TeacherWorkEnvironmentFormatters.formatPrice(0), '0');
    });

    test('normalizes Arabic and Latin search text correctly', () {
      // Strips tashkeel
      expect(
        TeacherWorkEnvironmentFormatters.normalizeSearch('كُوْرْسٌ'),
        'كورس',
      );
      // Folds alef variants: أ/إ/آ/ٱ -> ا and ة -> ه
      expect(
        TeacherWorkEnvironmentFormatters.normalizeSearch('أحمد إبراهيم آية'),
        'احمد ابراهيم ايه',
      );
      // Folds ى -> ي and ة -> ه
      expect(
        TeacherWorkEnvironmentFormatters.normalizeSearch('مراجعة نهائية كبرى'),
        'مراجعه نهائيه كبري',
      );
      // Lowercases Latin text
      expect(
        TeacherWorkEnvironmentFormatters.normalizeSearch(' Flutter Course '),
        'flutter course',
      );
    });

    test('formats Arabic plurals exactly matching Image 3 spec', () {
      // Students: 0 -> 0 طلاب, 3-10 -> طلاب, 11+ -> طالب
      expect(
        TeacherWorkEnvironmentFormatters.formatStudentsCount(0, 'ar'),
        '0 طلاب',
      );
      expect(
        TeacherWorkEnvironmentFormatters.formatStudentsCount(1, 'ar'),
        '1 طالب',
      );
      expect(
        TeacherWorkEnvironmentFormatters.formatStudentsCount(2, 'ar'),
        '2 طالب',
      );
      expect(
        TeacherWorkEnvironmentFormatters.formatStudentsCount(8, 'ar'),
        '8 طلاب',
      );
      expect(
        TeacherWorkEnvironmentFormatters.formatStudentsCount(10, 'ar'),
        '10 طلاب',
      );
      expect(
        TeacherWorkEnvironmentFormatters.formatStudentsCount(11, 'ar'),
        '11 طالب',
      );
      expect(
        TeacherWorkEnvironmentFormatters.formatStudentsCount(21, 'ar'),
        '21 طالب',
      );

      // Lessons: 0 -> 0 دروس, 3-10 -> دروس, 11+ -> درس
      expect(
        TeacherWorkEnvironmentFormatters.formatLessonsCount(0, 'ar'),
        '0 دروس',
      );
      expect(
        TeacherWorkEnvironmentFormatters.formatLessonsCount(8, 'ar'),
        '8 دروس',
      );
      expect(
        TeacherWorkEnvironmentFormatters.formatLessonsCount(10, 'ar'),
        '10 دروس',
      );
      expect(
        TeacherWorkEnvironmentFormatters.formatLessonsCount(12, 'ar'),
        '12 درس',
      );
      expect(
        TeacherWorkEnvironmentFormatters.formatLessonsCount(28, 'ar'),
        '28 درس',
      );

      // Tests: 1 -> 1 اختبار, 2 -> 2 اختبار, 3-10 -> اختبارات, 11+ -> اختبار
      expect(
        TeacherWorkEnvironmentFormatters.formatTestsCount(0, 'ar'),
        '0 اختبار',
      );
      expect(
        TeacherWorkEnvironmentFormatters.formatTestsCount(1, 'ar'),
        '1 اختبار',
      );
      expect(
        TeacherWorkEnvironmentFormatters.formatTestsCount(2, 'ar'),
        '2 اختبار',
      );
      expect(
        TeacherWorkEnvironmentFormatters.formatTestsCount(3, 'ar'),
        '3 اختبارات',
      );
      expect(
        TeacherWorkEnvironmentFormatters.formatTestsCount(6, 'ar'),
        '6 اختبارات',
      );
      expect(
        TeacherWorkEnvironmentFormatters.formatTestsCount(11, 'ar'),
        '11 اختبار',
      );
    });

    test('formats English and French plurals correctly', () {
      expect(
        TeacherWorkEnvironmentFormatters.formatStudentsCount(1, 'en'),
        '1 student',
      );
      expect(
        TeacherWorkEnvironmentFormatters.formatStudentsCount(8, 'en'),
        '8 students',
      );
      expect(
        TeacherWorkEnvironmentFormatters.formatStudentsCount(1, 'fr'),
        '1 élève',
      );
      expect(
        TeacherWorkEnvironmentFormatters.formatStudentsCount(8, 'fr'),
        '8 élèves',
      );
    });
  });

  group('TeacherWorkEnvironmentLayout tests', () {
    test('computes column counts across breakpoints', () {
      expect(TeacherWorkEnvironmentLayout.getGridColumnCount(360), 2);
      expect(TeacherWorkEnvironmentLayout.getGridColumnCount(390), 2);
      expect(TeacherWorkEnvironmentLayout.getGridColumnCount(600), 2);
      expect(TeacherWorkEnvironmentLayout.getGridColumnCount(700), 3);
      expect(TeacherWorkEnvironmentLayout.getGridColumnCount(1200), 5);
    });

    testWidgets('card extent expands with text scale factor', (tester) async {
      Future<double> measure(double textScale) async {
        late double extent;
        await tester.pumpWidget(
          MediaQuery(
            data: MediaQueryData(
              size: const Size(390, 844),
              textScaler: TextScaler.linear(textScale),
            ),
            child: Builder(
              builder: (context) {
                extent = TeacherCourseCardMetrics.heightForWidth(context, 180);
                return const SizedBox();
              },
            ),
          ),
        );
        return extent;
      }

      final extentScale1 = await measure(1.0);
      final extentScale2 = await measure(2.0);

      expect(extentScale2, greaterThan(extentScale1));
      // Poster at 16:9 for width 180 is 101.25; the body (title, price row,
      // divider, footer with room for the "New" chip) adds ~99 at 390 wide.
      expect(extentScale1, closeTo(201, 0.5));
    });
  });
}
