import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:localingo/localingo.dart';
import 'package:sintir/Core/entities/CourseEntities/CourseTestItemEntities/CourseTestQuestionEntity.dart';
import 'package:sintir/Core/entities/CourseEntities/CourseTestItemEntities/ExamResultSolvedQuestionEntity.dart';
import 'package:sintir/Core/entities/CourseEntities/CourseTestItemEntities/TestResulteEntity.dart';
import 'package:sintir/Features/CourseManagementAndInteractionFeature/domain/Entities/JoinedByEntity.dart';
import 'package:sintir/Features/MyResults/Presentation/Views/Widgets/results_adaptive_layout.dart';
import 'package:sintir/Features/MyResults/Presentation/Views/Widgets/results_end_of_list.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('pagination footer switches between loading and end states', (
    tester,
  ) async {
    final navigatorKey = GlobalKey<NavigatorState>();
    Localingo.setNavigatorKey(navigatorKey);
    for (final size in [const Size(320, 900), const Size(1200, 900)]) {
      for (final loading in [true, false]) {
        final controller = ScrollController();
        tester.view.devicePixelRatio = 1;
        tester.view.physicalSize = size;
        await tester.pumpWidget(
          MaterialApp(
            navigatorKey: navigatorKey,
            supportedLocales: const [Locale('ar'), Locale('en'), Locale('fr')],
            localizationsDelegates: const [
              AppLocalizations.delegate,
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
            ],
            home: Scaffold(
              body: ResultsAdaptiveLayout(
                results: [_result()],
                average: 70,
                totalCount: 2,
                hasMore: true,
                isActive: true,
                scrollController: controller,
                onRefresh: () async {},
                isLoadingMore: loading,
              ),
            ),
          ),
        );
        await tester.pump();
        await tester.drag(
          find.byType(CustomScrollView),
          const Offset(0, -1200),
        );
        await tester.pump();
        final loader = find.byWidgetPredicate(
          (widget) =>
              widget is CircularProgressIndicator ||
              widget is CupertinoActivityIndicator,
        );
        expect(loader, loading ? findsOneWidget : findsNothing);
        expect(find.byType(ResultsEndOfList), findsNothing);
        await tester.pumpWidget(const SizedBox.shrink());
        controller.dispose();

        if (!loading) continue;
        final endController = ScrollController();
        await tester.pumpWidget(
          MaterialApp(
            navigatorKey: navigatorKey,
            supportedLocales: const [Locale('ar'), Locale('en'), Locale('fr')],
            localizationsDelegates: const [
              AppLocalizations.delegate,
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
            ],
            home: Scaffold(
              body: ResultsAdaptiveLayout(
                results: [_result()],
                average: 70,
                totalCount: 1,
                hasMore: false,
                isActive: true,
                scrollController: endController,
                onRefresh: () async {},
                isLoadingMore: false,
              ),
            ),
          ),
        );
        await tester.pump();
        await tester.drag(
          find.byType(CustomScrollView),
          const Offset(0, -1200),
        );
        await tester.pump();
        expect(loader, findsNothing);
        expect(find.byType(ResultsEndOfList), findsOneWidget);
        await tester.pumpWidget(const SizedBox.shrink());
        endController.dispose();
      }
    }
    tester.view.resetPhysicalSize();
    tester.view.resetDevicePixelRatio();
  });
}

TestResultEntity _result() => TestResultEntity(
  serialNumber: '812-1',
  joinedDate: DateTime(2026, 8, 12),
  totalQuestions: 1,
  solvedQuestions: 1,
  testName: 'Test',
  isPassed: true,
  joinedbyentity: JoinedByEntity(
    uid: 'student',
    name: 'Student',
    imageUrl: '',
    joinedDate: DateTime(2025, 8, 12),
  ),
  result: 0,
  questionsSolvedListEntity: [
    ExamResultSolvedQuestionEntity(
      question: CourseTestQuestionEntity(
        questionId: '1',
        questionTitle: 'Question',
        solutions: [],
        isOpened: false,
      ),
      isCorrect: true,
    ),
  ],
  courseId: 'course',
  sectionId: 'section',
  testId: 'test',
  courseSubject: 'Assessment',
);
