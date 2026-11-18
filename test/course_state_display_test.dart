import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:localingo/localingo.dart';
import 'package:sintir/Core/Themes/app_theme.dart';
import 'package:sintir/Core/entities/CourseEntities/CourseEntity.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/domain/Entities/TeacherCourseState.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/Widgets/CourseDetailViewWidgets/course_detail_poster.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/Widgets/CourseDetailViewWidgets/course_detail_state_notice.dart';

Future<void> _pump(WidgetTester tester, Widget child) async {
  final navigatorKey = GlobalKey<NavigatorState>();
  Localingo.setNavigatorKey(navigatorKey);
  tester.view.devicePixelRatio = 1;
  tester.view.physicalSize = const Size(390, 900);
  addTearDown(tester.view.reset);
  await tester.pumpWidget(
    MaterialApp(
      navigatorKey: navigatorKey,
      locale: const Locale('ar'),
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
          child: child,
        ),
      ),
    ),
  );
  await tester.pumpAndSettle();
}

CourseEntity _course(String state) => CourseEntity.empty()
  ..state = state
  ..posterUrl = null;

void main() {
  const cases = [
    ['Rejected', 'declined', 'مرفوض'],
    ['Declined', 'declined', 'مرفوض'],
    ['Pending', 'inReview', 'قيد المراجعة'],
    ['Archived', 'hiddenByAdmin', 'مخفي من الإدارة'],
    ['DeletedByAdmin', 'removedByAdmin', 'محذوف من الإدارة'],
    ['Published', 'published', 'منشور'],
  ];

  for (final item in cases) {
    testWidgets('the poster shows ${item[0]} as a translated state', (
      tester,
    ) async {
      await _pump(tester, CourseDetailPoster(course: _course(item[0])));

      expect(find.byKey(ValueKey('course-state-${item[1]}')), findsOneWidget);
      expect(find.text(item[2]), findsOneWidget);
      if (item[0] != item[2]) expect(find.text(item[0]), findsNothing);
      expect(tester.takeException(), isNull);
    });
  }

  testWidgets('declined and admin states explain what to do', (tester) async {
    await _pump(
      tester,
      const Column(
        children: [
          CourseDetailStateNotice(state: TeacherCourseState.declined),
          CourseDetailStateNotice(state: TeacherCourseState.hiddenByAdmin),
          CourseDetailStateNotice(state: TeacherCourseState.inReview),
          CourseDetailStateNotice(state: TeacherCourseState.published),
        ],
      ),
    );

    expect(
      find.byKey(const ValueKey('course-state-notice-declined')),
      findsOneWidget,
    );
    expect(find.text('تم رفض الدورة في المراجعة'), findsOneWidget);
    expect(
      find.byKey(const ValueKey('course-state-notice-hiddenByAdmin')),
      findsOneWidget,
    );
    expect(
      find.byKey(const ValueKey('course-state-notice-inReview')),
      findsOneWidget,
    );
    expect(
      find.byKey(const ValueKey('course-state-notice-published')),
      findsNothing,
    );
    expect(
      CourseDetailStateNotice.showsFor(TeacherCourseState.archived),
      isFalse,
    );
  });
}
