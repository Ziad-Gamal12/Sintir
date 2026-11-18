import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:localingo/localingo.dart';
import 'package:sintir/Core/Themes/app_theme.dart';
import 'package:sintir/Core/entities/CourseEntities/CourseRatingStatsEntity.dart';
import 'package:sintir/Core/widgets/Rating/StarRatingDisplay.dart';
import 'package:sintir/Core/widgets/Rating/StarRatingInput.dart';
import 'package:sintir/Features/CourseManagementAndInteractionFeature/domain/Entities/CoursefedbackItemEntity.dart';
import 'package:sintir/Features/CourseManagementAndInteractionFeature/presentation/views/widgets/CourseFedBack_Widgets/CourseFedBacksListView_item.dart';
import 'package:sintir/Features/CourseManagementAndInteractionFeature/presentation/views/widgets/CourseFedBack_Widgets/CourseRatingSummaryCard.dart';
import 'package:sintir/Features/CourseManagementAndInteractionFeature/presentation/views/widgets/CourseFedBack_Widgets/ExpandableReviewText.dart';
import 'package:sintir/Features/CourseManagementAndInteractionFeature/presentation/views/widgets/CourseFedBack_Widgets/MyCourseRatingSection.dart';

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

CoursefeedbackItemEntity _review({
  String uid = 's1',
  String name = 'Mona Ali',
  String text = 'Very clear',
  int? rating = 4,
  Duration age = const Duration(hours: 2),
  Duration? editedAfter,
}) {
  final posted = DateTime.now().subtract(age);
  return CoursefeedbackItemEntity(
    userImage: '',
    name: name,
    uid: uid,
    fedBack: text,
    datePosted: posted,
    rating: rating,
    updatedAt: editedAfter == null ? posted : posted.add(editedAfter),
  );
}

void main() {
  testWidgets('4.6 stars: four full and 60% of the fifth, from the reading side', (
    tester,
  ) async {
    for (final locale in const [Locale('en'), Locale('ar')]) {
      await _pump(
        tester,
        const Center(child: StarRatingDisplay(rating: 4.6, size: 20)),
        locale: locale,
      );
      final display = find.byType(StarRatingDisplay);
      final fills = tester
          .widgetList<Align>(
            find.descendant(of: display, matching: find.byType(Align)),
          )
          .toList();
      expect(fills, hasLength(5));
      for (final fill in fills.take(4)) {
        expect(fill.widthFactor, 1);
      }
      expect(fills.last.widthFactor, closeTo(0.6, 1e-9));

      final stars = find.descendant(of: display, matching: find.byType(Stack));
      final clips = find.descendant(of: display, matching: find.byType(ClipRect));
      final fifthStar = tester.getRect(stars.at(4));
      final fifthFill = tester.getRect(clips.at(4));
      expect(fifthFill.width, closeTo(12, 0.01));
      if (locale.languageCode == 'ar') {
        // RTL: stars start on the right and the partial fill hugs the right.
        expect(fifthFill.right, closeTo(fifthStar.right, 0.01));
        expect(tester.getRect(stars.at(0)).left, greaterThan(fifthStar.left));
      } else {
        expect(fifthFill.left, closeTo(fifthStar.left, 0.01));
        expect(tester.getRect(stars.at(0)).left, lessThan(fifthStar.left));
      }
    }
    _resetView(tester);
  });

  testWidgets('star input: tap picks a star, 48px targets, labelled stars', (
    tester,
  ) async {
    final semantics = tester.ensureSemantics();
    var value = 0;
    await _pump(
      tester,
      StatefulBuilder(
        builder: (context, setState) => Center(
          child: StarRatingInput(
            value: value,
            onChanged: (star) => setState(() => value = star),
          ),
        ),
      ),
    );

    await tester.tap(find.byKey(const ValueKey('star-rating-input-4')));
    await tester.pumpAndSettle();
    expect(value, 4);

    final target = tester.getSize(
      find.byKey(const ValueKey('star-rating-input-1')),
    );
    expect(target.width, greaterThanOrEqualTo(48));
    expect(target.height, greaterThanOrEqualTo(48));

    expect(
      tester.getSemantics(find.byKey(const ValueKey('star-rating-input-4'))),
      containsSemantics(
        label: 'Rate 4 out of 5',
        isButton: true,
        isSelected: true,
        hasTapAction: true,
      ),
    );
    expect(
      tester.getSemantics(find.byKey(const ValueKey('star-rating-input-2'))),
      containsSemantics(label: 'Rate 2 out of 5', isSelected: false),
    );
    semantics.dispose();
    _resetView(tester);
  });

  testWidgets('two star inputs on screen keep their own keys', (tester) async {
    await _pump(
      tester,
      Column(
        children: [
          StarRatingInput(value: 0, onChanged: (_) {}),
          StarRatingInput(
            value: 0,
            keyPrefix: 'inline-star-rating',
            onChanged: (_) {},
          ),
        ],
      ),
    );
    expect(find.byKey(const ValueKey('star-rating-input-3')), findsOneWidget);
    expect(find.byKey(const ValueKey('inline-star-rating-3')), findsOneWidget);
    _resetView(tester);
  });

  testWidgets('disabled star input ignores taps', (tester) async {
    var value = 2;
    await _pump(
      tester,
      Center(
        child: StarRatingInput(
          value: value,
          enabled: false,
          onChanged: (star) => value = star,
        ),
      ),
    );
    await tester.tap(find.byKey(const ValueKey('star-rating-input-5')));
    await tester.pumpAndSettle();
    expect(value, 2);
    _resetView(tester);
  });

  testWidgets('summary card fits every language, theme and width', (
    tester,
  ) async {
    const stats = CourseRatingStatsEntity(
      ratingsSum: 553,
      ratingsCount: 120,
      distribution: {5: 80, 4: 25, 3: 8, 2: 4, 1: 3},
    );
    for (final locale in const [Locale('ar'), Locale('en'), Locale('fr')]) {
      for (final theme in [AppTheme.light, AppTheme.dark]) {
        for (final width in [320.0, 411.0, 600.0]) {
          for (final scale in [1.0, 1.5]) {
            await _pump(
              tester,
              const Padding(
                padding: EdgeInsets.all(16),
                child: CourseRatingSummaryCard(stats: stats),
              ),
              locale: locale,
              theme: theme,
              size: Size(width, 900),
              textScale: scale,
            );
            final reason =
                '${locale.languageCode} ${theme.brightness} $width x$scale';
            expect(tester.takeException(), isNull, reason: reason);
            expect(find.text('4.6'), findsOneWidget, reason: reason);
          }
        }
      }
    }
    expect(find.text('120 notes'), findsOneWidget); // last pump was French
    _resetView(tester);
  });

  testWidgets('summary card counts in English and Arabic plural forms', (
    tester,
  ) async {
    await _pump(
      tester,
      const CourseRatingSummaryCard(
        stats: CourseRatingStatsEntity(ratingsSum: 553, ratingsCount: 120),
      ),
    );
    expect(find.text('120 ratings'), findsOneWidget);

    await _pump(
      tester,
      const CourseRatingSummaryCard(stats: CourseRatingStatsEntity()),
    );
    expect(find.text('0.0'), findsOneWidget);
    expect(find.text('No ratings yet'), findsOneWidget);

    const arabicCounts = {
      1: 'تقييم واحد',
      2: 'تقييمان',
      3: '3 تقييمات',
      11: '11 تقييمًا',
      100: '100 تقييم',
    };
    for (final entry in arabicCounts.entries) {
      final count = entry.key;
      final text = entry.value;
      await _pump(
        tester,
        CourseRatingSummaryCard(
          stats: CourseRatingStatsEntity(
            ratingsSum: count * 4,
            ratingsCount: count,
          ),
        ),
        locale: const Locale('ar'),
      );
      expect(find.text(text), findsOneWidget, reason: '$count');
    }
    _resetView(tester);
  });

  testWidgets('the summary shows a bar per star from the first rating', (
    tester,
  ) async {
    await _pump(
      tester,
      const CourseRatingSummaryCard(
        stats: CourseRatingStatsEntity(
          ratingsSum: 4,
          ratingsCount: 1,
          distribution: {4: 1},
        ),
      ),
      locale: const Locale('ar'),
    );
    expect(find.text('4.0'), findsOneWidget);
    expect(find.text('تقييم واحد'), findsOneWidget);
    expect(find.byType(LinearProgressIndicator), findsNWidgets(5));
    final bars = tester
        .widgetList<LinearProgressIndicator>(
          find.byType(LinearProgressIndicator),
        )
        .map((bar) => bar.value)
        .toList();
    expect(bars, [0, 1, 0, 0, 0]); // 5 → 1
    _resetView(tester);
  });

  testWidgets('my review card: stars, their word, edit and delete', (
    tester,
  ) async {
    await _pump(
      tester,
      Padding(
        padding: const EdgeInsets.all(16),
        child: MyReviewCard(
          review: _review(
            uid: 'me',
            editedAfter: const Duration(minutes: 30),
          ),
        ),
      ),
    );
    expect(find.text('Your review'), findsOneWidget);
    expect(find.text('Very good'), findsOneWidget);
    expect(find.text('Very clear'), findsOneWidget);
    expect(
      tester.widget<Text>(find.byKey(const ValueKey('my-review-meta'))).data,
      '2 hours ago · Edited',
    );
    expect(find.byKey(const ValueKey('edit-my-review')), findsOneWidget);
    expect(find.byKey(const ValueKey('delete-my-review')), findsOneWidget);
    final edit = tester.getSize(find.byKey(const ValueKey('edit-my-review')));
    expect(edit.height, greaterThanOrEqualTo(44));

    await _pump(
      tester,
      Padding(
        padding: const EdgeInsets.all(16),
        child: MyReviewCard(review: _review(uid: 'me'), busy: true),
      ),
    );
    expect(
      tester
          .widget<TextButton>(find.byKey(const ValueKey('edit-my-review')))
          .onPressed,
      isNull,
    );
    _resetView(tester);
  });

  testWidgets('the rate card and my review fit every language and width', (
    tester,
  ) async {
    for (final locale in const [Locale('ar'), Locale('en'), Locale('fr')]) {
      for (final theme in [AppTheme.light, AppTheme.dark]) {
        for (final width in [320.0, 600.0]) {
          for (final scale in [1.0, 1.5]) {
            await _pump(
              tester,
              ListView(
                padding: const EdgeInsets.all(16),
                children: [
                  RateCourseCard(
                    title: 'Rate this course',
                    subtitle: 'Your rating helps other students choose',
                    onRate: (_) {},
                  ),
                  const SizedBox(height: 16),
                  MyReviewCard(review: _review(uid: 'me', text: 'word ' * 80)),
                ],
              ),
              locale: locale,
              theme: theme,
              size: Size(width, 900),
              textScale: scale,
            );
            expect(
              tester.takeException(),
              isNull,
              reason:
                  '${locale.languageCode} ${theme.brightness} $width x$scale',
            );
          }
        }
      }
    }
    _resetView(tester);
  });

  testWidgets('review: initials avatar, stars and posted time, edited mark', (
    tester,
  ) async {
    await _pump(
      tester,
      ListView(
        padding: const EdgeInsets.all(16),
        children: [
          CoursefedbackslistviewItem(
            item: _review(
              uid: 'me',
              name: 'Ziad Gamal',
              editedAfter: const Duration(hours: 1),
            ),
            isMine: true,
          ),
          const SizedBox(height: 12),
          CoursefedbackslistviewItem(
            item: _review(
              uid: 'old',
              name: 'Old student',
              text: 'text only',
              rating: null,
              age: const Duration(days: 3),
            ),
          ),
        ],
      ),
    );
    expect(find.text('Ziad Gamal'), findsOneWidget);
    expect(find.byKey(const ValueKey('own-review-chip')), findsOneWidget);
    expect(find.text('Your review'), findsOneWidget);
    expect(
      tester.widget<Text>(find.byKey(const ValueKey('review-meta-me'))).data,
      '2 hours ago · Edited',
    );

    // Old text-only review: no stars, not marked as edited.
    expect(find.text('Old student'), findsOneWidget);
    expect(find.text('text only'), findsOneWidget);
    expect(
      tester.widget<Text>(find.byKey(const ValueKey('review-meta-old'))).data,
      '3 days ago',
    );
    expect(find.byType(StarRatingDisplay), findsOneWidget);
    // No photo: the first letter of the name instead of an icon.
    expect(find.text('Z'), findsOneWidget);
    expect(find.text('O'), findsOneWidget);
    expect(find.byIcon(Icons.person), findsNothing);
    expect(tester.takeException(), isNull);
    _resetView(tester);
  });

  testWidgets('a long name and the own chip fit every language and width', (
    tester,
  ) async {
    final item = _review(
      uid: 'me',
      name: 'A very long student name that keeps going and going',
      text: 'word ' * 120,
    );
    for (final locale in const [Locale('ar'), Locale('en'), Locale('fr')]) {
      for (final theme in [AppTheme.light, AppTheme.dark]) {
        for (final width in [320.0, 600.0]) {
          for (final scale in [1.0, 1.5]) {
            await _pump(
              tester,
              ListView(
                padding: const EdgeInsets.all(16),
                children: [
                  CoursefedbackslistviewItem(item: item, isMine: true),
                ],
              ),
              locale: locale,
              theme: theme,
              size: Size(width, 900),
              textScale: scale,
            );
            expect(
              tester.takeException(),
              isNull,
              reason:
                  '${locale.languageCode} ${theme.brightness} $width x$scale',
            );
          }
        }
      }
    }
    _resetView(tester);
  });

  testWidgets('long review text folds after three lines and unfolds on tap', (
    tester,
  ) async {
    await _pump(
      tester,
      SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: ExpandableReviewText(text: 'word ' * 200),
      ),
      size: const Size(320, 900),
    );
    Text reviewText() => tester.widget<Text>(
      find.descendant(
        of: find.byType(ExpandableReviewText),
        matching: find.byWidgetPredicate(
          (widget) => widget is Text && widget.data!.startsWith('word'),
        ),
      ),
    );
    expect(reviewText().maxLines, 3);
    expect(find.text('Show More'), findsOneWidget);

    await tester.tap(find.byKey(const ValueKey('review-text-toggle')));
    await tester.pumpAndSettle();
    expect(reviewText().maxLines, isNull);
    expect(find.text('Show Less'), findsOneWidget);

    await tester.tap(find.byKey(const ValueKey('review-text-toggle')));
    await tester.pumpAndSettle();
    expect(reviewText().maxLines, 3);

    // A short review has nothing to unfold.
    await _pump(
      tester,
      const ExpandableReviewText(text: 'Short and sweet'),
      size: const Size(320, 900),
    );
    expect(find.byKey(const ValueKey('review-text-toggle')), findsNothing);
    expect(find.text('Short and sweet'), findsOneWidget);
    _resetView(tester);
  });
}
