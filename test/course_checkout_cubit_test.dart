import 'dart:async';

import 'package:flutter_test/flutter_test.dart';
import 'package:sintir/Core/Managers/Cubits/course_checkout_cubit/course_checkout_cubit.dart';
import 'package:sintir/Core/repos/CourseCheckoutRepo.dart';
import 'package:sintir/Features/Subscribtion/Domain/Entities/CourseCheckoutEntity.dart';
import 'package:sintir/Core/repos/CourseCheckoutRequestException.dart';
import 'package:sintir/locale_keys.dart';

class _FakeCheckoutGateway implements CourseCheckoutGateway {
  int createCalls = 0;
  Completer<CoursePaymentAttempt>? createCompleter;
  Object? createError;
  Object? quoteError;
  String nextStatus = 'pending';

  @override
  Future<CourseCheckoutQuote> quote(
      {required String courseId, String? couponCode}) async {
    if (quoteError != null) throw quoteError!;
    return CourseCheckoutQuote(
      originalAmountCents: 10000,
      discountAmountCents: couponCode == null ? 0 : 1000,
      amountCents: couponCode == null ? 10000 : 9000,
      currency: 'EGP',
      couponCode: couponCode,
      discountPercentage: couponCode == null ? 0 : 10,
    );
  }

  @override
  Future<CoursePaymentAttempt> createPayment(
      {required String courseId,
      required String idempotencyKey,
      String? couponCode}) {
    createCalls++;
    if (createError != null) {
      return Future<CoursePaymentAttempt>.error(createError!);
    }
    return createCompleter!.future;
  }

  @override
  Future<String> paymentStatus(String paymentAttemptId) async => nextStatus;

  @override
  Future<bool> isSubscribed(String courseId) async => false;
}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  test('quote loads authoritative amounts and reports quote errors', () async {
    final gateway = _FakeCheckoutGateway();
    final cubit = CourseCheckoutCubit(gateway);
    final quote = await cubit.quote('course', couponCode: 'SAVE');
    expect(quote?.amountCents, 9000);
    expect(cubit.state, isA<CourseCheckoutQuoteReady>());

    gateway.quoteError = StateError('coupon expired');
    await cubit.quote('course', couponCode: 'SAVE');
    expect(cubit.state, isA<CourseCheckoutFailure>());
    await cubit.close();
  });

  test('duplicate create taps share one in-flight checkout request', () async {
    final gateway = _FakeCheckoutGateway()
      ..createCompleter = Completer<CoursePaymentAttempt>();
    final cubit = CourseCheckoutCubit(gateway);
    final first = cubit.createPayment('course');
    final second = cubit.createPayment('course');
    expect(gateway.createCalls, 1);
    gateway.createCompleter!.complete(const CoursePaymentAttempt(
      id: 'attempt',
      checkoutUrl: 'https://checkout.example',
      status: 'pending',
      quote: CourseCheckoutQuote(
          originalAmountCents: 10000,
          discountAmountCents: 0,
          amountCents: 10000,
          currency: 'EGP'),
    ));
    await Future.wait([first, second]);
    expect(cubit.state, isA<CourseCheckoutCreated>());
    await cubit.close();
  });

  test('payment status is only represented by the backend response', () async {
    final gateway = _FakeCheckoutGateway();
    final cubit = CourseCheckoutCubit(gateway);
    expect(await cubit.refreshStatus('attempt'), 'pending');
    expect((cubit.state as CourseCheckoutStatus).status, 'pending');
    gateway.nextStatus = 'succeeded';
    expect(await cubit.refreshStatus('attempt'), 'succeeded');
    expect((cubit.state as CourseCheckoutStatus).status, 'succeeded');
    await cubit.close();
  });

  test(
      'a resumed attempt preserves its original ID, URL, and confirmation state',
      () async {
    final gateway = _FakeCheckoutGateway()
      ..createCompleter = Completer<CoursePaymentAttempt>();
    final cubit = CourseCheckoutCubit(gateway);
    final request = cubit.createPayment('course', couponCode: 'NEW');
    const originalQuote = CourseCheckoutQuote(
      originalAmountCents: 10000,
      discountAmountCents: 2000,
      amountCents: 8000,
      currency: 'EGP',
      couponCode: 'OLD',
      discountPercentage: 20,
    );
    gateway.createCompleter!.complete(const CoursePaymentAttempt(
      id: 'original-attempt',
      checkoutUrl: 'https://checkout.example/original',
      status: 'pending',
      quote: originalQuote,
      resumedExisting: true,
      requiresConfirmation: true,
      requestDiffers: true,
    ));
    await request;
    final attempt = (cubit.state as CourseCheckoutCreated).attempt;
    expect(attempt.id, 'original-attempt');
    expect(attempt.checkoutUrl, 'https://checkout.example/original');
    expect(attempt.quote.couponCode, 'OLD');
    expect(attempt.quote.amountCents, 8000);
    expect(attempt.requiresConfirmation, isTrue);
    expect(attempt.requestDiffers, isTrue);
    await cubit.close();
  });

  test('an unresolved payment status stays recoverable, not failed', () async {
    final gateway = _FakeCheckoutGateway()
      ..nextStatus = 'verification_required';
    final cubit = CourseCheckoutCubit(gateway);
    expect(await cubit.refreshStatus('attempt'), 'verification_required');
    expect(
        (cubit.state as CourseCheckoutStatus).status, 'verification_required');
    await cubit.close();
  });

  test('ambiguous and review errors map to localized recovery messages',
      () async {
    final gateway = _FakeCheckoutGateway()
      ..createError = const CourseCheckoutRequestException(
        'checkout_status_unknown',
        'server english fallback',
        409,
      );
    final cubit = CourseCheckoutCubit(gateway);
    await cubit.createPayment('course');
    expect((cubit.state as CourseCheckoutFailure).message,
        LocaleKeys.paymentVerifying);

    gateway.createError = const CourseCheckoutRequestException(
      'paid_requires_review',
      'server english fallback',
      409,
    );
    await cubit.createPayment('course');
    expect((cubit.state as CourseCheckoutFailure).message,
        LocaleKeys.paymentRequiresReview);
    await cubit.close();
  });
}
