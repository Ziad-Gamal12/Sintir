import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:sintir/Core/Managers/Cubits/course_checkout_cubit/course_checkout_cubit.dart';
import 'package:sintir/Core/repos/CourseCheckoutRepoImpl.dart';
import 'package:sintir/Core/repos/CourseCheckoutRequestException.dart';
import 'package:sintir/Core/repos/CourseCheckoutRepo.dart';
import 'package:sintir/Core/repos/CourseSubscibtionsRepo/CourseSubscibtionsRepo.dart';
import 'package:sintir/Core/repos/CourseSubscibtionsRepo/CourseSubscibtionsRepo_impli.dart';
import 'package:sintir/Core/services/DataBaseService.dart';
import 'package:sintir/Core/services/get_it_Service.dart';
import 'package:sintir/Features/Subscribtion/Domain/Entities/CourseCheckoutEntity.dart';

class _UnusedDatabaseService implements DataBaseService {
  @override
  dynamic noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}

const _quote = <String, dynamic>{
  'originalAmountCents': 10000,
  'discountAmountCents': 1000,
  'amountCents': 9000,
  'currency': 'EGP',
  'couponCode': 'SAVE',
  'discountPercentage': 10,
};

CourseCheckoutRepoImpl _repository({
  required CourseCheckoutFunctionInvoker invoker,
  Future<String?> Function()? tokenProvider,
}) =>
    CourseCheckoutRepoImpl(
      tokenProvider: tokenProvider ?? () async => 'firebase-token',
      functionInvoker: invoker,
    );

void main() {
  test('isSubscribed preserves the exact Arabic-Indic course ID', () async {
    const courseId = '٤٥٢٧٣٥٤٦';
    Map<String, dynamic>? sentBody;
    final repo = _repository(invoker: (name, body, token) async {
      expect(name, 'check-course-subscription');
      expect(token, 'firebase-token');
      sentBody = body;
      return const CourseCheckoutFunctionResponse(
        status: 200,
        data: {'ok': true, 'isSubscribed': true},
      );
    });

    expect(await repo.isSubscribed(courseId), isTrue);
    expect(sentBody?['courseId'], courseId);
  });

  test('successful false subscription response remains a valid false',
      () async {
    final repo = _repository(
        invoker: (_, __, ___) async => const CourseCheckoutFunctionResponse(
              status: 200,
              data: {'ok': true, 'isSubscribed': false},
            ));

    expect(await repo.isSubscribed('45273546'), isFalse);
  });

  test('missing or malformed subscription result throws typed invalid response',
      () async {
    final repo = _repository(
        invoker: (_, __, ___) async => const CourseCheckoutFunctionResponse(
              status: 200,
              data: {'ok': true, 'isSubscribed': 'false'},
            ));

    await expectLater(
      repo.isSubscribed('course-id'),
      throwsA(isA<CourseCheckoutRequestException>().having(
        (error) => error.code,
        'code',
        'invalid_response',
      )),
    );
  });

  test(
      'non-2xx structured function errors preserve status, code, and safe message',
      () async {
    final repo = _repository(
        invoker: (_, __, ___) async => const CourseCheckoutFunctionResponse(
              status: 400,
              data: {
                'ok': false,
                'error': {
                  'code': 'invalid_course_id',
                  'message': 'Course ID is invalid.',
                  'requestId': 'a0d17c03-13d0-4d60-9882-b7998c21d2e4',
                },
              },
            ));

    await expectLater(
      repo.quote(courseId: '٤٥٢٧٣٥٤٦'),
      throwsA(isA<CourseCheckoutRequestException>()
          .having((error) => error.statusCode, 'status', 400)
          .having((error) => error.code, 'code', 'invalid_course_id')
          .having((error) => error.message, 'message', 'Course ID is invalid.')
          .having((error) => error.requestId, 'request ID',
              'a0d17c03-13d0-4d60-9882-b7998c21d2e4')),
    );
  });

  test('internal server errors preserve safe correlation ID diagnostics',
      () async {
    final repo = _repository(
        invoker: (_, __, ___) async => const CourseCheckoutFunctionResponse(
              status: 500,
              data: {
                'ok': false,
                'error': {
                  'code': 'internal_error',
                  'message': 'Checkout could not be completed.',
                  'requestId': 'a0d17c03-13d0-4d60-9882-b7998c21d2e4',
                },
              },
            ));

    await expectLater(
      repo.quote(courseId: 'course-id'),
      throwsA(isA<CourseCheckoutRequestException>()
          .having((error) => error.statusCode, 'status', 500)
          .having((error) => error.code, 'code', 'internal_error')
          .having((error) => error.requestId, 'request ID',
              'a0d17c03-13d0-4d60-9882-b7998c21d2e4')
          .having((error) => error.message, 'safe message',
              'Checkout could not be completed.')),
    );
  });

  test('authentication and network errors remain distinguishable', () async {
    final unauthenticated = _repository(
      tokenProvider: () async => null,
      invoker: (_, __, ___) async => throw StateError('must not be invoked'),
    );
    await expectLater(
      unauthenticated.isSubscribed('course'),
      throwsA(isA<CourseCheckoutRequestException>()
          .having((error) => error.code, 'code', 'authentication_required')),
    );

    final offline = _repository(
      invoker: (_, __, ___) async =>
          throw const SocketException('private transport detail'),
    );
    await expectLater(
      offline.isSubscribed('course'),
      throwsA(isA<CourseCheckoutRequestException>()
          .having((error) => error.code, 'code', 'network_error')
          .having((error) => error.message.contains('private transport detail'),
              'leaks raw detail', isFalse)),
    );
  });

  test('quote, payment creation, and status response contracts remain intact',
      () async {
    final repo = _repository(invoker: (name, body, _) async {
      switch (name) {
        case 'course-checkout-quote':
          expect(body['courseId'], '٤٥٢٧٣٥٤٦');
          expect(body['couponCode'], 'SAVE');
          return CourseCheckoutFunctionResponse(
              status: 200, data: {'ok': true, 'quote': _quote});
        case 'create-course-payment':
          expect(body['courseId'], '٤٥٢٧٣٥٤٦');
          expect(body['idempotencyKey'], 'attempt-key');
          expect(body['couponCode'], 'SAVE');
          return CourseCheckoutFunctionResponse(status: 200, data: {
            'ok': true,
            'paymentAttemptId': 'attempt-1',
            'checkoutUrl': 'https://checkout.example',
            'status': 'pending',
            'quote': _quote,
            'resumedExisting': true,
            'requiresConfirmation': true,
            'requestDiffers': true,
          });
        case 'get-course-payment-status':
          return const CourseCheckoutFunctionResponse(status: 200, data: {
            'ok': true,
            'status': 'verification_required',
            'verificationState': 'cooldown',
            'retryAfterSeconds': 19,
            'canRetry': true,
            'checkoutUrl': 'https://checkout.example/original',
            'canResume': true,
          });
        default:
          throw StateError('Unexpected Edge Function: $name');
      }
    });

    final quote = await repo.quote(courseId: '٤٥٢٧٣٥٤٦', couponCode: ' SAVE ');
    final attempt = await repo.createPayment(
        courseId: '٤٥٢٧٣٥٤٦',
        idempotencyKey: 'attempt-key',
        couponCode: 'SAVE');
    final status = await repo.paymentStatus('attempt-1');

    expect(quote.amountCents, 9000);
    expect(attempt.id, 'attempt-1');
    expect(attempt.checkoutUrl, 'https://checkout.example');
    expect(attempt.resumedExisting, isTrue);
    expect(attempt.requiresConfirmation, isTrue);
    expect(attempt.requestDiffers, isTrue);
    expect(status.status, 'verification_required');
    expect(status.verificationState, 'cooldown');
    expect(status.retryAfterSeconds, 19);
    expect(status.canRetry, isTrue);
    expect(status.checkoutUrl, 'https://checkout.example/original');
    expect(status.canResume, isTrue);
  });

  test('status response with no cooldown metadata remains backward compatible',
      () async {
    final repo = _repository(
      invoker: (_, __, ___) async => const CourseCheckoutFunctionResponse(
        status: 200,
        data: {'ok': true, 'status': 'succeeded'},
      ),
    );

    final status = await repo.paymentStatus('attempt-1');
    expect(status.status, 'succeeded');
    expect(status.verificationState, 'unknown');
    expect(status.retryAfterSeconds, 0);
    expect(status.canRetry, isTrue);
    expect(status.checkoutUrl, isEmpty);
    expect(status.canResume, isFalse);
  });

  test('parses the reported pending no-resume response and honors its cooldown',
      () async {
    final repo = _repository(
      invoker: (_, __, ___) async => const CourseCheckoutFunctionResponse(
        status: 200,
        data: {
          'ok': true,
          'paymentAttemptId': 'attempt-1',
          'status': 'pending',
          'verificationState': 'inquiry_complete',
          'retryAfterSeconds': 29,
          'canRetry': true,
          'canResume': false,
          'amountCents': 17000,
          'currency': 'EGP',
          'checkoutUrl':
              'https://checkout.example/original?clientSecret=redacted',
          'quote': {
            'couponCode': null,
            'currency': 'EGP',
            'discountAmountCents': 0,
            'amountCents': 17000,
            'originalAmountCents': 17000,
            'discountPercentage': 0,
          },
        },
      ),
    );

    final status = await repo.paymentStatus('attempt-1');
    expect(status.status, 'pending');
    expect(status.verificationState, 'inquiry_complete');
    expect(status.retryAfterSeconds, 29);
    expect(status.canRetry, isTrue);
    expect(status.canResume, isFalse);
    expect(status.checkoutUrl, contains('clientSecret=redacted'));
  });

  test('status parser rejects invalid retry timing', () {
    expect(
      () => CoursePaymentStatusResult.fromJson({
        'status': 'pending',
        'retryAfterSeconds': -1,
      }),
      throwsFormatException,
    );
    expect(
      () => CoursePaymentStatusResult.fromJson({
        'status': 'pending',
        'retryAfterSeconds': 0.5,
      }),
      throwsFormatException,
    );
  });

  test(
      'service locator constructs the checkout gateway and Cubit through its contract',
      () async {
    setup_Getit();
    getIt.unregister<DataBaseService>();
    getIt.registerSingleton<DataBaseService>(_UnusedDatabaseService());
    final gateway = getIt<CourseCheckoutGateway>();
    expect(gateway, isA<CourseCheckoutRepoImpl>());
    expect(getIt<CourseSubscibtionsRepo>(), isA<CourseSubscriptionsRepoImpl>());
    final cubit = CourseCheckoutCubit(gateway);
    expect(cubit.state, isA<CourseCheckoutInitial>());
    await cubit.close();
  });
}
