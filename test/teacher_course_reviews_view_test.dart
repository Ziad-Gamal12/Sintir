import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:localingo/localingo.dart';
import 'package:sintir/Core/Themes/app_theme.dart';
import 'package:sintir/Core/entities/CourseEntities/CourseRatingStatsEntity.dart';
import 'package:sintir/Core/entities/FetchDataResponses/GetCourseFeedBacksResponseEntity.dart';
import 'package:sintir/Core/errors/Failures.dart';
import 'package:sintir/Features/CourseManagementAndInteractionFeature/domain/Entities/CoursefedbackItemEntity.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/domain/Entities/CourseReviewsQuery.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/domain/Repos/TeacherCourseReviewsRepo.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/Widgets/TeacherCourseReviews/TeacherCourseReviewsViewBody.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/manager/teacher_course_reviews_cubit/teacher_course_reviews_cubit.dart';

class _InstantRepo implements TeacherCourseReviewsRepo {
  _InstantRepo({
    required this.pages,
    this.stats = const CourseRatingStatsEntity(),
    this.recent = const [],
    this.seen,
  });

  final Map<CourseReviewsQuery, List<CoursefeedbackItemEntity>> pages;
  final CourseRatingStatsEntity stats;
  final List<CoursefeedbackItemEntity> recent;
  final DateTime? seen;
  final List<CourseReviewsQuery> queries = [];

  @override
  Future<Either<Failure, GetCourseFeedBacksResponseEntity>> getReviews({
    required String courseId,
    required CourseReviewsQuery query,
    required bool isPaginate,
  }) async {
    queries.add(query);
    return right(
      GetCourseFeedBacksResponseEntity(
        feedBacks: isPaginate ? const [] : pages[query] ?? const [],
        hasMore: false,
        isPaginate: isPaginate,
      ),
    );
  }

  @override
  Future<Either<Failure, CourseRatingStatsEntity>> getRatingStats({
    required String courseId,
  }) async => right(stats);

  @override
  Future<Either<Failure, GetCourseFeedBacksResponseEntity>> getReviewsSince({
    required String courseId,
    required DateTime since,
  }) async => right(
    GetCourseFeedBacksResponseEntity(
      feedBacks: recent,
      hasMore: false,
      isPaginate: false,
    ),
  );

  @override
  DateTime? lastSeenAt(String courseId) => seen;

  @override
  Future<void> markSeen(String courseId, DateTime at) async {}
}

CoursefeedbackItemEntity _review(
  String uid, {
  int? rating = 5,
  Duration age = const Duration(days: 1),
  String text = '',
}) {
  return CoursefeedbackItemEntity(
    userImage: '',
    name: 'Student $uid',
    uid: uid,
    fedBack: text,
    datePosted: DateTime.now().subtract(age),
    rating: rating,
  );
}

const _stats = CourseRatingStatsEntity(
  ratingsSum: 42,
  ratingsCount: 10,
  feedBacksCount: 10,
  distribution: {5: 5, 4: 3, 3: 1, 1: 1},
);

Future<_InstantRepo> _pump(
  WidgetTester tester,
  _InstantRepo repo, {
  Locale locale = const Locale('en'),
  ThemeData? theme,
  Size size = const Size(411, 900),
}) async {
  final navigatorKey = GlobalKey<NavigatorState>();
  Localingo.setNavigatorKey(navigatorKey);
  tester.view.devicePixelRatio = 1;
  tester.view.physicalSize = size;
  addTearDown(tester.view.resetPhysicalSize);
  addTearDown(tester.view.resetDevicePixelRatio);
  final cubit = TeacherCourseReviewsCubit(repo: repo, courseId: 'c1');
  addTearDown(cubit.close);
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
      home: Scaffold(
        body: BlocProvider.value(
          value: cubit..load(),
          child: const TeacherCourseReviewsViewBody(),
        ),
      ),
    ),
  );
  await tester.pumpAndSettle();
  return repo;
}

void main() {
  testWidgets('overview, trend, new tags and star filters', (tester) async {
    final repo = await _pump(
      tester,
      _InstantRepo(
        stats: _stats,
        seen: DateTime.now().subtract(const Duration(days: 3)),
        recent: [
          _review('r1', rating: 5),
          _review('r2', rating: 5, age: const Duration(days: 4)),
          _review('r3', rating: 4, age: const Duration(days: 6)),
          _review('r4', rating: 5, age: const Duration(days: 8)),
        ],
        pages: {
          CourseReviewsQuery.newest: [
            _review('fresh', text: 'Clear lessons'),
            _review('old', rating: 4, age: const Duration(days: 9)),
          ],
          CourseReviewsQuery.stars(1): [
            _review('low', rating: 1, text: 'Audio is too quiet'),
          ],
        },
      ),
    );

    expect(find.byKey(const ValueKey('course-rating-summary')), findsOneWidget);
    expect(find.byKey(const ValueKey('reviews-recent-tile')), findsOneWidget);
    expect(find.byKey(const ValueKey('reviews-trend-up')), findsOneWidget);
    expect(find.text('Above course average'), findsOneWidget);
    expect(find.text('1 new review'), findsOneWidget);
    expect(find.byKey(const ValueKey('new-review-chip')), findsOneWidget);
    expect(
      find.descendant(
        of: find.byKey(const ValueKey('teacher-review-fresh')),
        matching: find.byKey(const ValueKey('new-review-chip')),
      ),
      findsOneWidget,
    );

    final twoStars = tester.widget<ChoiceChip>(
      find.descendant(
        of: find.byKey(
          const ValueKey('reviews-filter-star-2'),
          skipOffstage: false,
        ),
        matching: find.byType(ChoiceChip, skipOffstage: false),
        skipOffstage: false,
      ),
    );
    expect(twoStars.onSelected, isNull);

    await tester.tap(find.byKey(const ValueKey('rating-distribution-row-1')));
    await tester.pumpAndSettle();

    expect(repo.queries.last, CourseReviewsQuery.stars(1));
    expect(find.byKey(const ValueKey('teacher-review-low')), findsOneWidget);
    expect(find.byKey(const ValueKey('teacher-review-fresh')), findsNothing);
    final oneStar = tester.widget<ChoiceChip>(
      find.descendant(
        of: find.byKey(
          const ValueKey('reviews-filter-star-1'),
          skipOffstage: false,
        ),
        matching: find.byType(ChoiceChip, skipOffstage: false),
        skipOffstage: false,
      ),
    );
    expect(oneStar.selected, isTrue);

    await tester.tap(find.byKey(const ValueKey('rating-distribution-row-1')));
    await tester.pumpAndSettle();

    expect(repo.queries.last, CourseReviewsQuery.newest);
    expect(find.byKey(const ValueKey('teacher-review-fresh')), findsOneWidget);
    expect(tester.takeException(), isNull);
  });

  testWidgets('a filter with no match offers to show all reviews', (
    tester,
  ) async {
    final repo = await _pump(
      tester,
      _InstantRepo(
        stats: _stats,
        pages: {
          CourseReviewsQuery.newest: [_review('a')],
        },
      ),
    );

    await tester.tap(find.byKey(const ValueKey('reviews-filter-lowest')));
    await tester.pumpAndSettle();

    expect(repo.queries.last, CourseReviewsQuery.lowestRated);
    expect(
      find.byKey(const ValueKey('teacher-reviews-filter-empty')),
      findsOneWidget,
    );

    await tester.tap(find.byKey(const ValueKey('teacher-reviews-show-all')));
    await tester.pumpAndSettle();

    expect(repo.queries.last, CourseReviewsQuery.newest);
    expect(find.byKey(const ValueKey('teacher-review-a')), findsOneWidget);
  });

  testWidgets('a course without reviews shows one calm empty state', (
    tester,
  ) async {
    await _pump(tester, _InstantRepo(pages: const {}));

    expect(find.byKey(const ValueKey('teacher-reviews-empty')), findsOneWidget);
    expect(find.byKey(const ValueKey('course-rating-summary')), findsNothing);
    expect(
      find.byKey(const ValueKey('teacher-reviews-filter-bar')),
      findsNothing,
    );
  });

  testWidgets('first visit hides the new tile and new tags', (tester) async {
    await _pump(
      tester,
      _InstantRepo(
        stats: _stats,
        pages: {
          CourseReviewsQuery.newest: [_review('a')],
        },
      ),
    );

    expect(find.byKey(const ValueKey('reviews-new-tile')), findsNothing);
    expect(find.byKey(const ValueKey('new-review-chip')), findsNothing);
    expect(find.byKey(const ValueKey('reviews-recent-tile')), findsOneWidget);
  });

  for (final locale in const [Locale('ar'), Locale('en'), Locale('fr')]) {
    for (final dark in const [false, true]) {
      testWidgets(
        'fits a 320px screen in ${locale.languageCode}, dark: $dark',
        (tester) async {
          await _pump(
            tester,
            _InstantRepo(
              stats: _stats,
              seen: DateTime.now().subtract(const Duration(days: 3)),
              recent: [
                _review('r1', rating: 2),
                _review('r2', rating: 3),
                _review('r3', rating: 2),
              ],
              pages: {
                CourseReviewsQuery.newest: [
                  _review('a', text: 'Long review text ' * 12),
                  _review('b', rating: null, text: 'No stars'),
                ],
              },
            ),
            locale: locale,
            theme: dark ? AppTheme.dark : AppTheme.light,
            size: const Size(320, 700),
          );

          expect(tester.takeException(), isNull);
          expect(
            find.byKey(const ValueKey('reviews-trend-down')),
            findsOneWidget,
          );
        },
      );
    }
  }
}
