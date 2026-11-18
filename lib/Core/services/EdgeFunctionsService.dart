// ignore_for_file: file_names

import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:sintir/Core/services/NetworkStatus.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

/// Raw result of one Edge Function call, before the `{ ok, ... }` envelope is
/// checked.
class EdgeFunctionResponse {
  const EdgeFunctionResponse({
    required this.status,
    required this.data,
    this.reasonPhrase,
  });

  final int status;
  final Object? data;
  final String? reasonPhrase;
}

typedef EdgeFunctionTokenProvider = Future<String?> Function();
typedef EdgeFunctionInvoker =
    Future<EdgeFunctionResponse> Function(
      String name,
      Map<String, dynamic> body,
      String token,
    );

/// Failure returned by an Edge Function (`{ ok: false, error: { code } }`) or
/// raised while calling it. [code] is stable: branch on it, not on [message].
class EdgeFunctionException implements Exception {
  const EdgeFunctionException(this.code, this.message, this.statusCode);

  final String code;
  final String message;

  /// HTTP status, or 0 when the request never reached the function.
  final int statusCode;

  @override
  String toString() => 'EdgeFunctionException(code=$code status=$statusCode)';
}

/// Calls Supabase Edge Functions with the signed-in user's Firebase ID token,
/// the same contract the checkout functions use: each function verifies the
/// token itself (gateway JWT verification is disabled for them).
class EdgeFunctionsService {
  EdgeFunctionsService({
    SupabaseClient? client,
    FirebaseAuth? auth,
    EdgeFunctionTokenProvider? tokenProvider,
    EdgeFunctionInvoker? invoker,
    NetworkStatus? network,
    this.timeout = const Duration(seconds: 20),
  }) : _client = client,
       _auth = auth,
       _tokenProvider = tokenProvider,
       _invoker = invoker,
       _network = network;

  final SupabaseClient? _client;
  final FirebaseAuth? _auth;
  final EdgeFunctionTokenProvider? _tokenProvider;
  final EdgeFunctionInvoker? _invoker;
  final NetworkStatus? _network;
  final Duration timeout;

  static bool isNetworkError(EdgeFunctionException error) =>
      error.code == 'network_error' || error.code == 'network_timeout';

  /// Returns the response body when the function answered `{ ok: true }`;
  /// throws [EdgeFunctionException] otherwise.
  Future<Map<String, dynamic>> invoke(
    String function,
    Map<String, dynamic> body,
  ) async {
    if (!(_network ?? NetworkStatus.current).isOnline) {
      throw const EdgeFunctionException(
        'network_error',
        'No internet connection.',
        0,
      );
    }
    final token = await _idToken();

    final EdgeFunctionResponse response;
    try {
      response = await _call(function, body, token).timeout(timeout);
    } on EdgeFunctionException {
      rethrow;
    } on FunctionException catch (exception) {
      throw _errorFrom(
        exception.details,
        exception.status,
        exception.reasonPhrase,
      );
    } on SocketException {
      throw const EdgeFunctionException('network_error', 'Network error.', 0);
    } on TimeoutException {
      throw const EdgeFunctionException(
        'network_timeout',
        'The request timed out.',
        0,
      );
    } on Object {
      throw const EdgeFunctionException(
        'request_failed',
        'The request failed.',
        0,
      );
    }

    if (response.status < 200 || response.status >= 300) {
      throw _errorFrom(response.data, response.status, response.reasonPhrase);
    }
    final data = response.data;
    if (data is! Map) {
      throw EdgeFunctionException(
        'invalid_response',
        'The server returned an invalid response.',
        response.status,
      );
    }
    final map = Map<String, dynamic>.from(data);
    if (map['ok'] != true) {
      throw _errorFrom(map, response.status, response.reasonPhrase);
    }
    return map;
  }

  Future<String> _idToken() async {
    String? token;
    try {
      final provider = _tokenProvider;
      token = provider != null
          ? await provider()
          : await (_auth ?? FirebaseAuth.instance).currentUser?.getIdToken();
    } on Object {
      throw const EdgeFunctionException(
        'authentication_required',
        'Sign in to continue.',
        401,
      );
    }
    if (token == null || token.isEmpty) {
      throw const EdgeFunctionException(
        'authentication_required',
        'Sign in to continue.',
        401,
      );
    }
    return token;
  }

  Future<EdgeFunctionResponse> _call(
    String function,
    Map<String, dynamic> body,
    String token,
  ) async {
    final invoker = _invoker;
    if (invoker != null) return invoker(function, body, token);
    final response = await (_client ?? Supabase.instance.client).functions
        .invoke(
          function,
          headers: {'Authorization': 'Bearer $token'},
          body: body,
        );
    return EdgeFunctionResponse(status: response.status, data: response.data);
  }

  EdgeFunctionException _errorFrom(
    Object? payload,
    int status,
    String? reasonPhrase,
  ) {
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
    return EdgeFunctionException(
      code is String && code.isNotEmpty
          ? code
          : (status == 0 ? 'network_error' : 'request_failed'),
      message is String && message.isNotEmpty
          ? message
          : (reasonPhrase ?? 'The request failed.'),
      status,
    );
  }
}
