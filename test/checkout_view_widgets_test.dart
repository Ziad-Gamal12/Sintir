import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:localingo/localingo.dart';
import 'package:sintir/Core/Managers/Cubits/course_checkout_cubit/course_checkout_cubit.dart';
import 'package:sintir/Core/Themes/app_theme.dart';
import 'package:sintir/Core/entities/BottomSheetNavigationRequirmentsEntity.dart';
import 'package:sintir/Core/entities/CourseEntities/ContentCreaterEntity.dart';
import 'package:sintir/Core/entities/CourseEntities/CourseEntity.dart';
import 'package:sintir/Core/entities/CourseEntities/CourseRatingStatsEntity.dart';
import 'package:sintir/Core/repos/CourseCheckoutRepo/CourseCheckoutRepo.dart';
import 'package:sintir/Features/Subscribtion/Domain/Entities/CourseCheckoutEntity.dart';
import 'package:sintir/Features/Subscribtion/Presentation/View/Widgets/SubscribtionViewBody.dart';

class _FakeCheckoutGateway implements CourseCheckoutGateway {
  Object? quoteError;
  String? lastQuoteCoupon;
  String? lastCreateCoupon;
  int createCalls = 0;
  final Completer<CoursePaymentAttempt> createCompleter = Completer();

  @override
  Future<CourseCheckoutQuote> quote({
    required String courseId,
    String? couponCode,
  }) async {
    lastQuoteCoupon = couponCode;
    if (quoteError != null) throw quoteError!;
    return CourseCheckoutQuote(
      originalAmountCents: 20000,
      discountAmountCents: 4000,
      amountCents: 16000,
      currency: 'EGP',
      couponCode: couponCode,
      discountPercentage: 20,
    );
  }

  @override
  Future<CoursePaymentAttempt> createPayment({
    required String courseId,
    required String idempotencyKey,
    String? couponCode,
  }) {
    createCalls++;
    lastCreateCoupon = couponCode;
    return createCompleter.future;
  }

  @override
  Future<CoursePaymentStatusResult> paymentStatus(
    String paymentAttemptId,
  ) async =>
      const CoursePaymentStatusResult(status: 'pending');

  @override
  Future<bool> isSubscribed(String courseId) async => false;
}

CourseEntity _course() => CourseEntity(
      id: 'c1',
      state: 'published',
      posterUrl: '',
      studentsCount: 21,
      subject: 'Chemistry',
      level: '3rd Grade Secondary',
      title: 'Chemistry, full second term',
      description: '',
      price: 200,
      language: 'العربية',
      postedDate: DateTime(2026, 9, 1),
      lessonsCount: 24,
      testsCount: 6,
      feedBacksCount: 0,
      contentcreaterentity: Contentcreaterentity(
        name: 'Ziad Gamal',
        profileImageUrl: '',
        id: 't1',
        title: '',
      ),
      ratingStats: const CourseRatingStatsEntity(
        ratingsSum: 52,
        ratingsCount: 12,
      ),
    );

Future<_FakeCheckoutGateway> _pumpCheckout(
  WidgetTester tester, {
  Locale locale = const Locale('en'),
  ThemeData? theme,
}) async {
  final gateway = _FakeCheckoutGateway();
  final navigatorKey = GlobalKey<NavigatorState>();
  Localingo.setNavigatorKey(navigatorKey);
  tester.view.devicePixelRatio = 1;
  tester.view.physicalSize = const Size(390, 844);
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
        body: BlocProvider(
          create: (_) => CourseCheckoutCubit(gateway),
          child: SubscribtionViewBody(
            requirmentsEntity:
                DisplayCourseBottomsheetNavigationRequirmentsEntity(
              course: _course(),
              isSubscribed: false,
              hasSubscriptionCheckResult: false,
            ),
          ),
        ),
      ),
    ),
  );
  await tester.pumpAndSettle();
  return gateway;
}

void _resetView(WidgetTester tester) {
  tester.view.resetPhysicalSize();
  tester.view.resetDevicePixelRatio();
}

String _textOf(WidgetTester tester, String key) =>
    tester.widget<Text>(find.byKey(ValueKey(key))).data!;

Future<void> _applyCoupon(WidgetTester tester, String code) async {
  await tester.tap(find.byKey(const ValueKey('checkout-add-coupon')));
  await tester.pumpAndSettle();
  await tester.enterText(
    find.byKey(const ValueKey('checkout-coupon-field')),
    code,
  );
  await tester.tap(find.byKey(const ValueKey('checkout-apply-coupon')));
  await tester.pumpAndSettle();
}

void main() {
  testWidgets('starts with the coupon collapsed and only the total', (
    tester,
  ) async {
    await _pumpCheckout(tester);
    expect(find.byKey(const ValueKey('checkout-add-coupon')), findsOneWidget);
    expect(find.byKey(const ValueKey('checkout-coupon-field')), findsNothing);
    expect(
      find.byKey(const ValueKey('checkout-price-breakdown')),
      findsNothing,
    );
    expect(_textOf(tester, 'checkout-total'), '200 EGP');
    expect(
      find.byKey(const ValueKey('checkout-original-total')),
      findsNothing,
    );
    expect(find.text('Secure payment via Paymob'), findsOneWidget);
    expect(find.text('24 lessons'), findsOneWidget);
    expect(find.text('6 tests'), findsOneWidget);
    expect(find.text('3rd Grade Secondary'), findsOneWidget);
    expect(find.text('Arabic'), findsOneWidget);
    expect(tester.takeException(), isNull);
    _resetView(tester);
  });

  testWidgets('an empty coupon shows an inline error and calls nothing', (
    tester,
  ) async {
    final gateway = await _pumpCheckout(tester);
    await _applyCoupon(tester, '   ');
    expect(find.byKey(const ValueKey('checkout-coupon-error')), findsOneWidget);
    expect(gateway.lastQuoteCoupon, isNull);
    _resetView(tester);
  });

  testWidgets('applying a coupon shows the breakdown and can be removed', (
    tester,
  ) async {
    final gateway = await _pumpCheckout(tester);
    await _applyCoupon(tester, 'SINTIR20');

    expect(gateway.lastQuoteCoupon, 'SINTIR20');
    expect(
      find.byKey(const ValueKey('checkout-price-breakdown')),
      findsOneWidget,
    );
    expect(_textOf(tester, 'checkout-total'), '160 EGP');
    expect(_textOf(tester, 'checkout-original-total'), '200 EGP');
    expect(
      _textOf(tester, 'checkout-coupon-success'),
      contains('20%'),
    );
    expect(find.byKey(const ValueKey('checkout-remove-coupon')), findsOneWidget);

    await tester.tap(find.byKey(const ValueKey('checkout-remove-coupon')));
    await tester.pumpAndSettle();
    expect(
      find.byKey(const ValueKey('checkout-price-breakdown')),
      findsNothing,
    );
    expect(_textOf(tester, 'checkout-total'), '200 EGP');
    final field = tester.widget<TextField>(
      find.byKey(const ValueKey('checkout-coupon-field')),
    );
    expect(field.controller!.text, isEmpty);
    _resetView(tester);
  });

  testWidgets('a rejected coupon shows the server message under the field', (
    tester,
  ) async {
    final gateway = await _pumpCheckout(tester);
    gateway.quoteError = Exception('Invalid coupon');
    await _applyCoupon(tester, 'WRONG');

    expect(_textOf(tester, 'checkout-coupon-error'), 'Invalid coupon');
    expect(
      find.byKey(const ValueKey('checkout-price-breakdown')),
      findsNothing,
    );
    expect(_textOf(tester, 'checkout-total'), '200 EGP');
    _resetView(tester);
  });

  testWidgets('subscribe sends the applied coupon and shows progress', (
    tester,
  ) async {
    final gateway = await _pumpCheckout(tester);
    await _applyCoupon(tester, 'SINTIR20');

    final button = find.byKey(const ValueKey('checkout-subscribe-button'));
    await tester.tap(button);
    await tester.pump();

    expect(gateway.createCalls, 1);
    expect(gateway.lastCreateCoupon, 'SINTIR20');
    expect(
      find.descendant(
        of: button,
        matching: find.byType(CircularProgressIndicator),
      ),
      findsOneWidget,
    );
    expect(tester.widget<FilledButton>(button).onPressed, isNull);
    _resetView(tester);
  });

  testWidgets('Arabic checkout localizes level, language and price', (
    tester,
  ) async {
    for (final theme in [AppTheme.light, AppTheme.dark]) {
      await _pumpCheckout(tester, locale: const Locale('ar'), theme: theme);
      expect(find.text('الصف الثالث الثانوي'), findsOneWidget);
      expect(find.text('العربية'), findsOneWidget);
      expect(find.text('الكيمياء'), findsOneWidget);
      expect(find.text('24 درسًا'), findsOneWidget);
      expect(_textOf(tester, 'checkout-total'), '200 ج.م');
      expect(find.text('إضافة كوبون خصم'), findsOneWidget);
      expect(tester.takeException(), isNull);
    }
    _resetView(tester);
  });
}
