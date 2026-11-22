import 'dart:async';

import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';
import 'package:localingo/localingo.dart';
import 'package:sintir/Core/Enums/CourseCouponEnum.dart';
import 'package:sintir/Core/Managers/Cubits/course_coupons_cubit/course_coupons_cubit.dart';
import 'package:sintir/Core/Themes/app_theme.dart';
import 'package:sintir/Core/entities/CourseEntities/CourseCouponEntity.dart';
import 'package:sintir/Core/entities/FetchDataResponses/GetCourseCouponsResponseEntity.dart';
import 'package:sintir/Core/errors/Failures.dart';
import 'package:sintir/Core/repos/CourseCouponsRepo/CourseCouponsRepo.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/domain/Helper/CourseDetailsCouponsViewHelper.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/Widgets/CourseDetailViewWidgets/CourseDetailsCouponsWidgets/AddCourseCouponWidgets/AddCourseCouponView.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/Widgets/CourseDetailViewWidgets/CourseDetailsCouponsWidgets/CourseDetailsCouponsViewBody.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/Widgets/CourseDetailViewWidgets/CourseDetailsCouponsWidgets/CourseDetailsCouponsViewFloatingButton.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/manager/coupon_item_actions_cubit/coupon_item_actions_cubit.dart';

import 'helpers/widget_test_helpers.dart';

CourseCouponEntity _coupon(String code, DateTime expiry) => CourseCouponEntity(
      code: code,
      discountPercentage: 20,
      expiryDate: expiry,
      status: CourseCouponStatus.active,
      usageLimit: 10,
      usedCount: 1,
    );

class _FakeCouponsRepo implements CourseCouponsRepo {
  _FakeCouponsRepo(this.coupons);

  final List<CourseCouponEntity> coupons;
  int fetches = 0;
  final List<String> deleted = [];

  @override
  Future<Either<Failure, GetCourseCouponsResponseEntity>> getCourseCoupons({
    required String courseID,
    required bool isPaginate,
  }) async {
    fetches++;
    return Right(GetCourseCouponsResponseEntity(
      coupons: List.of(coupons),
      hasMore: false,
      isPaginate: isPaginate,
    ));
  }

  @override
  Future<Either<Failure, void>> deleteCourseCoupon({
    required String courseID,
    required String couponID,
  }) async {
    deleted.add(couponID);
    return const Right(null);
  }

  @override
  dynamic noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}

Future<void> _pump(
  WidgetTester tester,
  _FakeCouponsRepo repo, {
  CourseCouponEntity? addResult,
}) async {
  ignoreOverflowErrors();
  tester.view.devicePixelRatio = 1;
  tester.view.physicalSize = const Size(500, 1400);
  addTearDown(tester.view.resetPhysicalSize);
  addTearDown(tester.view.resetDevicePixelRatio);
  final key = GlobalKey<NavigatorState>();
  Localingo.setNavigatorKey(key);
  final router = GoRouter(
    navigatorKey: key,
    routes: [
      GoRoute(
        path: '/',
        builder: (_, __) => MultiBlocProvider(
          providers: [
            BlocProvider(create: (_) => CourseCouponsCubit(courseCouponsRepo: repo)),
            BlocProvider(create: (_) => CouponItemActionsCubit(couponsRepo: repo)),
          ],
          child: const Scaffold(
            floatingActionButton: CourseDetailsCouponsViewFloatingButton(courseId: 'c1'),
            body: CourseDetailsCouponsViewBody(courseId: 'c1'),
          ),
        ),
      ),
      GoRoute(
        path: AddCourseCouponView.routeName,
        builder: (context, __) => Scaffold(
          body: TextButton(
            onPressed: () => context.pop(addResult),
            child: const Text('finish-add'),
          ),
        ),
      ),
    ],
  );
  await tester.pumpWidget(
    MaterialApp.router(
      routerConfig: router,
      locale: const Locale('en'),
      supportedLocales: const [Locale('ar'), Locale('en'), Locale('fr')],
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      theme: AppTheme.light,
    ),
  );
  await pumpLocalized(tester);
}

void main() {
  setUpAll(preloadL10nAssets);

  group('coupon list helper', () {
    test('a new coupon is added in expiry order and replaces the same code', () {
      final list = [
        _coupon('LATE', DateTime(2027, 3, 1)),
        _coupon('EARLY', DateTime(2026, 12, 1)),
      ];

      final added = CourseDetailsCouponsViewHelper.upsertCoupon(
        coupons: list,
        coupon: _coupon('MID', DateTime(2027, 1, 1)),
      );
      expect(added.map((c) => c.code), ['LATE', 'MID', 'EARLY']);

      final replaced = CourseDetailsCouponsViewHelper.upsertCoupon(
        coupons: added,
        coupon: _coupon('EARLY', DateTime(2028, 1, 1)),
      );
      expect(replaced.map((c) => c.code), ['EARLY', 'LATE', 'MID']);
      expect(list, hasLength(2));
    });
  });

  test('the cubit hands a created coupon to the list', () async {
    final cubit = CourseCouponsCubit(courseCouponsRepo: _FakeCouponsRepo([]));
    final next = cubit.stream.first;
    final coupon = _coupon('NEW', DateTime(2027, 1, 1));

    cubit.showAddedCoupon(coupon);

    final state = await next;
    expect(state, isA<CourseCouponAddedLocally>());
    expect((state as CourseCouponAddedLocally).coupon, same(coupon));
    await cubit.close();
  });

  group('coupons screen', () {
    testWidgets('a coupon added on the add screen shows up without reopening', (tester) async {
      final repo = _FakeCouponsRepo([_coupon('OLD10', DateTime(2027, 1, 1))]);
      await _pump(tester, repo, addResult: _coupon('NEW20', DateTime(2027, 6, 1)));
      expect(find.text('OLD10'), findsOneWidget);
      expect(find.text('NEW20'), findsNothing);

      await tester.tap(find.byKey(const ValueKey('coupons-add-button')));
      await tester.pumpAndSettle();
      await tester.tap(find.text('finish-add'));
      await tester.pumpAndSettle();

      expect(find.text('NEW20'), findsOneWidget);
      expect(find.text('OLD10'), findsOneWidget);
      expect(repo.fetches, 1);
    });

    testWidgets('leaving the add screen without saving changes nothing', (tester) async {
      final repo = _FakeCouponsRepo([_coupon('OLD10', DateTime(2027, 1, 1))]);
      await _pump(tester, repo);

      await tester.tap(find.byKey(const ValueKey('coupons-add-button')));
      await tester.pumpAndSettle();
      await tester.tap(find.text('finish-add'));
      await tester.pumpAndSettle();

      expect(find.text('OLD10'), findsOneWidget);
      expect(find.byKey(const ValueKey('coupon-OLD10')), findsOneWidget);
      expect(repo.fetches, 1);
    });

    testWidgets('a deleted coupon disappears right away', (tester) async {
      final repo = _FakeCouponsRepo([
        _coupon('KEEP', DateTime(2027, 2, 1)),
        _coupon('GONE', DateTime(2027, 1, 1)),
      ]);
      await _pump(tester, repo);
      expect(find.text('GONE'), findsOneWidget);

      await tester.tap(find.byKey(const ValueKey('coupon-menu-GONE')));
      await tester.pumpAndSettle();
      await tester.tap(find.byKey(const ValueKey('coupon-delete-action')));
      await tester.pumpAndSettle();

      expect(repo.deleted, ['GONE']);
      expect(find.text('GONE'), findsNothing);
      expect(find.byKey(const ValueKey('coupon-GONE')), findsNothing);
      expect(find.text('KEEP'), findsOneWidget);
      expect(repo.fetches, 1);
    });
  });
}
