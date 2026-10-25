import 'dart:async';

import 'package:flutter_test/flutter_test.dart';
import 'package:sintir/Core/Managers/Cubits/course_checkout_cubit/course_checkout_cubit.dart';
import 'package:sintir/Core/repos/CourseCheckoutRepo.dart';
import 'package:sintir/Features/Subscribtion/Domain/Entities/CourseCheckoutEntity.dart';

class _FakeCheckoutGateway implements CourseCheckoutGateway {
  int createCalls = 0;
  Completer<CoursePaymentAttempt>? createCompleter;
  Object? quoteError;
  String nextStatus = 'pending';

  @override
  Future<CourseCheckoutQuote> quote({required String courseId, String? couponCode}) async {
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
  Future<CoursePaymentAttempt> createPayment({required String courseId, required String idempotencyKey, String? couponCode}) {
    createCalls++;
    return createCompleter!.future;
  }

  @override
  Future<String> paymentStatus(String paymentAttemptId) async => nextStatus;

  @override
  Future<bool> isSubscribed(String courseId) async => false;
}

void main() {
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
    final gateway = _FakeCheckoutGateway()..createCompleter = Completer<CoursePaymentAttempt>();
    final cubit = CourseCheckoutCubit(gateway);
    final first = cubit.createPayment('course');
    final second = cubit.createPayment('course');
    expect(gateway.createCalls, 1);
    gateway.createCompleter!.complete(const CoursePaymentAttempt(
      id: 'attempt', checkoutUrl: 'https://checkout.example', status: 'pending',
      quote: CourseCheckoutQuote(originalAmountCents: 10000, discountAmountCents: 0, amountCents: 10000, currency: 'EGP'),
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
}
