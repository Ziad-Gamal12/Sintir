import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';

class TeacherWithdrawalService {
  TeacherWithdrawalService(
      {required Dio dio, required String url, required String publishableKey})
      : _dio = dio,
        _url = '$url/functions/v1/teacher-withdrawal',
        _publishableKey = publishableKey;

  final Dio _dio;
  final String _url;
  final String _publishableKey;

  Future<Map<String, dynamic>> request({
    required double amount,
    required String issuer,
    required String mobileNumber,
    required String idempotencyKey,
  }) =>
      _post({
        'action': 'create',
        'amount': amount,
        'issuer': issuer,
        'mobileNumber': mobileNumber,
        'idempotencyKey': idempotencyKey,
      });

  Future<Map<String, dynamic>> reconcile(String id) =>
      _post({'action': 'reconcile', 'withdrawalId': id});

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
      throw StateError(message ?? 'Withdrawal request failed.');
    }
    return result;
  }
}