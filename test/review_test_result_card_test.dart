import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:localingo/localingo.dart';
import 'package:sintir/Core/Themes/app_theme.dart';
import 'package:sintir/Core/entities/CourseEntities/CourseTestItemEntities/CourseTestQuestionEntity.dart';
import 'package:sintir/Core/entities/CourseEntities/CourseTestItemEntities/CourseTestQuestionSolutionEntity.dart';
import 'package:sintir/Core/entities/CourseEntities/CourseTestItemEntities/ExamResultSolvedQuestionEntity.dart';
import 'package:sintir/Core/widgets/CustomCachedNetworkImage.dart';
import 'package:sintir/Features/CourseManagementAndInteractionFeature/presentation/views/widgets/ReviewTestResultWidgets/CustomSolvedQuestionListItem.dart';
import 'package:sintir/Features/CourseManagementAndInteractionFeature/presentation/views/widgets/ReviewTestResultWidgets/SolutionImagePanel.dart';

import 'helpers/widget_test_helpers.dart';

const _phone = Size(360, 780);
const _tablet = Size(800, 1280);

const _longTitle =
    'A train leaves the station at 08:15 travelling at 72 km/h, and a second '
    'train leaves forty minutes later at 96 km/h. When does the second train '
    'catch up with the first one?';
const _longRight =
    'At 10:55, after the second train has covered exactly 192 kilometres';
const _longWrong =
    'At 09:35, because the speed difference of 24 km/h closes the gap fast';

ExamResultSolvedQuestionEntity _question({
  bool isCorrect = false,
  String? selected = _longWrong,
  String? imageUrl = 'https://example.com/question.png',
  String? solutionImageUrl = 'https://example.com/solution.png',
}) {
  return ExamResultSolvedQuestionEntity(
    isCorrect: isCorrect,
    question: CourseTestQuestionEntity(
      questionId: 'q1',
      questionTitle: _longTitle,
      isOpened: true,
      imageUrl: imageUrl,
      solutionImageUrl: solutionImageUrl,
      selectedSolution: selected,
      solutions: [
        CourseTestQuestionSolutionEntity(answer: _longRight, isCorrect: true),
        CourseTestQuestionSolutionEntity(answer: _longWrong, isCorrect: false),
      ],
    ),
  );
}

Future<void> _pumpCard(
  WidgetTester tester,
  ExamResultSolvedQuestionEntity question, {
  Size size = _phone,
  Locale locale = const Locale('en'),
}) async {
  tester.view.physicalSize = size;
  tester.view.devicePixelRatio = 1;
  addTearDown(tester.view.reset);

  await tester.pumpWidget(
    MaterialApp(
      // LocaleKeys' `.tr()` reads its context from this key.
      navigatorKey: Localingo.navigatorKey,
      locale: locale,
      supportedLocales: const [Locale('ar'), Locale('en'), Locale('fr')],
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      theme: AppTheme.light,
      home: Scaffold(
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: CustomSolvedQuestionListItem(
            questionEntity: question,
            index: 9,
            length: 10,
          ),
        ),
      ),
    ),
  );
  // Image placeholders shimmer forever in tests, so don't wait to settle.
  await pumpLocalized(tester, settle: false);
}

void main() {
  setUpAll(preloadL10nAssets);

  testWidgets('phone: long content wraps and the image stacks above answers', (
    tester,
  ) async {
    await _pumpCard(tester, _question());

    expect(tester.takeException(), isNull);
    expect(find.text(_longTitle), findsOneWidget);
    expect(find.text(_longRight), findsOneWidget);
    expect(find.text(_longWrong), findsOneWidget);

    final image = tester.getRect(find.byType(CustomCachedNetworkImage).first);
    final rightAnswer = tester.getRect(find.text(_longRight));
    expect(image.bottom, lessThan(rightAnswer.top));
    // Answers wrap onto more than one line instead of overflowing.
    expect(rightAnswer.height, greaterThan(30));
  });

  testWidgets('tablet: the question image sits beside the answers', (
    tester,
  ) async {
    await _pumpCard(tester, _question(), size: _tablet);

    expect(tester.takeException(), isNull);
    final image = tester.getRect(find.byType(CustomCachedNetworkImage).first);
    final rightAnswer = tester.getRect(find.text(_longRight));
    expect(image.left, greaterThan(rightAnswer.right));
    expect(image.top, lessThan(rightAnswer.bottom));
  });

  testWidgets('solution toggle shows the explanation image inline', (
    tester,
  ) async {
    await _pumpCard(tester, _question());

    expect(find.byType(SolutionImagePanel), findsNothing);
    expect(find.text('Show Solution'), findsOneWidget);

    await tester.tap(find.text('Show Solution'));
    await pumpFrames(tester);

    expect(find.byType(SolutionImagePanel), findsOneWidget);
    final panel = tester.widget<SolutionImagePanel>(
      find.byType(SolutionImagePanel),
    );
    expect(panel.imageUrl, 'https://example.com/solution.png');
    expect(find.text('Hide Solution'), findsOneWidget);
    // The answers stay visible next to the solution.
    expect(find.text(_longRight).hitTestable(), findsOneWidget);

    await tester.tap(find.text('Hide Solution'));
    await pumpFrames(tester);
    expect(find.byType(SolutionImagePanel), findsNothing);
  });

  testWidgets('no explanation image means no solution button', (tester) async {
    await _pumpCard(
      tester,
      _question(solutionImageUrl: null, imageUrl: null, isCorrect: true),
    );

    expect(tester.takeException(), isNull);
    expect(find.text('Show Solution'), findsNothing);
    expect(find.byType(CustomCachedNetworkImage), findsNothing);
  });

  testWidgets('an unanswered question says so', (tester) async {
    await _pumpCard(tester, _question(selected: ''));

    expect(tester.takeException(), isNull);
    expect(find.text('Not solved'), findsOneWidget);
  });

  testWidgets('Arabic phone layout has no overflow', (tester) async {
    await _pumpCard(tester, _question(), locale: const Locale('ar'));

    expect(tester.takeException(), isNull);
    expect(find.text('عرض الحل'), findsOneWidget);
  });
}
