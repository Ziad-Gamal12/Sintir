import 'package:dio/dio.dart';

/// Deliberately disabled. Payout credentials and payout API calls must never
/// exist in a teacher's Flutter application. Use TeacherWithdrawalService,
/// which calls the authenticated Supabase Edge Function instead.
@Deprecated(
    'Use TeacherWithdrawalService. Client-side Paymob payouts are unsafe.')
class PaymobPayoutService {
  PaymobPayoutService({Dio? dio});

  Never _disabled() => throw UnsupportedError(
        'Client-side Paymob payout operations are disabled for security.',
      );

  Future<Map<String, dynamic>> generateAccessToken() async => _disabled();

  Future<Map<String, dynamic>> refreshAccessToken(String refreshToken) async =>
      _disabled();

  Future<Map<String, dynamic>> makeDisbursement({
    required String accessToken,
    required double amount,
    required String receiverMobile,
    String issuer = 'vodafone',
    String? clientReferenceId,
  }) async =>
      _disabled();

  Future<Map<String, dynamic>> getDisbursementStatus({
    required String accessToken,
    required String transactionId,
    bool isBankTransaction = false,
  }) async =>
      _disabled();
}
