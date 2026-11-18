import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:localingo/localingo.dart';
import 'package:sintir/Core/Themes/app_theme.dart';
import 'package:sintir/Core/entities/CourseEntities/CourseEntity.dart';
import 'package:sintir/Core/utils/Backend_EndPoints.dart';
import 'package:sintir/Features/Auth/Domain/Entities/TeacherWalletEntity.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/Widgets/TeacherWorkenvironmentviewWidgets/TeacherCourseCard/teacher_course_card.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/Widgets/TeacherWorkenvironmentviewWidgets/TeacherCourseCard/widgets/body/teacher_course_new_chip.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/Widgets/TeacherWorkenvironmentviewWidgets/TeacherCourseStatus.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/Widgets/TeacherWorkenvironmentviewWidgets/TeacherCoursesFilterBar.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/Widgets/TeacherWorkenvironmentviewWidgets/TeacherCoursesSectionHeader.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/Widgets/TeacherWorkenvironmentviewWidgets/TeacherEnvironmenCoursesGridDisplayedCourses.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/Widgets/SharedWallet/teacher_wallet_card.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/Widgets/TeacherWorkenvironmentviewWidgets/TeacherWorkenvironmentviewBodyWalletSectionHeader.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  final testWallet = TeacherWalletEntity(
    walletId: 101,
    teacherId: 'teacher_123',
    balance: 1323.00,
    totalEarned: 5000.00,
    payoutPending: 250.00,
    currency: 'EGP',
    status: BackendEndpoints.walletActive,
    createdAt: DateTime(2024, 1, 1),
    updatedAt: DateTime(2024, 5, 1),
  );

  final testCourses = [
    CourseEntity(
      id: 'c1',
      title: 'كورس تأسيس الإنجليزي',
      description: 'وصف الدورة',
      language: 'ar',
      state: BackendEndpoints.coursePublishedState,
      price: 1300,
      studentsCount: 8,
      lessonsCount: 28,
      testsCount: 6,
      feedBacksCount: 5,
      posterUrl: null,
      postedDate: DateTime.now(),
      subject: 'English',
      level: 'Secondary',
    ),
    CourseEntity(
      id: 'c2',
      title: 'كورس مراجعات نهائية مكثفة',
      description: 'وصف الدورة',
      language: 'ar',
      state: BackendEndpoints.coursePendingState,
      price: 160,
      studentsCount: 0,
      lessonsCount: 10,
      testsCount: 2,
      feedBacksCount: 0,
      posterUrl: null,
      postedDate: DateTime.now(),
      subject: 'Arabic',
      level: 'Secondary',
    ),
    CourseEntity(
      id: 'c3',
      title: 'اشتراك الشهر الأول 2024',
      description: 'وصف الدورة',
      language: 'ar',
      state: BackendEndpoints.courseDeletedState,
      price: 170,
      studentsCount: 42,
      lessonsCount: 8,
      testsCount: 1,
      feedBacksCount: 4,
      posterUrl: null,
      postedDate: DateTime.now(),
      subject: 'Math',
      level: 'Secondary',
    ),
  ];

  Widget buildTestApp({
    required Widget child,
    required ThemeData theme,
    required Locale locale,
    required Size size,
    required double textScale,
    required GlobalKey<NavigatorState> navigatorKey,
  }) {
    Localingo.setNavigatorKey(navigatorKey);
    return MaterialApp(
      navigatorKey: navigatorKey,
      locale: locale,
      supportedLocales: const [Locale('ar'), Locale('en'), Locale('fr')],
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      theme: theme,
      home: MediaQuery(
        data: MediaQueryData(
          size: size,
          textScaler: TextScaler.linear(textScale),
        ),
        child: Scaffold(
          body: Directionality(
            textDirection: locale.languageCode == 'ar'
                ? TextDirection.rtl
                : TextDirection.ltr,
            child: child,
          ),
        ),
      ),
    );
  }

  testWidgets(
    'teacher work environment components and responsive layout comprehensive suite',
    (tester) async {
      final navKey = GlobalKey<NavigatorState>();
      Localingo.setNavigatorKey(navKey);

      // 1. Wallet card displays balance, button, and pending line when > 0
      tester.view.devicePixelRatio = 1.0;
      tester.view.physicalSize = const Size(390, 844);

      await tester.pumpWidget(
        buildTestApp(
          child: SingleChildScrollView(
            child: TeacherWalletCard(wallet: testWallet),
          ),
          theme: AppTheme.dark,
          locale: const Locale('ar'),
          size: const Size(390, 844),
          textScale: 1.0,
          navigatorKey: navKey,
        ),
      );
      await tester.pumpAndSettle();

      expect(
        find.textContaining('1,323.00', findRichText: true),
        findsOneWidget,
      );
      expect(find.byType(FilledButton), findsOneWidget);
      expect(
        find.byWidgetPredicate(
          (w) =>
              w is Text &&
              (w.data?.contains('250.00') == true ||
                  w.data?.contains('pending_withdrawal') == true),
        ),
        findsOneWidget,
      );

      // 2. Pending line is hidden when payoutPending is 0
      final zeroPendingWallet = TeacherWalletEntity(
        walletId: 102,
        teacherId: 'teacher_123',
        balance: 1000.0,
        totalEarned: 1000.0,
        payoutPending: 0,
        currency: 'EGP',
        status: BackendEndpoints.walletActive,
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
      );

      await tester.pumpWidget(
        buildTestApp(
          child: SingleChildScrollView(
            child: TeacherWalletCard(wallet: zeroPendingWallet),
          ),
          theme: AppTheme.dark,
          locale: const Locale('ar'),
          size: const Size(390, 844),
          textScale: 1.0,
          navigatorKey: navKey,
        ),
      );
      await tester.pumpAndSettle();

      expect(find.textContaining('250.00'), findsNothing);

      // 3. Course card shows title, price, counters and the "New" chip
      //    (rating was removed from the card by design).
      await tester.pumpWidget(
        buildTestApp(
          child: SingleChildScrollView(
            child: SizedBox(
              width: 220,
              height: 300,
              child: TeacherCourseCard(course: testCourses[0], onTap: () {}),
            ),
          ),
          theme: AppTheme.dark,
          locale: const Locale('ar'),
          size: const Size(390, 844),
          textScale: 1.0,
          navigatorKey: navKey,
        ),
      );
      await tester.pumpAndSettle();

      expect(find.text('كورس تأسيس الإنجليزي'), findsOneWidget);
      expect(find.textContaining('1,300'), findsOneWidget);
      expect(find.text('8 طلاب'), findsOneWidget);
      expect(find.text('28 درسًا • 6 اختبارات'), findsOneWidget);
      expect(find.byIcon(Icons.star_rounded), findsNothing);
      // Posted today → recently published.
      expect(find.byType(TeacherCourseNewChip), findsOneWidget);

      // A course with no feedback still shows no rating star
      await tester.pumpWidget(
        buildTestApp(
          child: SingleChildScrollView(
            child: SizedBox(
              width: 220,
              height: 300,
              child: TeacherCourseCard(course: testCourses[1], onTap: () {}),
            ),
          ),
          theme: AppTheme.dark,
          locale: const Locale('ar'),
          size: const Size(390, 844),
          textScale: 1.0,
          navigatorKey: navKey,
        ),
      );
      await tester.pumpAndSettle();

      expect(find.byIcon(Icons.star_rounded), findsNothing);

      // 4. Matrix: Dark/Light × Arabic/English × 6 sizes × 3 text scales
      final sizes = [
        const Size(360, 640),
        const Size(390, 844),
        const Size(600, 960),
        const Size(820, 1180),
        const Size(1280, 800),
        const Size(1366, 1024),
      ];

      final scales = [1.0, 1.3, 2.0];

      for (final theme in [AppTheme.dark, AppTheme.light]) {
        for (final locale in [const Locale('ar'), const Locale('en')]) {
          for (final size in sizes) {
            for (final scale in scales) {
              tester.view.devicePixelRatio = 1.0;
              tester.view.physicalSize = size;

              await tester.pumpWidget(
                buildTestApp(
                  child: CustomScrollView(
                    slivers: [
                      const SliverToBoxAdapter(
                        child:
                            TeacherWorkenvironmentviewBodyWalletSectionHeader(),
                      ),
                      const SliverToBoxAdapter(child: SizedBox(height: 12)),
                      SliverToBoxAdapter(
                        child: TeacherWalletCard(
                          wallet: testWallet,
                        ),
                      ),
                      const SliverToBoxAdapter(child: SizedBox(height: 24)),
                      const SliverToBoxAdapter(
                        child: TeacherCoursesSectionHeader(),
                      ),
                      const SliverToBoxAdapter(child: SizedBox(height: 12)),
                      SliverToBoxAdapter(
                        child: TeacherCoursesFilterBar(
                          searchController: TextEditingController(),
                          selectedStatus: TeacherCourseStatus.all,
                          onStatusSelected: (_) {},
                          allCount: 3,
                          publishedCount: 1,
                          inReviewCount: 1,
                          archivedCount: 1,
                        ),
                      ),
                      const SliverToBoxAdapter(child: SizedBox(height: 16)),
                      TeacherEnvironmenCoursesGridDisplayedCourses(
                        coursesList: testCourses,
                      ),
                    ],
                  ),
                  theme: theme,
                  locale: locale,
                  size: size,
                  textScale: scale,
                  navigatorKey: navKey,
                ),
              );
              await tester.pumpAndSettle();

              final err = tester.takeException();
              if (err != null) {
                if (err is FlutterError) {
                  // ignore: avoid_print
                  print('OVERFLOW MESSAGE: ${err.message}');
                  for (final d in err.diagnostics) {
                    // ignore: avoid_print
                    print('DIAG: ${d.name} -> $d');
                  }
                } else {
                  // ignore: avoid_print
                  print('OVERFLOW ON size $size scale $scale: $err');
                }
              }
              expect(
                err,
                isNull,
                reason:
                    'Overflow on ${theme.brightness}, locale $locale, size $size, scale $scale',
              );
            }
          }
        }
      }
    },
  );
}
