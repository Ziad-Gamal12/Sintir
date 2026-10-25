import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:sintir/Core/services/Shared_preferences.dart';
import 'package:sintir/Core/services/WithdrawalIdempotency.dart';

class TeacherWithdrawalService {
  TeacherWithdrawalService(
      {required Dio dio, required String url, required String publishableKey})
      : _dio = dio,
        _url = '$url/functions/v1/teacher-withdrawal',
        _publishableKey = publishableKey;

  final Dio _dio;
  final String _url;
  final String _publishableKey;

  static const _definitelyNotReservedCodes = {
    'invalid_request',
    'teacher_not_found',
    'wallet_not_eligible',
    'insufficient_balance',
  };

  Future<Map<String, dynamic>> request({
    required double amount,
    required String issuer,
    required String mobileNumber,
    required String idempotencyKey,
  }) async {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) throw StateError('Please sign in again.');
    final storageKey = 'pending_teacher_withdrawal_${user.uid}';
    final preferences = shared_preferences_Services.sharedPreferences;
    final saved = preferences.getString(storageKey);
    final request = WithdrawalRequestSnapshot.resolve(
      saved: saved,
      proposedKey: idempotencyKey,
      amount: amount,
      issuer: issuer,
      mobileNumber: mobileNumber,
    );
    // Persist the complete immutable request before network I/O. A restart or
    // timeout therefore retries with the same key and exact payout details.
    await preferences.setString(storageKey, request.encode());
    late final Map<String, dynamic> result;
    try {
      result = await _post({
        'action': 'create',
        'amount': request.amount,
        'issuer': request.issuer,
        'mobileNumber': request.mobileNumber,
        'idempotencyKey': request.idempotencyKey,
      });
    } on WithdrawalApiException catch (error) {
      if (_definitelyNotReservedCodes.contains(error.code)) {
        await preferences.remove(storageKey);
      }
      rethrow;
    }
    if (withdrawalRequestIsResolved(result['status']?.toString() ?? '')) {
      await preferences.remove(storageKey);
    }
    return result;
  }

  Future<Map<String, dynamic>> reconcile(String id) async {
    final result = await _post({'action': 'reconcile', 'withdrawalId': id});
    if (withdrawalRequestIsResolved(result['status']?.toString() ?? '')) {
      final user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        final storageKey = 'pending_teacher_withdrawal_${user.uid}';
        final preferences = shared_preferences_Services.sharedPreferences;
        final saved = preferences.getString(storageKey);
        if (saved != null) {
          try {
            if (WithdrawalRequestSnapshot.decode(saved).idempotencyKey == id) {
              await preferences.remove(storageKey);
            }
          } on FormatException {
            if (saved.toLowerCase() == id.toLowerCase()) {
              await preferences.remove(storageKey);
            }
          }
        }
      }
    }
    return result;
  }

  Future<Map<String, dynamic>> _post(Map<String, dynamic> data) async {
    final token = await FirebaseAuth.instance.currentUser?.getIdToken();
    if (token == null || token.isEmpty) {
      throw StateError('Please sign in again.');
    }

    final response = await _dio.post<dynamic>(
      _url,
      data: data,
      options: Options(
        headers: {
          'Authorization': 'Bearer $token',
          'apikey': _publishableKey,
          'Content-Type': Headers.jsonContentType,
        },
        // A 4xx response is an expected business result (for example, an old
        // withdrawal without a Paymob reference), not a transport failure.
        validateStatus: (status) => status != null && status < 600,
      ),
    );

    final body = response.data;
    if (body is! Map) {
      throw StateError('Withdrawal service returned an invalid response.');
    }
    final result = Map<String, dynamic>.from(body);
    if (response.statusCode == null ||
        response.statusCode! >= 400 ||
        result['ok'] != true) {
      final error = result['error'];
      final message = error is Map ? error['message']?.toString() : null;
      final code = error is Map ? error['code']?.toString() : null;
      throw WithdrawalApiException(
        code: code ?? 'request_failed',
        message: message ?? 'Withdrawal request failed.',
      );
    }
    return result;
  }
}

class WithdrawalApiException implements Exception {
  const WithdrawalApiException({required this.code, required this.message});

  final String code;
  final String message;

  @override
  String toString() => message;
}
