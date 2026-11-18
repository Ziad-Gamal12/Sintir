import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:localingo/localingo.dart';
import 'package:sintir/Core/Themes/app_theme.dart';
import 'package:sintir/Core/entities/CourseEntities/ContentCreaterEntity.dart';
import 'package:sintir/Core/entities/CourseEntities/CourseEntity.dart';
import 'package:sintir/Core/entities/CourseEntities/CourseRatingStatsEntity.dart';
import 'package:sintir/Core/utils/course_price_formatter.dart';
import 'package:sintir/Core/widgets/Custom%20Course%20Widgets/CourseCardMetrics.dart';
import 'package:sintir/Core/widgets/Custom%20Course%20Widgets/CourseItemBadge.dart';
import 'package:sintir/Core/widgets/Custom%20Course%20Widgets/CourseItemDetails.dart';
import 'package:sintir/Core/widgets/Custom%20Course%20Widgets/CourseItemImage.dart';
import 'package:sintir/Core/widgets/Custom%20Course%20Widgets/CourseItemMeta.dart';
import 'package:sintir/Core/widgets/Custom%20Course%20Widgets/CourseItemPrice.dart';

Future<void> _pump(
  WidgetTester tester,
  Widget child, {
  Locale locale = const Locale('en'),
  ThemeData? theme,
  Size size = const Size(411, 900),
  double textScale = 1,
}) async {
  final navigatorKey = GlobalKey<NavigatorState>();
  Localingo.setNavigatorKey(navigatorKey);
  tester.view.devicePixelRatio = 1;
  tester.view.physicalSize = size;
  await tester.pumpWidget(
    MaterialApp(
      navigatorKey: navigatorKey,
      locale: locale,
      supportedLocales: const [Locale('ar'), Locale('en'), Locale('fr')],
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      theme: theme ?? AppTheme.light,
      home: MediaQuery(
        data: MediaQueryData(
          size: size,
          textScaler: TextScaler.linear(textScale),
        ),
        child: Scaffold(body: child),
      ),
    ),
  );
  await tester.pumpAndSettle();
}

void _resetView(WidgetTester tester) {
  tester.view.resetPhysicalSize();
  tester.view.resetDevicePixelRatio();
}

CourseEntity _course({
  String id = 'c1',
  String title = 'Chemistry, full second term',
  int price = 150,
  int ratingsCount = 0,
  int ratingsSum = 0,
  int students = 0,
  int lessons = 0,
  Duration age = const Duration(days: 60),
  String teacher = 'Ziad Gamal',
}) {
  return CourseEntity(
    id: id,
    state: 'published',
    posterUrl: '',
    studentsCount: students,
    subject: 'Chemistry',
    level: '3rd Grade Secondary',
    title: title,
    description: '',
    price: price,
    language: 'العربية',
    postedDate: DateTime.now().subtract(age),
    lessonsCount: lessons,
    testsCount: 0,
    feedBacksCount: 0,
    contentcreaterentity: Contentcreaterentity(
      name: teacher,
      profileImageUrl: '',
      id: 't1',
      title: '',
    ),
    ratingStats: CourseRatingStatsEntity(
      ratingsSum: ratingsSum,
      ratingsCount: ratingsCount,
    ),
  );
}

String _metaText(WidgetTester tester) {
  final text = tester.widget<Text>(find.byKey(const ValueKey('course-card-meta')));
  return text.textSpan!.toPlainText();
}

Widget _details(CourseEntity course, double width) => Builder(
      builder: (context) => Align(
        alignment: Alignment.topCenter,
        child: MediaQuery.withClampedTextScaling(
          maxScaleFactor: CourseCardMetrics.maxTextScale,
          child: SizedBox(
            width: width,
            height: CourseCardMetrics.detailsHeight(context),
            child: Padding(
              padding: CourseCardMetrics.detailsPadding,
              child: CourseItemDetails(courseItem: course),
            ),
          ),
        ),
      ),
    );

void main() {
  testWidgets('meta shows the rating and students once there are 10 or more', (
    tester,
  ) async {
    await _pump(
      tester,
      CourseItemMeta(
        course: _course(ratingsCount: 12, ratingsSum: 52, students: 21),
      ),
    );
    final text = _metaText(tester);
    expect(text, contains('4.3'));
    expect(text, contains('(12)'));
    expect(text, contains('21 students'));
    _resetView(tester);
  });

  testWidgets('meta hides a small students count and keeps the rating', (
    tester,
  ) async {
    await _pump(
      tester,
      CourseItemMeta(
        course: _course(
          ratingsCount: 2,
          ratingsSum: 9,
          students: 3,
          lessons: 8,
        ),
      ),
    );
    final text = _metaText(tester);
    expect(text, contains('4.5'));
    expect(text, isNot(contains('students')));
    expect(text, isNot(contains('lessons')));
    _resetView(tester);
  });

  testWidgets('meta falls back to the lessons count for a new course', (
    tester,
  ) async {
    await _pump(
      tester,
      CourseItemMeta(course: _course(students: 1, lessons: 8)),
    );
    expect(_metaText(tester), '8 lessons');
    _resetView(tester);
  });

  testWidgets('meta is empty with no rating, few students and no lessons', (
    tester,
  ) async {
    await _pump(tester, CourseItemMeta(course: _course(students: 2)));
    expect(find.byKey(const ValueKey('course-card-meta')), findsNothing);
    _resetView(tester);
  });

  testWidgets('Arabic meta uses correct plural for 21 students', (
    tester,
  ) async {
    await _pump(
      tester,
      CourseItemMeta(course: _course(students: 21)),
      locale: const Locale('ar'),
    );
    expect(_metaText(tester), '21 طالبًا');
    _resetView(tester);
  });

  testWidgets('price: free in green, paid with thousands separator', (
    tester,
  ) async {
    await _pump(tester, const CourseItemPrice(price: 0));
    expect(find.text('Free'), findsOneWidget);

    await _pump(tester, const CourseItemPrice(price: 1300));
    expect(find.text('1,300 EGP'), findsOneWidget);

    await _pump(
      tester,
      const CourseItemPrice(price: 200),
      locale: const Locale('ar'),
    );
    expect(find.text('200 ج.م'), findsOneWidget);
    _resetView(tester);
  });

  testWidgets('price formatter keeps piastres only when there are any', (
    tester,
  ) async {
    await _pump(tester, const SizedBox());
    expect(CoursePriceFormatter.fromCents(20000, 'en'), '200 EGP');
    expect(CoursePriceFormatter.fromCents(13950, 'en'), '139.5 EGP');
    _resetView(tester);
  });

  test('new badge only within 14 days and never on loading cards', () {
    final now = DateTime(2026, 11, 17);
    CourseEntity posted(Duration age, {String id = 'c1'}) =>
        _course(id: id).copyWithPostedDate(now.subtract(age));
    expect(CourseItemBadge.isNew(posted(const Duration(days: 2)), now: now),
        isTrue);
    expect(CourseItemBadge.isNew(posted(const Duration(days: 30)), now: now),
        isFalse);
    expect(
      CourseItemBadge.isNew(
        posted(Duration.zero, id: CourseEntity.loadingId),
        now: now,
      ),
      isFalse,
    );
  });

  testWidgets('empty poster url shows a placeholder instead of a network image',
      (tester) async {
    await _pump(
      tester,
      const SizedBox(width: 160, height: 90, child: CourseItemImage(imageUrl: '')),
    );
    expect(find.byKey(const ValueKey('course-image-placeholder')), findsOneWidget);
    _resetView(tester);
  });

  testWidgets('details fit their computed height without overflow', (
    tester,
  ) async {
    final course = _course(
      title:
          'A very long physics course title that keeps going for the whole term and past exams',
      ratingsCount: 31,
      ratingsSum: 143,
      students: 1250,
      price: 1300,
    );
    for (final locale in const [Locale('en'), Locale('ar')]) {
      for (final scale in const [1.0, 1.3]) {
        for (final width in const [150.0, 171.0, 230.0]) {
          for (final theme in [AppTheme.light, AppTheme.dark]) {
            await _pump(
              tester,
              _details(course, width),
              locale: locale,
              textScale: scale,
              theme: theme,
            );
            expect(tester.takeException(), isNull,
                reason: '$locale scale $scale width $width');
          }
        }
      }
    }
    _resetView(tester);
  });

  test('grid delegate sizes cells from the available width', () {
    const delegate = CourseCardGridDelegate(detailsHeight: 140, spacing: 16);
    const constraints = SliverConstraints(
      axisDirection: AxisDirection.down,
      growthDirection: GrowthDirection.forward,
      userScrollDirection: ScrollDirection.idle,
      scrollOffset: 0,
      precedingScrollExtent: 0,
      overlap: 0,
      remainingPaintExtent: 800,
      crossAxisExtent: 358,
      crossAxisDirection: AxisDirection.left,
      viewportMainAxisExtent: 800,
      remainingCacheExtent: 800,
      cacheOrigin: 0,
    );
    final layout =
        delegate.getLayout(constraints) as SliverGridRegularTileLayout;
    expect(layout.crossAxisCount, 2);
    expect(layout.childCrossAxisExtent, 171);
    expect(
      layout.childMainAxisExtent,
      CourseCardMetrics.heightForDetails(171, 140),
    );
    expect(layout.mainAxisStride, layout.childMainAxisExtent + 16);
  });
}

extension on CourseEntity {
  CourseEntity copyWithPostedDate(DateTime date) => CourseEntity(
        id: id,
        state: state,
        posterUrl: posterUrl,
        studentsCount: studentsCount,
        subject: subject,
        level: level,
        title: title,
        description: description,
        price: price,
        language: language,
        postedDate: date,
        lessonsCount: lessonsCount,
        testsCount: testsCount,
        feedBacksCount: feedBacksCount,
        contentcreaterentity: contentcreaterentity,
        ratingStats: ratingStats,
      );
}
