import 'dart:async';

import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:localingo/localingo.dart';
import 'package:sintir/Core/Managers/Cubits/CourseFeedBacksCubit/course_feed_backs_cubit.dart';
import 'package:sintir/Core/Managers/Cubits/MyCourseRatingCubit/my_course_rating_cubit.dart';
import 'package:sintir/Core/Themes/app_theme.dart';
import 'package:sintir/Core/entities/BottomSheetNavigationRequirmentsEntity.dart';
import 'package:sintir/Core/entities/CourseEntities/CourseEntity.dart';
import 'package:sintir/Core/entities/CourseEntities/CourseRatingStatsEntity.dart';
import 'package:sintir/Core/entities/FetchDataResponses/CourseFeedbackSaveResult.dart';
import 'package:sintir/Core/entities/FetchDataResponses/GetCourseFeedBacksResponseEntity.dart';
import 'package:sintir/Core/errors/Failures.dart';
import 'package:sintir/Core/repos/CourseFeedBacksRepo/CourseFeedBacksRepo.dart';
import 'package:sintir/Features/CourseManagementAndInteractionFeature/domain/Entities/CoursefedbackItemEntity.dart';
import 'package:sintir/Features/CourseManagementAndInteractionFeature/presentation/views/widgets/CourseFedBack_Widgets/CourseFeedbackSkeleton.dart';
import 'package:sintir/Features/CourseManagementAndInteractionFeature/presentation/views/widgets/CourseFedBack_Widgets/Coursefedbackviewbody.dart';
import 'package:sintir/Features/CourseManagementAndInteractionFeature/presentation/views/widgets/CourseFedBack_Widgets/RateCourseBottomSheet.dart';

CoursefeedbackItemEntity _review(String uid, int? rating, String text) {
  return CoursefeedbackItemEntity(
    userImage: '',
    name: uid == 'me' ? 'Ziad Gamal' : 'Student $uid',
    uid: uid,
    fedBack: text,
    datePosted: DateTime(2026, 11, 1),
    rating: rating,
  );
}

/// In-memory backend that behaves like the Edge Functions for one student.
/// Gates hold a request until the test completes them.
class _FlowRepo implements CourseFeedBacksRepo {
  _FlowRepo({
    required this.reviews,
    this.nextPage = const [],
    this.stats = const CourseRatingStatsEntity(),
  });

  final List<CoursefeedbackItemEntity> reviews;
  final List<CoursefeedbackItemEntity> nextPage;
  CourseRatingStatsEntity stats;
  CoursefeedbackItemEntity? mine;
  Failure? saveFailure;
  Failure? deleteFailure;
  Failure? pageFailure;
  Completer<void>? statsGate;
  Completer<void>? pageGate;

  final List<bool> pageRequests = [];
  final List<int> saveCalls = [];
  int myFeedbackRequests = 0;
  int deleteCalls = 0;

  @override
  Future<Either<Failure, GetCourseFeedBacksResponseEntity>> getCourseFedBacks({
    required String courseId,
    required bool isPaginate,
  }) async {
    pageRequests.add(isPaginate);
    await pageGate?.future;
    final failure = pageFailure;
    if (failure != null) return left(failure);
    return right(
      GetCourseFeedBacksResponseEntity(
        feedBacks: List.of(isPaginate ? nextPage : reviews),
        hasMore: !isPaginate && nextPage.isNotEmpty,
        isPaginate: isPaginate,
      ),
    );
  }

  @override
  Future<Either<Failure, CourseRatingStatsEntity>> getCourseRatingStats({
    required String courseId,
  }) async {
    await statsGate?.future;
    return right(stats);
  }

  @override
  Future<Either<Failure, CoursefeedbackItemEntity?>> getMyCourseFeedback({
    required String courseId,
    required String uid,
  }) async {
    myFeedbackRequests++;
    return right(mine);
  }

  @override
  Future<Either<Failure, CourseFeedbackSaveResult>> saveMyCourseFeedback({
    required String courseId,
    required int rating,
    required String text,
    String? teacherId,
  }) async {
    saveCalls.add(rating);
    final failure = saveFailure;
    if (failure != null) return left(failure);
    final previous = mine?.rating;
    final saved = _review('me', rating, text.trim());
    final distribution = Map<int, int>.of(stats.distribution);
    if (previous != null) distribution[previous] = distribution[previous]! - 1;
    distribution[rating] = (distribution[rating] ?? 0) + 1;
    stats = CourseRatingStatsEntity(
      ratingsSum: stats.ratingsSum - (previous ?? 0) + rating,
      ratingsCount: stats.ratingsCount + (previous == null ? 1 : 0),
      feedBacksCount: stats.feedBacksCount + (mine == null ? 1 : 0),
      distribution: distribution,
    );
    final created = mine == null;
    mine = saved;
    return right(
      CourseFeedbackSaveResult(feedback: saved, stats: stats, created: created),
    );
  }

  @override
  Future<Either<Failure, CourseRatingStatsEntity?>> deleteMyCourseFeedback({
    required String courseId,
    String? teacherId,
  }) async {
    deleteCalls++;
    final failure = deleteFailure;
    if (failure != null) return left(failure);
    final removed = mine?.rating;
    final distribution = Map<int, int>.of(stats.distribution);
    if (removed != null) distribution[removed] = distribution[removed]! - 1;
    stats = CourseRatingStatsEntity(
      ratingsSum: stats.ratingsSum - (removed ?? 0),
      ratingsCount: stats.ratingsCount - (removed == null ? 0 : 1),
      feedBacksCount: stats.feedBacksCount - 1,
      distribution: distribution,
    );
    mine = null;
    return right(stats);
  }
}

/// Pumps the reviews screen. With [settle] (the default) the first load has
/// finished and the content is on screen when this returns.
Future<void> _pumpScreen(
  WidgetTester tester,
  _FlowRepo repo, {
  bool isSubscribed = true,
  Locale locale = const Locale('en'),
  ThemeData? theme,
  Size size = const Size(411, 860),
  double textScale = 1,
  bool settle = true,
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
      builder: (context, child) => MediaQuery(
        data: MediaQuery.of(
          context,
        ).copyWith(textScaler: TextScaler.linear(textScale)),
        child: child!,
      ),
      home: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => CourseFeedBacksCubit(courseFeedBacksRepo: repo),
          ),
          BlocProvider(
            create: (context) => MyCourseRatingCubit(
              courseFeedBacksRepo: repo,
              courseId: 'course-1',
              teacherId: 'teacher-1',
            ),
          ),
        ],
        child: Scaffold(
          body: Coursefedbackviewbody(
            requirmentsEntity: DisplayCourseBottomsheetNavigationRequirmentsEntity(
              course: CourseEntity.empty()..id = 'course-1',
              isSubscribed: isSubscribed,
            ),
            currentUid: 'me',
          ),
        ),
      ),
    ),
  );
  if (settle) await tester.pumpAndSettle();
}

Future<void> _finish(WidgetTester tester) async {
  await tester.pumpWidget(const SizedBox.shrink());
  tester.view.resetPhysicalSize();
  tester.view.resetDevicePixelRatio();
}

/// Lets the 3-second snackbar leave so it does not cover the screen.
Future<void> _waitForSnackBar(WidgetTester tester) async {
  await tester.pump(const Duration(seconds: 4));
  await tester.pumpAndSettle();
}

/// Pulls the list down and lets the refresh run to its end.
Future<void> _pullToRefresh(WidgetTester tester) async {
  await tester.fling(
    find.byType(CustomScrollView),
    const Offset(0, 300),
    1000,
  );
  await tester.pump();
  expect(find.byType(CourseFeedbackSkeleton), findsNothing);
  await tester.pump(const Duration(seconds: 1)); // the scroll animation
  await tester.pump(const Duration(seconds: 1)); // the indicator settles
  await tester.pump(const Duration(seconds: 1)); // the indicator hides
}

_FlowRepo _twoReviews() => _FlowRepo(
  reviews: [_review('s1', 5, 'Clear lessons'), _review('s2', 4, '')],
  stats: const CourseRatingStatsEntity(
    ratingsSum: 9,
    ratingsCount: 2,
    feedBacksCount: 2,
    distribution: {5: 1, 4: 1},
  ),
);

void main() {
  testWidgets('the first load is one skeleton, then everything at once', (
    tester,
  ) async {
    final repo = _twoReviews()
      ..statsGate = Completer<void>()
      ..pageGate = Completer<void>();
    await _pumpScreen(tester, repo, settle: false);
    await tester.pump();

    expect(find.byType(CourseFeedbackSkeleton), findsOneWidget);
    expect(find.byType(CircularProgressIndicator), findsNothing);
    expect(find.byType(RefreshIndicator), findsNothing);

    // The summary alone does not end the skeleton.
    repo.statsGate!.complete();
    await tester.pump();
    await tester.pump();
    expect(find.byType(CourseFeedbackSkeleton), findsOneWidget);
    expect(find.text('Clear lessons'), findsNothing);

    repo.pageGate!.complete();
    await tester.pumpAndSettle();
    expect(find.byType(CourseFeedbackSkeleton), findsNothing);
    expect(find.text('Clear lessons'), findsOneWidget);
    expect(find.text('4.5'), findsOneWidget);
    expect(find.byKey(const ValueKey('rate-course-card')), findsOneWidget);
    expect(find.byType(CircularProgressIndicator), findsNothing);
    await _finish(tester);
  });

  testWidgets(
    'a student rates from the stars on screen, then edits and deletes',
    (tester) async {
      final repo = _twoReviews();
      await _pumpScreen(tester, repo);

      expect(find.text('Rate this course'), findsOneWidget);
      expect(find.text('Your rating helps other students choose'), findsOneWidget);
      expect(find.text('Tap a star to start'), findsOneWidget);
      expect(find.byKey(const ValueKey('course-rating-summary')), findsOneWidget);
      expect(find.text('What students say'), findsOneWidget);
      expect(find.text('Clear lessons'), findsOneWidget);
      expect(repo.myFeedbackRequests, 1);

      // The tapped star is already chosen in the sheet.
      await tester.tap(find.byKey(const ValueKey('inline-star-rating-4')));
      await tester.pumpAndSettle();
      expect(find.byType(RateCourseBottomSheet), findsOneWidget);
      expect(
        tester.widget<Text>(find.byKey(const ValueKey('rating-label'))).data,
        'Very good',
      );
      await tester.enterText(find.byType(TextField), '  Very clear  ');
      await tester.tap(find.byKey(const ValueKey('save-rating-button')));
      await tester.pumpAndSettle();

      expect(repo.saveCalls, [4]);
      expect(find.byType(RateCourseBottomSheet), findsNothing);
      expect(find.textContaining('Your rating was saved'), findsOneWidget);
      expect(find.byKey(const ValueKey('my-course-review')), findsOneWidget);
      expect(find.text('Very good'), findsOneWidget);
      // On its own card only, not a second time in the list.
      expect(find.text('Very clear'), findsOneWidget);
      expect(find.byKey(const ValueKey('course-feedback-me')), findsNothing);
      expect(find.byKey(const ValueKey('rate-course-card')), findsNothing);
      expect(find.text('4.3'), findsOneWidget); // (5 + 4 + 4) / 3
      expect(repo.pageRequests, [false]); // updated without reloading
      await _waitForSnackBar(tester);

      // Edit from the menu: the sheet opens with the saved review.
      await tester.tap(find.byKey(const ValueKey('edit-my-review')));
      await tester.pumpAndSettle();
      expect(
        find.descendant(
          of: find.byType(RateCourseBottomSheet),
          matching: find.text('Very clear'),
        ),
        findsOneWidget,
      );
      await tester.tap(find.byKey(const ValueKey('star-rating-input-2')));
      await tester.tap(find.byKey(const ValueKey('save-rating-button')));
      await tester.pumpAndSettle();
      expect(repo.saveCalls, [4, 2]);
      expect(find.text('3.7'), findsOneWidget); // (5 + 4 + 2) / 3
      await _waitForSnackBar(tester);

      // Delete from the menu, with confirmation.
      await tester.tap(find.byKey(const ValueKey('delete-my-review')));
      await tester.pumpAndSettle();
      await tester.tap(find.byKey(const ValueKey('confirm-delete-review')));
      await tester.pumpAndSettle();

      expect(repo.deleteCalls, 1);
      expect(find.textContaining('Your review was deleted'), findsOneWidget);
      expect(find.byKey(const ValueKey('my-course-review')), findsNothing);
      expect(find.byKey(const ValueKey('rate-course-card')), findsOneWidget);
      expect(find.text('4.5'), findsOneWidget);
      expect(tester.takeException(), isNull);
      await _finish(tester);
    },
  );

  testWidgets('an old review without stars needs stars before saving', (
    tester,
  ) async {
    final repo = _twoReviews()..mine = _review('me', null, 'Old text review');
    repo.reviews.insert(0, repo.mine!);
    await _pumpScreen(tester, repo);
    expect(find.byKey(const ValueKey('my-course-review')), findsOneWidget);
    expect(find.text('Old text review'), findsOneWidget);

    await tester.tap(find.byKey(const ValueKey('edit-my-review')));
    await tester.pumpAndSettle();
    await tester.tap(find.byKey(const ValueKey('save-rating-button')));
    await tester.pumpAndSettle();
    expect(find.text('Choose a rating from 1 to 5 stars'), findsOneWidget);
    expect(repo.saveCalls, isEmpty);
    await _finish(tester);
  });

  testWidgets('a save error stays inside the open sheet, not behind it', (
    tester,
  ) async {
    const message = 'Wait a few seconds before saving again';
    final repo = _twoReviews()..saveFailure = ServerFailure(message: message);
    await _pumpScreen(tester, repo);

    await tester.tap(find.byKey(const ValueKey('inline-star-rating-5')));
    await tester.pumpAndSettle();
    await tester.tap(find.byKey(const ValueKey('save-rating-button')));
    await tester.pumpAndSettle();

    expect(find.byType(RateCourseBottomSheet), findsOneWidget);
    expect(find.text(message), findsOneWidget); // no snackbar copy
    expect(
      find.descendant(
        of: find.byKey(const ValueKey('rating-server-error')),
        matching: find.text(message),
      ),
      findsOneWidget,
    );

    // Choosing again clears the old error.
    await tester.tap(find.byKey(const ValueKey('star-rating-input-4')));
    await tester.pumpAndSettle();
    expect(find.byKey(const ValueKey('rating-server-error')), findsNothing);
    await _finish(tester);
  });

  testWidgets('a failed delete keeps the review and says why', (tester) async {
    final repo = _twoReviews()
      ..mine = _review('me', 3, 'Good')
      ..deleteFailure = ServerFailure(message: 'Connection lost');
    await _pumpScreen(tester, repo);

    await tester.tap(find.byKey(const ValueKey('delete-my-review')));
    await tester.pumpAndSettle();
    await tester.tap(find.byKey(const ValueKey('confirm-delete-review')));
    await tester.pumpAndSettle();

    expect(repo.deleteCalls, 1);
    expect(find.textContaining('Connection lost'), findsOneWidget);
    expect(find.byKey(const ValueKey('my-course-review')), findsOneWidget);
    expect(find.text('Good'), findsOneWidget);
    await _finish(tester);
  });

  testWidgets('cancelling the delete dialog keeps the review', (tester) async {
    final repo = _twoReviews()..mine = _review('me', 3, 'Good');
    await _pumpScreen(tester, repo);

    await tester.tap(find.byKey(const ValueKey('delete-my-review')));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Cancel'));
    await tester.pumpAndSettle();

    expect(repo.deleteCalls, 0);
    expect(find.byKey(const ValueKey('my-course-review')), findsOneWidget);
    await _finish(tester);
  });

  testWidgets('visitors who are not subscribed can read but not rate', (
    tester,
  ) async {
    final repo = _twoReviews();
    await _pumpScreen(tester, repo, isSubscribed: false);
    expect(find.text('Clear lessons'), findsOneWidget);
    expect(find.text('4.5'), findsOneWidget);
    expect(find.byKey(const ValueKey('rate-course-card')), findsNothing);
    expect(find.byKey(const ValueKey('edit-my-review')), findsNothing);
    expect(repo.myFeedbackRequests, 0);
    await _finish(tester);
  });

  testWidgets('my review shows once, on its own card above the list', (
    tester,
  ) async {
    final repo = _twoReviews()..mine = _review('me', 3, 'Good');
    repo.reviews.insert(0, repo.mine!);
    await _pumpScreen(tester, repo);

    expect(find.byKey(const ValueKey('my-course-review')), findsOneWidget);
    expect(find.byKey(const ValueKey('course-feedback-me')), findsNothing);
    expect(find.text('Good'), findsOneWidget);
    expect(find.text('Clear lessons'), findsOneWidget);
    expect(
      tester.getTopLeft(find.byKey(const ValueKey('my-course-review'))).dy,
      lessThan(tester.getTopLeft(find.text('What students say')).dy),
    );
    await _finish(tester);
  });

  testWidgets('with only my review, the list says no one else wrote yet', (
    tester,
  ) async {
    final repo = _FlowRepo(
      reviews: [],
      stats: const CourseRatingStatsEntity(
        ratingsSum: 4,
        ratingsCount: 1,
        feedBacksCount: 1,
        distribution: {4: 1},
      ),
    )..mine = _review('me', 4, 'Nice');
    repo.reviews.add(repo.mine!);
    await _pumpScreen(tester, repo);

    expect(find.text('No reviews from other students yet'), findsOneWidget);
    expect(find.text('No reviews yet'), findsNothing);
    expect(find.byKey(const ValueKey('my-course-review')), findsOneWidget);
    await _finish(tester);
  });

  testWidgets('a new course invites the first rating, without empty lists', (
    tester,
  ) async {
    await _pumpScreen(tester, _FlowRepo(reviews: []));
    expect(find.byKey(const ValueKey('course-rating-summary')), findsNothing);
    expect(find.byKey(const ValueKey('rate-course-card')), findsOneWidget);
    expect(find.text('No reviews yet'), findsOneWidget);
    expect(
      find.text('Be the first to rate this course and help other students.'),
      findsOneWidget,
    );
    expect(find.text('What students say'), findsNothing);
    expect(find.byKey(const ValueKey('reviews-empty')), findsNothing);
    await _finish(tester);
  });

  testWidgets('a visitor sees a short note when nobody rated yet', (
    tester,
  ) async {
    await _pumpScreen(tester, _FlowRepo(reviews: []), isSubscribed: false);
    expect(find.byKey(const ValueKey('rate-course-card')), findsNothing);
    expect(find.text('What students say'), findsOneWidget);
    expect(find.text('No reviews yet'), findsOneWidget);
    expect(
      find.text("Ratings from the course's students will appear here."),
      findsOneWidget,
    );
    await _finish(tester);
  });

  testWidgets('the summary shows a bar per star even with few ratings', (
    tester,
  ) async {
    await _pumpScreen(tester, _twoReviews());
    expect(find.byType(LinearProgressIndicator), findsNWidgets(5));
    expect(find.text('4.5'), findsOneWidget);
    expect(find.text('2 ratings'), findsOneWidget);
    await _finish(tester);
  });

  testWidgets('a short first page loads the next one by itself', (
    tester,
  ) async {
    final repo = _FlowRepo(
      reviews: [_review('s1', 5, 'First page')],
      nextPage: [_review('s2', 4, 'Second page')],
      stats: const CourseRatingStatsEntity(ratingsSum: 9, ratingsCount: 2),
    );
    await _pumpScreen(tester, repo);
    expect(repo.pageRequests, [false, true]);
    expect(find.text('Second page'), findsOneWidget);
    await _finish(tester);
  });

  testWidgets('pull to refresh keeps the reviews on screen, even if it fails', (
    tester,
  ) async {
    final repo = _twoReviews();
    await _pumpScreen(tester, repo);

    repo.pageFailure = ServerFailure(message: 'No connection');
    await _pullToRefresh(tester);
    expect(repo.pageRequests, [false, false]);
    expect(find.text('Clear lessons'), findsOneWidget);
    expect(find.textContaining('No connection'), findsOneWidget);
    expect(find.byType(CourseFeedbackSkeleton), findsNothing);
    await _waitForSnackBar(tester);

    repo.pageFailure = null;
    repo.reviews.insert(0, _review('s3', 3, 'Fresh review'));
    await _pullToRefresh(tester);
    await tester.pumpAndSettle();
    expect(find.text('Fresh review'), findsOneWidget);
    expect(find.text('Clear lessons'), findsOneWidget);
    await _finish(tester);
  });

  testWidgets('retrying a failed first page shows placeholder cards', (
    tester,
  ) async {
    final repo = _twoReviews()
      ..pageFailure = ServerFailure(message: 'No connection');
    await _pumpScreen(tester, repo);
    expect(find.text('No connection'), findsOneWidget);
    // No automatic "next page" over an error.
    expect(repo.pageRequests, [false]);

    repo
      ..pageFailure = null
      ..pageGate = Completer<void>();
    await tester.tap(find.text('Retry'));
    await tester.pump();
    expect(find.byType(ReviewsLoadingPlaceholder), findsOneWidget);
    expect(find.byType(CircularProgressIndicator), findsNothing);

    repo.pageGate!.complete();
    await tester.pumpAndSettle();
    expect(find.byType(ReviewsLoadingPlaceholder), findsNothing);
    expect(find.text('Clear lessons'), findsOneWidget);
    await _finish(tester);
  });

  testWidgets('Arabic screen, menu and sheet render without layout errors', (
    tester,
  ) async {
    final repo = _twoReviews()..mine = _review('me', 3, 'كورس مفيد');
    await _pumpScreen(tester, repo, locale: const Locale('ar'));
    expect(find.text('آراء الطلاب'), findsOneWidget);
    expect(find.text('تقييمك'), findsOneWidget);
    expect(find.text('جيد'), findsOneWidget);
    expect(find.text('تعديل'), findsOneWidget);
    expect(find.text('حذف'), findsOneWidget);

    await tester.tap(find.byKey(const ValueKey('edit-my-review')));
    await tester.pumpAndSettle();
    expect(find.byType(RateCourseBottomSheet), findsOneWidget);
    expect(find.text('عدّل تقييمك'), findsOneWidget);
    expect(tester.takeException(), isNull);
    await _finish(tester);
  });

  testWidgets('the screen fits a narrow phone with large text', (
    tester,
  ) async {
    for (final locale in const [Locale('ar'), Locale('en'), Locale('fr')]) {
      for (final theme in [AppTheme.light, AppTheme.dark]) {
        for (final withMine in [false, true]) {
          final repo = _twoReviews();
          if (withMine) repo.mine = _review('me', 4, 'A review of my own');
          await _pumpScreen(
            tester,
            repo,
            locale: locale,
            theme: theme,
            size: const Size(320, 640),
            textScale: 1.5,
          );
          expect(
            tester.takeException(),
            isNull,
            reason: '${locale.languageCode} ${theme.brightness} $withMine',
          );
        }
      }
    }
    await _finish(tester);
  });
}
