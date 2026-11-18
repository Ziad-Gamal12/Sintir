import 'dart:async';
import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:sintir/Core/services/EdgeFunctionsService.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

EdgeFunctionsService _service({
  required EdgeFunctionInvoker invoker,
  EdgeFunctionTokenProvider? tokenProvider,
  Duration timeout = const Duration(seconds: 20),
}) {
  return EdgeFunctionsService(
    tokenProvider: tokenProvider ?? () async => 'firebase-id-token',
    invoker: invoker,
    timeout: timeout,
  );
}

Future<EdgeFunctionException> _failureOf(Future<Object?> call) async {
  try {
    await call;
  } on EdgeFunctionException catch (exception) {
    return exception;
  }
  fail('Expected an EdgeFunctionException.');
}

void main() {
  test('sends the Firebase ID token and returns the ok body', () async {
    String? sentName;
    String? sentToken;
    Map<String, dynamic>? sentBody;
    final service = _service(
      invoker: (name, body, token) async {
        sentName = name;
        sentBody = body;
        sentToken = token;
        return const EdgeFunctionResponse(
          status: 200,
          data: {'ok': true, 'created': true},
        );
      },
    );

    final result = await service.invoke('upsert-course-feedback', {
      'courseId': 'course-1',
    });

    expect(result['created'], isTrue);
    expect(sentName, 'upsert-course-feedback');
    expect(sentToken, 'firebase-id-token');
    expect(sentBody, {'courseId': 'course-1'});
  });

  test('error envelopes keep their code and status', () async {
    final service = _service(
      invoker: (name, body, token) async => const EdgeFunctionResponse(
        status: 403,
        data: {
          'ok': false,
          'error': {'code': 'not_subscribed', 'message': 'Subscribe first.'},
        },
      ),
    );
    final failure = await _failureOf(service.invoke('f', {}));
    expect(failure.code, 'not_subscribed');
    expect(failure.statusCode, 403);
    expect(failure.message, 'Subscribe first.');
  });

  test('FunctionException details are read as JSON text or a map', () async {
    for (final details in <Object>[
      '{"ok":false,"error":{"code":"too_many_requests","message":"Wait."}}',
      {
        'ok': false,
        'error': {'code': 'too_many_requests', 'message': 'Wait.'},
      },
    ]) {
      final service = _service(
        invoker: (name, body, token) async =>
            throw FunctionException(status: 429, details: details),
      );
      final failure = await _failureOf(service.invoke('f', {}));
      expect(failure.code, 'too_many_requests');
      expect(failure.statusCode, 429);
    }
  });

  test('an unreadable error body still gives a usable code', () async {
    final service = _service(
      invoker: (name, body, token) async => throw FunctionException(
        status: 502,
        details: '<html>Bad gateway</html>',
        reasonPhrase: 'Bad Gateway',
      ),
    );
    final failure = await _failureOf(service.invoke('f', {}));
    expect(failure.code, 'request_failed');
    expect(failure.message, 'Bad Gateway');
  });

  test('without a signed-in user the function is never called', () async {
    var calls = 0;
    Future<EdgeFunctionResponse> invoker(
      String name,
      Map<String, dynamic> body,
      String token,
    ) async {
      calls++;
      return const EdgeFunctionResponse(status: 200, data: {'ok': true});
    }

    for (final provider in <EdgeFunctionTokenProvider>[
      () async => null,
      () async => '',
      () async => throw StateError('token refresh failed'),
    ]) {
      final failure = await _failureOf(
        _service(invoker: invoker, tokenProvider: provider).invoke('f', {}),
      );
      expect(failure.code, 'authentication_required');
      expect(failure.statusCode, 401);
    }
    expect(calls, 0);
  });

  test('network errors and timeouts have their own codes', () async {
    final offline = _service(
      invoker: (name, body, token) async =>
          throw const SocketException('Network is unreachable'),
    );
    expect((await _failureOf(offline.invoke('f', {}))).code, 'network_error');

    final never = Completer<EdgeFunctionResponse>();
    final slow = _service(
      invoker: (name, body, token) => never.future,
      timeout: const Duration(milliseconds: 20),
    );
    expect((await _failureOf(slow.invoke('f', {}))).code, 'network_timeout');
  });

  test('a 2xx answer that is not { ok: true } is treated as an error', () async {
    final notJson = _service(
      invoker: (name, body, token) async =>
          const EdgeFunctionResponse(status: 200, data: 'oops'),
    );
    expect(
      (await _failureOf(notJson.invoke('f', {}))).code,
      'invalid_response',
    );

    final notOk = _service(
      invoker: (name, body, token) async =>
          const EdgeFunctionResponse(status: 200, data: {'ok': false}),
    );
    expect((await _failureOf(notOk.invoke('f', {}))).code, 'request_failed');
  });
}
