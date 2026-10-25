// ignore_for_file: file_names

import 'dart:async';
import 'dart:convert';
import 'dart:developer' as developer;
import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:sintir/Core/repos/CourseCheckoutRepo.dart';
import 'package:sintir/Core/repos/CourseCheckoutRequestException.dart';
import 'package:sintir/Features/Subscribtion/Domain/Entities/CourseCheckoutEntity.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class CourseCheckoutFunctionResponse {
  const CourseCheckoutFunctionResponse({
    required this.status,
    required this.data,
    this.reasonPhrase,
  });

  final int status;
  final Object? data;
  final String? reasonPhrase;
}

typedef CourseCheckoutTokenProvider = Future<String?> Function();
typedef CourseCheckoutFunctionInvoker = Future<CourseCheckoutFunctionResponse>
    Function(String name, Map<String, dynamic> body, String token);

class CourseCheckoutRepoImpl implements CourseCheckoutGateway {
  CourseCheckoutRepoImpl({
    SupabaseClient? client,
    FirebaseAuth? auth,
    CourseCheckoutTokenProvider? tokenProvider,
    CourseCheckoutFunctionInvoker? functionInvoker,
  })  : _client = client,
        _auth = auth,
        _tokenProvider = tokenProvider,
        _functionInvoker = functionInvoker;

  final SupabaseClient? _client;
  final FirebaseAuth? _auth;
  final CourseCheckoutTokenProvider? _tokenProvider;
  final CourseCheckoutFunctionInvoker? _functionInvoker;

  Future<String?> _getToken() async {
    final tokenProvider = _tokenProvider;
    if (tokenProvider != null) return tokenProvider();
    final user = (_auth ?? FirebaseAuth.instance).currentUser;
    return user?.getIdToken();
  }

  Future<CourseCheckoutFunctionResponse> _callFunction(
    String name,
    Map<String, dynamic> body,
    String token,
  ) async {
    final injectedInvoker = _functionInvoker;
    if (injectedInvoker != null) return injectedInvoker(name, body, token);

    try {
      final response = await (_client ?? Supabase.instance.client)
          .functions
          .invoke(name,
              headers: {'Authorization': 'Bearer $token'}, body: body);
      return CourseCheckoutFunctionResponse(
          status: response.status, data: response.data);
    } on FunctionException catch (exception) {
      return CourseCheckoutFunctionResponse(
        status: exception.status,
        data: exception.details,
        reasonPhrase: exception.reasonPhrase,
      );
    }
  }

  Future<Map<String, dynamic>> _invoke(
    String function,
    Map<String, dynamic> body,
  ) async {
    final String? token;
    try {
      token = await _getToken();
    } on FirebaseAuthException {
      throw const CourseCheckoutRequestException(
          'authentication_failed', 'Please sign in to continue.', 401);
    } on Object {
      throw const CourseCheckoutRequestException(
          'authentication_failed', 'Please sign in to continue.', 401);
    }
    if (token == null || token.isEmpty) {
      throw const CourseCheckoutRequestException(
          'authentication_required', 'Please sign in to continue.', 401);
    }

    final CourseCheckoutFunctionResponse response;
    try {
      response = await _callFunction(function, body, token);
    } on FunctionException catch (exception) {
      throw _functionException(exception);
    } on SocketException {
      throw const CourseCheckoutRequestException('network_error',
          'Network error. Check your connection and retry.', 503);
    } on TimeoutException {
      throw const CourseCheckoutRequestException(
          'network_timeout', 'The request timed out. Please retry.', 503);
    } on CourseCheckoutRequestException {
      rethrow;
    } on Object {
      throw const CourseCheckoutRequestException('request_failed',
          'Checkout could not be completed. Please retry.', 502);
    }

    if (response.status < 200 || response.status >= 300) {
      throw _responseException(
          response.data, response.status, response.reasonPhrase);
    }
    if (response.data is! Map) {
      throw const CourseCheckoutRequestException(
          'invalid_response', 'The server returned an invalid response.', 502);
    }
    final data = Map<String, dynamic>.from(response.data as Map);
    if (data['ok'] != true) {
      throw _responseException(data, response.status, response.reasonPhrase);
    }
    return data;
  }

  CourseCheckoutRequestException _functionException(
          FunctionException exception) =>
      _responseException(
          exception.details, exception.status, exception.reasonPhrase);

  CourseCheckoutRequestException _responseException(
      Object? payload, int status, String? reasonPhrase) {
    Object? decoded = payload;
    if (decoded is String) {
      try {
        decoded = jsonDecode(decoded);
      } on FormatException {
        decoded = null;
      }
    }
    final error = decoded is Map ? decoded['error'] : null;
    final code = error is Map ? error['code'] : null;
    final message = error is Map ? error['message'] : null;
    final rawRequestId = error is Map ? error['requestId'] : null;
    final requestId = rawRequestId is String &&
            RegExp(r'^[A-Za-z0-9_-]{8,100}$').hasMatch(rawRequestId)
        ? rawRequestId
        : null;
    final safeStatus = status == 0
        ? 0
        : status >= 100 && status <= 599
            ? status
            : 502;
    final safeCode = code is String
        ? code
        : (safeStatus == 0 ? 'network_error' : 'checkout_request_failed');
    if (safeStatus >= 500) {
      final diagnostic = <String>[
        'code=$safeCode',
        'status=$safeStatus',
        if (requestId != null) 'requestId=$requestId',
      ].join(' ');
      developer.log(
        'Checkout function failure: $diagnostic',
        name: 'course_checkout',
      );
    }
    return CourseCheckoutRequestException(
      safeCode,
      message is String && message.isNotEmpty
          ? message
          : safeStatus == 401
              ? 'Please sign in to continue.'
              : safeStatus == 0 || safeStatus >= 500
                  ? 'The service is temporarily unavailable. Please retry.'
                  : reasonPhrase ?? 'Checkout request failed.',
      safeStatus,
      requestId: requestId,
    );
  }

  T _parse<T>(T Function() parse) {
    try {
      return parse();
    } on CourseCheckoutRequestException {
      rethrow;
    } on Object {
      throw const CourseCheckoutRequestException(
          'invalid_response', 'The server returned an invalid response.', 502);
    }
  }

  Map<String, dynamic> _mapField(Map<String, dynamic> data, String field) =>
      _parse(() {
        final value = data[field];
        if (value is! Map) throw const FormatException('Invalid response map.');
        return Map<String, dynamic>.from(value);
      });

  @override
  Future<CourseCheckoutQuote> quote(
      {required String courseId, String? couponCode}) async {
    final data = await _invoke('course-checkout-quote', {
      'courseId': courseId,
      if (couponCode != null && couponCode.trim().isNotEmpty)
        'couponCode': couponCode.trim(),
    });
    return _parse(() => CourseCheckoutQuote.fromJson(_mapField(data, 'quote')));
  }

  @override
  Future<CoursePaymentAttempt> createPayment(
      {required String courseId,
      required String idempotencyKey,
      String? couponCode}) async {
    final data = await _invoke('create-course-payment', {
      'courseId': courseId,
      'idempotencyKey': idempotencyKey,
      if (couponCode != null && couponCode.trim().isNotEmpty)
        'couponCode': couponCode.trim(),
    });
    return _parse(() => CoursePaymentAttempt.fromJson(data));
  }

  @override
  Future<String> paymentStatus(String paymentAttemptId) async {
    final data = await _invoke('get-course-payment-status', {
      'paymentAttemptId': paymentAttemptId,
    });
    return _parse(() {
      final status = data['status'];
      if (status is! String || status.isEmpty) {
        throw const FormatException('Missing payment status.');
      }
      return status;
    });
  }

  @override
  Future<bool> isSubscribed(String courseId) async {
    final data =
        await _invoke('check-course-subscription', {'courseId': courseId});
    return _parse(() {
      final isSubscribed = data['isSubscribed'];
      if (isSubscribed is! bool) {
        throw const FormatException('Missing subscription result.');
      }
      return isSubscribed;
    });
  }
}
