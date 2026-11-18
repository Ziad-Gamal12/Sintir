import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:localingo/localingo.dart';
import 'package:sintir/Core/Themes/app_theme.dart';
import 'package:sintir/Core/entities/CourseEntities/CourseTestItemEntities/CourseTestQuestionEntity.dart';
import 'package:sintir/Core/entities/CourseEntities/CourseTestItemEntities/ExamResultSolvedQuestionEntity.dart';
import 'package:sintir/Core/entities/CourseEntities/CourseTestItemEntities/TestResulteEntity.dart';
import 'package:sintir/Features/CourseManagementAndInteractionFeature/domain/Entities/JoinedByEntity.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/Widgets/TestConsequencesViewWidgets/StudentInfoTexts.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/Widgets/TestConsequencesViewWidgets/StudentResultCard.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/Widgets/TestConsequencesViewWidgets/StudentResultCardDisplayFullResultWIdget.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/Widgets/TestConsequencesViewWidgets/StudentResultStatusChip.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/Widgets/TestConsequencesViewWidgets/StudentStatItem.dart';
import 'package:sintir/constant.dart';

void main() async {
  TestWidgetsFlutterBinding.ensureInitialized();
  await initializeDateFormatting('ar');
  await initializeDateFormatting('en');
  await initializeDateFormatting('fr');

  test('formats submission date and time without regex mangling', () {
    final date = DateTime(2026, 11, 15, 15, 45);

    final enResult = StudentInfoTexts.formatSubmissionDateTime(date, 'en');
    expect(enResult, contains('Nov 15, 2026'));
    expect(enResult, contains('3:45'));

    final frResult = StudentInfoTexts.formatSubmissionDateTime(date, 'fr');
    expect(frResult, contains('15 nov. 2026'));
    expect(frResult, contains('15:45'));

    final arResult = StudentInfoTexts.formatSubmissionDateTime(date, 'ar');
    expect(arResult, contains('نوفمبر'));
    expect(arResult, contains('2026'));
    expect(arResult, contains('3:45'));
  });

  testWidgets('StudentResultCard and components comprehensive test suite', (
    tester,
  ) async {
    final navigatorKey = GlobalKey<NavigatorState>();
    Localingo.setNavigatorKey(navigatorKey);

    Future<void> pumpTestCard({
      required Widget child,
      Locale? locale,
      ThemeData? theme,
      Size size = const Size(390, 844),
      double textScale = 1.0,
    }) async {
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
            child: Scaffold(
              body: Directionality(
                textDirection: (locale?.languageCode ?? 'ar') == 'ar'
                    ? TextDirection.rtl
                    : TextDirection.ltr,
                child: SingleChildScrollView(
                  child: RepaintBoundary(
                    key: const ValueKey('card_capture'),
                    child: child,
                  ),
                ),
              ),
            ),
          ),
        ),
      );
      await tester.pump();
      await tester.pump(const Duration(milliseconds: 100));
    }

    // 1. Restored public class and compatibility aliases
    bool tapped = false;
    const widget1 = StudentResultCardDisplayFullResultWidget();
    expect(widget1, isA<Widget>());

    final widget2 = StudentResultCardDisplayFullResultWIdget(
      onTap: () => tapped = true,
    );
    expect(widget2, isA<StudentResultCardDisplayFullResultWidget>());

    const widget3 = StudentResultCardAction();
    expect(widget3, isA<StudentResultCardDisplayFullResultWidget>());

    await pumpTestCard(
      child: StudentResultCardDisplayFullResultWidget(
        onTap: () => tapped = true,
      ),
    );
    expect(
      find.byType(StudentResultCardDisplayFullResultWidget),
      findsOneWidget,
    );
    await tester.tap(find.byType(StudentResultCardDisplayFullResultWidget));
    expect(tapped, isTrue);

    // 2. Zero-question defensive statistics
    final zeroResult = _buildResult(total: 0, correctCount: 0, isPassed: false);
    await pumpTestCard(child: StudentResultCard(testResultEntity: zeroResult));
    expect(find.text('—'), findsNWidgets(2));
    expect(find.text('0%'), findsNothing);
    expect(find.text('0.0%'), findsNothing);
    expect(find.text('0/0'), findsNothing);

    // 3. 100% full-mark result
    final fullResult = _buildResult(total: 5, correctCount: 5, isPassed: true);
    await pumpTestCard(child: StudentResultCard(testResultEntity: fullResult));
    expect(find.text('100%'), findsOneWidget);
    expect(find.text('5/5'), findsOneWidget);

    // 4. Partial marks & 66.7% passing business logic verification
    final partialResult = _buildResult(
      total: 4,
      correctCount: 3,
      isPassed: true,
    );
    await pumpTestCard(
      child: StudentResultCard(testResultEntity: partialResult),
    );
    expect(find.text('75%'), findsOneWidget);
    expect(find.text('3/4'), findsOneWidget);

    // Business logic verification: 2 out of 3 = 66.7% is passed in SINTIR
    final twoThirdsResult = _buildResult(
      total: 3,
      correctCount: 2,
      isPassed: true,
    );
    await pumpTestCard(
      child: StudentResultCard(testResultEntity: twoThirdsResult),
    );
    expect(find.text('66.7%'), findsOneWidget);
    expect(find.text('2/3'), findsOneWidget);

    // 5. Exactly ONE status chip per card, paired directly with Evaluation Rate score
    expect(find.byType(StudentResultStatusChip), findsOneWidget);
    final evalItem = tester.widget<StudentStatItem>(
      find.byType(StudentStatItem).first,
    );
    expect(evalItem.statusChip, isNotNull);

    // 6. Redundant bottom CTA button removed
    expect(find.byType(StudentResultCardDisplayFullResultWidget), findsNothing);

    // 7. No raw Firebase UID exposed
    final secretUidResult = _buildResult(
      total: 5,
      correctCount: 4,
      isPassed: true,
      uid: 'raw_firebase_secret_uid_1234567890',
    );
    await pumpTestCard(
      child: StudentResultCard(testResultEntity: secretUidResult),
    );
    expect(find.textContaining('raw_firebase_secret_uid'), findsNothing);

    // 8. Brand colors used for stats items
    final statItems = tester
        .widgetList<StudentStatItem>(find.byType(StudentStatItem))
        .toList();
    expect(statItems.length, 2);
    expect(statItems[0].backgroundColor, KMainColor);
    expect(statItems[1].backgroundColor, KSecondaryColor);

    // 9. Directionality: chevron mirrors in RTL vs LTR
    await pumpTestCard(
      locale: const Locale('ar'),
      child: StudentResultCard(testResultEntity: fullResult),
    );
    expect(find.byIcon(Icons.chevron_left_rounded), findsOneWidget);

    await pumpTestCard(
      locale: const Locale('en'),
      child: StudentResultCard(testResultEntity: fullResult),
    );
    expect(find.byIcon(Icons.chevron_right_rounded), findsOneWidget);

    // 10. Responsive & text scaling stress tests across widths and themes
    for (final width in [360.0, 390.0, 430.0]) {
      for (final scale in [1.0, 1.3, 1.5, 2.0]) {
        for (final isDark in [false, true]) {
          final longNameResult = _buildResult(
            total: 10,
            correctCount: 7,
            isPassed: true,
            studentName: 'محمد عبد الرحمن الشيخ إبراهيم القاسمي الطويل جداً',
          );
          await pumpTestCard(
            size: Size(width, 800),
            textScale: scale,
            theme: isDark ? AppTheme.dark : AppTheme.light,
            child: StudentResultCard(testResultEntity: longNameResult),
          );
          expect(tester.takeException(), isNull);
        }
      }
    }

    await tester.pumpWidget(const SizedBox.shrink());
    tester.view.resetPhysicalSize();
    tester.view.resetDevicePixelRatio();
  });
}

TestResultEntity _buildResult({
  required int total,
  required int correctCount,
  required bool isPassed,
  String studentName = 'Ziad Gamal Mahmoud',
  String uid = 'test_student_uid_xyz',
}) {
  final questions = <ExamResultSolvedQuestionEntity>[];
  for (int i = 0; i < total; i++) {
    questions.add(
      ExamResultSolvedQuestionEntity(
        question: CourseTestQuestionEntity(
          questionId: 'q_$i',
          questionTitle: 'Question $i',
          solutions: [],
          isOpened: false,
        ),
        isCorrect: i < correctCount,
      ),
    );
  }

  return TestResultEntity(
    serialNumber: 'test_serial_101',
    joinedDate: DateTime(2026, 11, 15, 14, 30),
    totalQuestions: total,
    solvedQuestions: total,
    testName: 'Test',

    isPassed: isPassed,
    joinedbyentity: JoinedByEntity(
      uid: uid,
      name: studentName,
      imageUrl: '', // empty to use initials fallback in widget test
      joinedDate: DateTime(2026, 1, 1),
    ),
    result: correctCount,
    questionsSolvedListEntity: questions,
    courseId: 'c_1',
    sectionId: 's_1',
    testId: 't_1',
    courseSubject: 'Mathematics',
  );
}
