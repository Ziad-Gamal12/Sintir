import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:localingo/localingo.dart';
import 'package:sintir/Core/Themes/app_theme.dart';
import 'package:sintir/Core/entities/CourseEntities/CourseTestItemEntities/CourseTestQuestionEntity.dart';
import 'package:sintir/Core/entities/CourseEntities/CourseTestItemEntities/ExamResultSolvedQuestionEntity.dart';
import 'package:sintir/Core/entities/CourseEntities/CourseTestItemEntities/TestResulteEntity.dart';
import 'package:sintir/Features/CourseManagementAndInteractionFeature/domain/Entities/JoinedByEntity.dart';
import 'package:sintir/Features/MyResults/Presentation/Views/Widgets/results_adaptive_layout.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('results layout fits all requested locales, themes, sizes and scales', (
    tester,
  ) async {
    final controller = ScrollController();
    final navigatorKey = GlobalKey<NavigatorState>();
    Localingo.setNavigatorKey(navigatorKey);
    for (final locale in [
      const Locale('ar'),
      const Locale('en'),
      const Locale('fr'),
    ]) {
      for (final theme in [AppTheme.light, AppTheme.dark]) {
        for (final size in [
          const Size(320, 1000),
          const Size(360, 1000),
          const Size(411, 1000),
          const Size(600, 1000),
          const Size(840, 1000),
          const Size(1200, 1000),
          const Size(840, 600),
        ]) {
          for (final scale in [1.0, 1.5]) {
            tester.view.devicePixelRatio = 1;
            tester.view.physicalSize = size;
            await tester.pumpWidget(
              MaterialApp(
                navigatorKey: navigatorKey,
                locale: locale,
                supportedLocales: const [
                  Locale('ar'),
                  Locale('en'),
                  Locale('fr'),
                ],
                localizationsDelegates: const [
                  AppLocalizations.delegate,
                  GlobalMaterialLocalizations.delegate,
                  GlobalWidgetsLocalizations.delegate,
                  GlobalCupertinoLocalizations.delegate,
                ],
                theme: theme,
                home: MediaQuery(
                  data: MediaQueryData(
                    size: size,
                    textScaler: TextScaler.linear(scale),
                  ),
                  child: Scaffold(
                    body: ResultsAdaptiveLayout(
                      results: [_result(locale.languageCode)],
                      average: 67,
                      totalCount: 1,
                      hasMore: false,
                      isActive: true,
                      scrollController: controller,
                      onRefresh: () async {},
                      isLoadingMore: false,
                    ),
                  ),
                ),
              ),
            );
            await tester.pumpAndSettle();
            final exception = tester.takeException();
            if (exception != null) {
              for (final element in find.byType(Column).evaluate()) {
                final flex = element.renderObject! as RenderFlex;
                var child = flex.firstChild;
                var childHeight = 0.0;
                while (child != null) {
                  childHeight += child.size.height;
                  child = flex.childAfter(child);
                }
                if (childHeight > flex.size.height + 0.5) {
                  // Include the overflowing column's parent chain in the test output.
                  // ignore: avoid_print
                  print(
                    '${flex.size} children=$childHeight ${flex.toStringDeep()}',
                  );
                }
              }
              for (final element in find.byType(Row).evaluate()) {
                final flex = element.renderObject! as RenderFlex;
                if (flex.direction != Axis.horizontal) continue;
                var child = flex.firstChild;
                var childWidth = 0.0;
                while (child != null) {
                  childWidth += child.size.width;
                  child = flex.childAfter(child);
                }
                if (childWidth > flex.size.width + 0.5) {
                  // Include the offending row so narrow split panes can be fixed.
                  // ignore: avoid_print
                  print(
                    '${flex.size} children=$childWidth ${flex.toStringDeep()}',
                  );
                }
              }
            }
            expect(
              exception,
              isNull,
              reason:
                  '${locale.languageCode}, ${theme.brightness}, $size, $scale',
            );
          }
        }
      }
    }
    await tester.pumpWidget(const SizedBox.shrink());
    controller.dispose();
    tester.view.resetPhysicalSize();
    tester.view.resetDevicePixelRatio();
  });
}

TestResultEntity _result(String locale) {
  final answers = List.generate(
    10,
    (index) => ExamResultSolvedQuestionEntity(
      question: CourseTestQuestionEntity(
        questionId: '$index',
        questionTitle: 'Question',
        solutions: [],
        isOpened: false,
      ),
      isCorrect: index < 7,
    ),
  );
  return TestResultEntity(
    serialNumber: '812-1',
    joinedDate: DateTime(2026, 8, 12),
    totalQuestions: 10,
    solvedQuestions: 10,
    testName: 'Test',

    isPassed: true,
    joinedbyentity: JoinedByEntity(
      uid: 'student',
      name: 'Alexandria Long Student Name for Layout Verification',
      imageUrl: '',
      joinedDate: DateTime(2025, 8, 12),
    ),
    result: 0,
    questionsSolvedListEntity: answers,
    courseId: 'course',
    sectionId: 'section',
    testId: 'test',
    courseSubject: locale == 'fr'
        ? 'Évaluation académique : résultats détaillés de la session actuelle'
        : 'Long assessment title for responsive layout verification',
  );
}
