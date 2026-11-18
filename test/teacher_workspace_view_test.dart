import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:localingo/localingo.dart';
import 'package:sintir/Core/Themes/app_theme.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/domain/Entities/TeacherCourseActivity.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/domain/Entities/TeacherCoursesQuery.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/Widgets/TeacherWorkspace/TeacherWorkspaceViewBody.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/manager/teacher_courses_cubit/teacher_courses_cubit.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/manager/teacher_wallet_cubit/teacher_wallet_cubit.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/manager/teacher_workspace_insights_cubit/teacher_workspace_insights_cubit.dart';

import 'Features/TeacherWorkEnvironment/wallet/wallet_test_fakes.dart'
    as wallet_fakes;
import 'teacher_workspace_test_data.dart';

FakeWorkspaceRepo _busyTeacher() => FakeWorkspaceRepo(
  courses: [
    workspaceCourse(
      'chem',
      title: 'Chemistry term two',
      students: 21,
      lessons: 24,
      tests: 6,
      ratingsSum: 52,
      ratingsCount: 12,
      posted: DateTime(2026, 9, 1),
    ),
    workspaceCourse(
      'eng',
      title: 'English basics',
      students: 5,
      ratingsSum: 24,
      ratingsCount: 5,
      posted: DateTime(2026, 3, 1),
    ),
    workspaceCourse(
      'draft',
      state: pending,
      title: 'Second month 2027',
      lessons: 0,
      tests: 0,
      posted: DateTime(2026, 11, 1),
    ),
    workspaceCourse(
      'rejected',
      state: declined,
      title: 'Physics revision',
      posted: DateTime(2026, 2, 1),
    ),
  ],
  activities: {
    'chem': TeacherCourseActivity(
      courseId: 'chem',
      newStudents: 12,
      previousNewStudents: 6,
      grossRevenue: 2000,
      openReports: 2,
      coupons: [
        workspaceCoupon('SINTIR20', daysLeft: 1, limit: 20, used: 18),
      ],
    ),
    'eng': TeacherCourseActivity(
      courseId: 'eng',
      newStudents: 1,
      grossRevenue: 300,
      recentReviews: [
        workspaceReview('r1', rating: 2, text: 'Too fast in chapter three'),
      ],
    ),
  },
);

Future<FakeWorkspaceRepo> _pump(
  WidgetTester tester,
  FakeWorkspaceRepo repo, {
  Locale locale = const Locale('en'),
  ThemeData? theme,
  Size size = const Size(411, 2600),
}) async {
  final navigatorKey = GlobalKey<NavigatorState>();
  Localingo.setNavigatorKey(navigatorKey);
  tester.view.devicePixelRatio = 1;
  tester.view.physicalSize = size;
  addTearDown(tester.view.reset);

  final walletRepo = wallet_fakes.FakeTeacherLiveWalletRepo();
  final wallet = TeacherWalletCubit(
    walletRepo: walletRepo,
    teacherId: wallet_fakes.teacherId,
  )..watchWallet();
  final courses = TeacherCoursesCubit(repo: repo, teacherId: 't1')..load();
  final insights = TeacherWorkspaceInsightsCubit(
    repo: repo,
    clock: () => workspaceNow,
  );
  addTearDown(wallet.close);
  addTearDown(courses.close);
  addTearDown(insights.close);

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
        body: MultiBlocProvider(
          providers: [
            BlocProvider.value(value: wallet),
            BlocProvider.value(value: courses),
            BlocProvider.value(value: insights),
          ],
          child: const TeacherWorkspaceViewBody(),
        ),
      ),
    ),
  );
  await tester.pump();
  walletRepo.emitWallet(wallet_fakes.wallet());
  await tester.pumpAndSettle();
  return repo;
}

Finder _key(String value) => find.byKey(ValueKey(value));

void main() {
  testWidgets('summary, attention and course cards come from the data', (
    tester,
  ) async {
    await _pump(tester, _busyTeacher());

    expect(_key('kpi-new-students'), findsOneWidget);
    expect(_key('kpi-change-up'), findsOneWidget);
    expect(find.textContaining('+7'), findsOneWidget);
    expect(_key('kpi-net-earnings'), findsOneWidget);
    expect(find.textContaining('2,185'), findsOneWidget);
    expect(find.text('4.5'), findsOneWidget);

    expect(_key('attention-declined|rejected|'), findsOneWidget);
    expect(_key('attention-openReports|chem|'), findsOneWidget);
    expect(_key('attention-lowRatings|eng|'), findsOneWidget);
    expect(_key('attention-couponEnding|chem|SINTIR20'), findsOneWidget);
    expect(find.text('2 open reports'), findsOneWidget);
    expect(find.text('Coupon SINTIR20 is running out'), findsOneWidget);
    expect(find.textContaining('18 of 20 used'), findsOneWidget);
    expect(find.textContaining('Ends tomorrow'), findsOneWidget);
    expect(find.textContaining('Too fast in chapter three'), findsOneWidget);

    expect(
      find.descendant(
        of: _key('workspace-course-chem'),
        matching: _key('teacher-course-reports'),
      ),
      findsOneWidget,
    );
    expect(
      find.descendant(
        of: _key('workspace-course-draft'),
        matching: _key('teacher-course-add-content'),
      ),
      findsOneWidget,
    );
    expect(
      find.descendant(
        of: _key('workspace-course-rejected'),
        matching: _key('course-state-declined'),
      ),
      findsOneWidget,
    );
    expect(find.text('24 lessons  ·  6 tests'), findsOneWidget);
    expect(_key('workspace-filter-declined'), findsOneWidget);
    expect(_key('workspace-filter-archived'), findsNothing);
    expect(tester.takeException(), isNull);
  });

  testWidgets('filters and sort change the visible cards', (tester) async {
    final repo = await _pump(tester, _busyTeacher());

    double top(String id) =>
        tester.getTopLeft(_key('workspace-course-$id')).dy;
    expect(top('draft'), lessThan(top('eng')));

    await tester.tap(_key('workspace-filter-inReview'));
    await tester.pumpAndSettle();
    expect(_key('workspace-course-draft'), findsOneWidget);
    expect(_key('workspace-course-chem'), findsNothing);

    await tester.tap(_key('workspace-filter-all'));
    await tester.pumpAndSettle();
    await tester.tap(_key('workspace-courses-sort'));
    await tester.pumpAndSettle();
    await tester.tap(_key('workspace-courses-sort-mostStudents'));
    await tester.pumpAndSettle();

    expect(repo.savedSorts, [TeacherCoursesSort.mostStudents]);
    expect(top('chem'), lessThan(top('draft')));

    await tester.enterText(_key('workspace-courses-search'), 'zzz');
    await tester.pump(const Duration(milliseconds: 300));
    await tester.pumpAndSettle();
    expect(_key('workspace-no-matches'), findsOneWidget);

    await tester.tap(_key('workspace-clear-filters'));
    await tester.pumpAndSettle();
    expect(_key('workspace-course-chem'), findsOneWidget);
    final search = tester.widget<TextField>(_key('workspace-courses-search'));
    expect(search.controller?.text, isEmpty);
  });

  testWidgets('long attention lists collapse to four rows', (tester) async {
    final repo = _busyTeacher();
    repo.activities['eng'] = TeacherCourseActivity(
      courseId: 'eng',
      openReports: 1,
      recentReviews: [workspaceReview('r1', rating: 1)],
    );
    await _pump(tester, repo);

    expect(_key('attention-couponEnding|chem|SINTIR20'), findsNothing);
    await tester.tap(_key('attention-toggle'));
    await tester.pumpAndSettle();
    expect(_key('attention-couponEnding|chem|SINTIR20'), findsOneWidget);
  });

  testWidgets('a quiet workspace says so', (tester) async {
    await _pump(
      tester,
      FakeWorkspaceRepo(courses: [workspaceCourse('a', students: 3)]),
    );

    expect(_key('attention-all-clear'), findsOneWidget);
    expect(_key('kpi-change-same'), findsOneWidget);
  });

  testWidgets('a summary failure offers a retry and hides attention', (
    tester,
  ) async {
    final repo = _busyTeacher()..activityFailure = 'offline';
    await _pump(tester, repo);

    expect(_key('workspace-summary-failure'), findsOneWidget);
    expect(_key('workspace-attention'), findsNothing);
    expect(_key('workspace-course-chem'), findsOneWidget);

    repo.activityFailure = null;
    await tester.tap(find.text('Retry'));
    await tester.pumpAndSettle();
    expect(_key('kpi-new-students'), findsOneWidget);
    expect(_key('workspace-attention'), findsOneWidget);
  });

  testWidgets('a teacher without courses sees the add course state', (
    tester,
  ) async {
    await _pump(tester, FakeWorkspaceRepo());

    expect(_key('workspace-no-courses'), findsOneWidget);
    expect(_key('attention-all-clear'), findsOneWidget);
  });

  for (final locale in const [Locale('ar'), Locale('en'), Locale('fr')]) {
    for (final dark in const [false, true]) {
      for (final size in const [Size(360, 2600), Size(1280, 900)]) {
        testWidgets(
          'fits ${size.width.toInt()}px in ${locale.languageCode}, '
          'dark: $dark',
          (tester) async {
            await _pump(
              tester,
              _busyTeacher(),
              locale: locale,
              theme: dark ? AppTheme.dark : AppTheme.light,
              size: size,
            );
            expect(tester.takeException(), isNull);
            expect(_key('workspace-summary'), findsOneWidget);
          },
        );
      }
    }
  }
}
