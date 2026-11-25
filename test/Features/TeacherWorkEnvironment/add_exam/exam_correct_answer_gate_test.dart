import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';
import 'package:sintir/Core/Managers/Cubits/CourseSectionsCubit/CourseSectionsCubit.dart';
import 'package:sintir/Core/Managers/Cubits/test_item_cubit/test_item_cubit.dart';
import 'package:sintir/Core/Themes/app_theme.dart';
import 'package:sintir/Core/entities/CourseEntities/CourseEntity.dart';
import 'package:sintir/Core/entities/CourseEntities/CourseSectionEntity.dart';
import 'package:sintir/Core/widgets/CustomButton.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/domain/Entities/OptionNavigationRequirementsEntity.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/Widgets/AddExamWidgets/AddCourseSectionExamViewBody.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/Widgets/AddExamWidgets/ExamQuestionsWidgets/AddCourseExamAddQuestionListViewItem.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/Widgets/AddExamWidgets/ExamQuestionsWidgets/AddCourseExamAddSolutionItem.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/Widgets/AddExamWidgets/ExamQuestionsWidgets/AddQuestionButton.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/Widgets/AddExamWidgets/ExamQuestionsWidgets/ExamQuestionInputsQuestionHeader.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/Widgets/TeacherWorkspace/TeachespaceEnvironmentTheme.dart';

import '../../../helpers/widget_test_helpers.dart';
import 'add_exam_test_fakes.dart';

void main() {
  group('correct answer rule', () {
    test('a question needs one of its answers marked correct', () {
      expect(buildQuestion(correctIndex: null).hasCorrectAnswer, isFalse);
      final question = buildQuestion(correctIndex: 1);
      expect(question.hasCorrectAnswer, isTrue);
      expect(question.correctSolution, same(question.solutions[1]));
    });

    test('the exam lists the questions without one, in order', () {
      final first = buildQuestion(title: 'first');
      final answered = buildQuestion(title: 'answered', correctIndex: 0);
      final last = buildQuestion(title: 'last');
      final exam = buildExam([first, answered, last]);

      expect(exam.questionsWithoutCorrectAnswer, [first, last]);
    });

    test('answers get distinct ids even when created together', () {
      final question = buildQuestion(answers: List.filled(50, 'x'));
      final ids = question.solutions.map((s) => s.id).toSet();
      expect(ids, hasLength(50));
    });

    test('a newly added question starts with an empty answer', () {
      final exam = buildExam([])..addQuestion(null);
      expect(exam.questions.single.solutions.single.answer, isEmpty);
    });
  });

  group('TestItemCubit', () {
    test('flags the questions missing a correct answer', () async {
      final cubit = buildTestItemCubit();
      final question = buildQuestion();
      final next = cubit.stream.first;

      cubit.flagQuestionsMissingCorrectAnswer(questions: [question]);

      final state = await next;
      expect(state, isA<ExamQuestionsMissingCorrectAnswer>());
      expect((state as ExamQuestionsMissingCorrectAnswer).questions, [
        question,
      ]);
      await cubit.close();
    });

    test(
      'a picked image goes to the question it was picked for only',
      () async {
        final file = File('picked.png');
        final cubit = buildTestItemCubit(pickedFile: file);
        final target = buildQuestion(title: 'target');
        final other = buildQuestion(title: 'other');

        await cubit.pickQuestionImage(question: target);
        await cubit.pickQuestionSolutionImage(question: target);

        expect(target.imageFile, same(file));
        expect(target.solutionFile, same(file));
        expect(other.imageFile, isNull);
        expect(other.solutionFile, isNull);
        final state = cubit.state as PickQuestionSolutionImageSuccess;
        expect(state.question, same(target));
        await cubit.close();
      },
    );
  });

  group('questions step', () {
    late PageController pageController;

    Future<void> pumpAddExam(WidgetTester tester) async {
      ignoreOverflowErrors();
      tester.view.devicePixelRatio = 1;
      tester.view.physicalSize = const Size(900, 1600);
      addTearDown(tester.view.reset);

      await tester.pumpWidget(
        MaterialApp(
          theme: AppTheme.light,
          home: MultiBlocProvider(
            providers: [
              BlocProvider(create: (_) => buildTestItemCubit()),
              BlocProvider(
                create: (_) => CourseSectionsCubit(
                  courseSectionsRepo: FakeCourseSectionsRepo(),
                  sectionItemsActionsRepo: FakeSectionItemsActionsRepo(),
                ),
              ),
            ],
            child: Scaffold(
              body: Provider.value(
                value: OptionNavigationRequirementsEntity(
                  section: CourseSectionEntity.empty(),
                  courseEntity: CourseEntity.empty(),
                  isNewSection: false,
                ),
                child: const AddCourseSectionExamViewBody(),
              ),
            ),
          ),
        ),
      );
      await tester.pump();

      pageController = tester
          .widget<PageView>(find.byType(PageView))
          .controller!;
      pageController.jumpToPage(1);
      await tester.pumpAndSettle();
    }

    Future<void> tapSave(WidgetTester tester) async {
      await tester.tap(find.byType(Custombutton).last);
      await tester.pumpAndSettle();
    }

    Future<void> tapAddQuestion(WidgetTester tester) async {
      final button = find.descendant(
        of: find.byType(AddQuestionButton, skipOffstage: false),
        matching: find.byType(Custombutton, skipOffstage: false),
      );
      await tester.ensureVisible(button);
      await tester.pumpAndSettle();
      await tester.tap(button);
      await tester.pumpAndSettle();
    }

    /// Lets the snackbar's display timer run out before the test ends.
    Future<void> flushSnackBar(WidgetTester tester) async {
      await tester.pump(const Duration(seconds: 4));
      await tester.pumpAndSettle();
    }

    BoxDecoration cardDecoration(WidgetTester tester, int index) {
      final container = tester.widget<AnimatedContainer>(
        find
            .descendant(
              of: find.byType(AddCourseExamAddQuestionListViewItem).at(index),
              matching: find.byType(AnimatedContainer),
            )
            .first,
      );
      return container.decoration! as BoxDecoration;
    }

    testWidgets('Save stays on the questions step until every question has a '
        'correct answer', (tester) async {
      await pumpAddExam(tester);
      final danger = WorkEnvironmentThemeExtension.light.dangerForeground;

      // Two questions, answers typed, nothing marked correct.
      await tapAddQuestion(tester);
      final answerFields = find.descendant(
        of: find.byType(AddCourseExamAddSolutionItem),
        matching: find.byType(TextField),
      );
      expect(answerFields, findsNWidgets(2));
      await tester.enterText(answerFields.at(0), 'Paris');
      await tester.enterText(answerFields.at(1), 'Cairo');

      await tapSave(tester);

      expect(pageController.page, 1, reason: 'must not reach the review step');
      expect(find.byType(SnackBar), findsOneWidget);
      expect(
        find.textContaining('missing_correct_answers'),
        findsOneWidget,
        reason: 'the snackbar explains what is missing',
      );
      expect((cardDecoration(tester, 0).border! as Border).top.color, danger);
      expect((cardDecoration(tester, 1).border! as Border).top.color, danger);

      // Marking only the first question is still not enough.
      await tester.tap(find.byType(Radio<String>).at(0));
      await tester.pumpAndSettle();
      expect(
        (cardDecoration(tester, 0).border! as Border).top.color,
        isNot(danger),
      );
      await tapSave(tester);
      expect(pageController.page, 1);

      // With both marked, Save moves on to the review step.
      await tester.ensureVisible(find.byType(Radio<String>).at(1));
      await tester.pumpAndSettle();
      await tester.tap(find.byType(Radio<String>).at(1));
      await tester.pumpAndSettle();
      await tapSave(tester);
      expect(pageController.page, 2);
      await flushSnackBar(tester);
    });

    testWidgets('an exam with no questions cannot move on', (tester) async {
      await pumpAddExam(tester);

      // Swipe from the header: text fields keep horizontal drags for
      // selecting text.
      await tester.drag(
        find.byType(ExamQuestionInputsQuestionHeader),
        const Offset(-800, 0),
      );
      await tester.pumpAndSettle();
      expect(find.byType(AddCourseExamAddQuestionListViewItem), findsNothing);

      await tapSave(tester);

      expect(pageController.page, 1);
      expect(find.textContaining('error_no_questions'), findsOneWidget);
      await flushSnackBar(tester);
    });

    testWidgets('the first question missing a correct answer scrolls into '
        'view', (tester) async {
      await pumpAddExam(tester);
      for (var i = 0; i < 6; i++) {
        await tapAddQuestion(tester);
      }

      // Mark every question but the last, then go back to the top.
      final radios = find.byType(Radio<String>, skipOffstage: false);
      expect(radios, findsNWidgets(7));
      for (var i = 0; i < 6; i++) {
        await tester.ensureVisible(radios.at(i));
        await tester.pumpAndSettle();
        await tester.tap(radios.at(i));
        await tester.pumpAndSettle();
      }
      final scrollable = find
          .descendant(
            of: find.byType(CustomScrollView),
            matching: find.byType(Scrollable),
          )
          .first;
      tester.state<ScrollableState>(scrollable).position.jumpTo(0);
      await tester.pumpAndSettle();

      final lastCard = find
          .byType(AddCourseExamAddQuestionListViewItem, skipOffstage: false)
          .last;
      final viewport = tester.getRect(scrollable);
      expect(
        tester.getRect(lastCard).top,
        greaterThan(viewport.bottom),
        reason: 'the unanswered question starts off-screen',
      );

      await tapSave(tester);

      expect(pageController.page, 1);
      final top = tester.getRect(lastCard).top;
      expect(top, greaterThanOrEqualTo(viewport.top));
      expect(top, lessThan(viewport.bottom));
      await flushSnackBar(tester);
    });
  });
}
