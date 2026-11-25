import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sintir/Core/Managers/Cubits/test_item_cubit/test_item_cubit.dart';
import 'package:sintir/Core/Themes/app_theme.dart';
import 'package:sintir/Core/entities/CourseEntities/CourseTestItemEntities/CourseTestEntity.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/Widgets/AddExamWidgets/ExamQuestionsWidgets/AddCourseExamAddQuestionListViewItem.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/Widgets/AddExamWidgets/ExamQuestionsWidgets/ExamQuestionImageTile.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/Widgets/AddExamWidgets/ReviewExamWidgets/CustomReviewExamQuestionListItem.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/Widgets/AddExamWidgets/ReviewExamWidgets/CustomReviewQuestionImage.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/Widgets/AddExamWidgets/ReviewExamWidgets/CustomReviewQuestionSolutionIndicator.dart';

import 'add_exam_test_fakes.dart';

const _longText =
    'A deliberately long piece of text that has to wrap across several lines '
    'on a phone instead of overflowing or being cut off at the edge';

/// Question cards must lay out cleanly from small phones to desktops, at
/// large text scales, in both directions and both themes.
void main() {
  const widths = [320.0, 360.0, 412.0, 600.0, 840.0, 1024.0];
  const scales = [1.0, 1.3, 2.0];

  late TestItemCubit cubit;

  Future<void> pump(
    WidgetTester tester, {
    required Widget child,
    double width = 412,
    double scale = 1,
    TextDirection direction = TextDirection.ltr,
    ThemeData? theme,
  }) async {
    tester.view.devicePixelRatio = 1;
    tester.view.physicalSize = Size(width, 2400);
    addTearDown(tester.view.reset);

    await tester.pumpWidget(
      MaterialApp(
        theme: theme ?? AppTheme.light,
        builder: (context, app) => MediaQuery(
          data: MediaQuery.of(
            context,
          ).copyWith(textScaler: TextScaler.linear(scale)),
          child: Directionality(textDirection: direction, child: app!),
        ),
        home: BlocProvider.value(
          value: cubit,
          child: Scaffold(
            body: SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Form(child: child),
            ),
          ),
        ),
      ),
    );
    await tester.pump(const Duration(milliseconds: 300));
  }

  setUp(() => cubit = buildTestItemCubit());
  tearDown(() => cubit.close());

  CourseTestEntity examWithLongQuestion({int? correctIndex}) {
    final question = buildQuestion(
      title: 'Question: $_longText',
      answers: ['Short', _longText, 'Another answer'],
      correctIndex: correctIndex,
    )..imageFile = File('missing-question-image.png');
    return buildExam([question]);
  }

  Widget editCard(CourseTestEntity exam) =>
      AddCourseExamAddQuestionListViewItem(
        index: 0,
        coursetestquestionentity: exam.questions.single,
        coursetestentity: exam,
      );

  group('editing card', () {
    for (final marked in [true, false]) {
      testWidgets('never overflows (correct answer marked: $marked)', (
        tester,
      ) async {
        for (final theme in [AppTheme.light, AppTheme.dark]) {
          for (final direction in TextDirection.values) {
            for (final width in widths) {
              for (final scale in scales) {
                final exam = examWithLongQuestion(
                  correctIndex: marked ? 1 : null,
                );
                await pump(
                  tester,
                  child: editCard(exam),
                  width: width,
                  scale: scale,
                  direction: direction,
                  theme: theme,
                );
                if (!marked) {
                  // The flagged (red) chip has the longest label.
                  cubit.flagQuestionsMissingCorrectAnswer(
                    questions: exam.questions,
                  );
                  await tester.pump(const Duration(milliseconds: 300));
                }
                expect(
                  tester.takeException(),
                  isNull,
                  reason: '${theme.brightness} $direction w=$width x$scale',
                );
              }
            }
          }
        }
      });
    }

    testWidgets('image pickers sit side by side on wide cards and stack on '
        'narrow ones', (tester) async {
      final tiles = find.byType(ExamQuestionImageTile);

      await pump(tester, child: editCard(examWithLongQuestion()), width: 900);
      expect(
        tester.getTopLeft(tiles.at(0)).dy,
        tester.getTopLeft(tiles.at(1)).dy,
      );

      await pump(tester, child: editCard(examWithLongQuestion()), width: 360);
      expect(
        tester.getTopLeft(tiles.at(1)).dy,
        greaterThan(tester.getBottomLeft(tiles.at(0)).dy),
      );
      expect(
        tester.getSize(tiles.at(0)).width,
        tester.getSize(tiles.at(1)).width,
      );
    });

    testWidgets('each radio stays centered on its answer\'s first line', (
      tester,
    ) async {
      for (final scale in scales) {
        final exam = examWithLongQuestion();
        await pump(tester, child: editCard(exam), width: 360, scale: scale);

        final answers = exam.questions.single.solutions;
        for (final (index, solution) in answers.indexed) {
          final editable = tester.allRenderObjects
              .whereType<RenderEditable>()
              .singleWhere((r) => r.text?.toPlainText() == solution.answer);
          final firstLine = editable.getLocalRectForCaret(
            const TextPosition(offset: 0),
          );
          final lineCenter = editable.localToGlobal(firstLine.center).dy;
          final radioCenter = tester
              .getCenter(find.byType(Radio<String>).at(index))
              .dy;
          expect(
            (radioCenter - lineCenter).abs(),
            lessThan(1.5),
            reason: 'answer $index at x$scale',
          );
        }
      }
    });
  });

  group('review card', () {
    for (final withImage in [true, false]) {
      testWidgets('never overflows (with image: $withImage)', (tester) async {
        for (final theme in [AppTheme.light, AppTheme.dark]) {
          for (final direction in TextDirection.values) {
            for (final width in widths) {
              for (final scale in scales) {
                final question = examWithLongQuestion(
                  correctIndex: 1,
                ).questions.single;
                if (!withImage) question.imageFile = null;
                await pump(
                  tester,
                  child: CustomReviewExamQuestionListItem(
                    question: question,
                    totalQuestions: 12,
                    index: 9,
                  ),
                  width: width,
                  scale: scale,
                  direction: direction,
                  theme: theme,
                );
                expect(
                  tester.takeException(),
                  isNull,
                  reason: '${theme.brightness} $direction w=$width x$scale',
                );
              }
            }
          }
        }
      });
    }

    testWidgets('answers take the full width when there is no image', (
      tester,
    ) async {
      final question = examWithLongQuestion(correctIndex: 0).questions.single
        ..imageFile = null;
      await pump(
        tester,
        child: CustomReviewExamQuestionListItem(
          question: question,
          totalQuestions: 1,
          index: 0,
        ),
        width: 900,
      );

      expect(find.byType(CustomReviewQuestionImage), findsNothing);
      final card = tester.getRect(
        find.byType(CustomReviewExamQuestionListItem),
      );
      final answer = tester.getRect(
        find.byType(CustomReviewQuestionSolutionIndicator).first,
      );
      // Only the card padding separates the answer from the card's edge.
      expect(answer.left - card.left, lessThan(48));
    });

    testWidgets('the image sits beside the answers on wide cards and above '
        'them on narrow ones', (tester) async {
      Widget card() => CustomReviewExamQuestionListItem(
        question: examWithLongQuestion(correctIndex: 0).questions.single,
        totalQuestions: 1,
        index: 0,
      );
      final image = find.byType(CustomReviewQuestionImage);
      final firstAnswer = find
          .byType(CustomReviewQuestionSolutionIndicator)
          .first;

      await pump(tester, child: card(), width: 900);
      expect(
        tester.getTopLeft(image).dx,
        greaterThan(tester.getTopRight(firstAnswer).dx),
      );

      await pump(tester, child: card(), width: 360);
      expect(
        tester.getBottomLeft(image).dy,
        lessThan(tester.getTopLeft(firstAnswer).dy),
      );
    });
  });
}
