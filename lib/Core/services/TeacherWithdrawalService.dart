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
  Future<Map<String, dynamic>> request(
          {required double amount,
          required String issuer,
          required String mobileNumber,
          required String idempotencyKey}) =>
      _post({
        'action': 'create',
        'amount': amount,
        'issuer': issuer,
        'mobileNumber': mobileNumber,
        'idempotencyKey': idempotencyKey
      });
  Future<Map<String, dynamic>> reconcile(String id) =>
      _post({'action': 'reconcile', 'withdrawalId': id});
  Future<Map<String, dynamic>> _post(Map<String, dynamic> data) async {
    final token = await FirebaseAuth.instance.currentUser?.getIdToken();
    if (token == null || token.isEmpty) {
      throw StateError('Please sign in again.');
    }
    final r = await _dio.post<Map<String, dynamic>>(_url,
        data: data,
        options: Options(headers: {
          'Authorization': 'Bearer $token',
          'apikey': _publishableKey,
          'Content-Type': Headers.jsonContentType
        }));
    if (r.data?['ok'] != true) throw StateError('Withdrawal request failed.');
    return r.data!;
  }
}
