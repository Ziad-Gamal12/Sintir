import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:sintir/Core/errors/Exceptioons.dart';
import 'package:sintir/Core/errors/Failures.dart';
import 'package:sintir/Core/repos/PaymobPayoutRepo/PayoutRepo.dart';
import 'package:sintir/Core/services/Paymob/PaymobPayoutService.dart';

class PayoutRepoImpl implements PayoutRepo {
  final PaymobPayoutService service;
  // State management for tokens (should ideally be persisted for long-running apps)
  String? accessToken;
  String? refreshToken;

  PayoutRepoImpl({
    required this.service,
  });

  Future<void> _ensureAccessToken() async {
    if (accessToken != null) {
      return;
    }

    if (refreshToken != null) {
      final tokenData = await service.refreshAccessToken(refreshToken!);
      accessToken = tokenData["access_token"];
      refreshToken = tokenData["refresh_token"] ?? refreshToken;
      return;
    }

    final tokenData = await service.generateAccessToken();
    accessToken = tokenData["access_token"];
    refreshToken = tokenData["refresh_token"];
  }

  Future<T> _callApiWithTokenRefresh<T>(
      Future<T> Function(String token) apiCall) async {
    try {
      await _ensureAccessToken();
      return await apiCall(accessToken!);
    } on DioException catch (e) {
      if (e.response?.statusCode == 401) {
        accessToken = null;
        try {
          await _ensureAccessToken();
          return await apiCall(accessToken!);
        } on CustomException {
          rethrow;
        }
      }
      rethrow;
    }
  }

  @override
  Future<Either<Failure, String>> sendDisbursement({
    required String receiverMobile,
    required double amount,
    required String issuer,
    String currency = "EGP",
  }) async {
    try {
      final result = await _callApiWithTokenRefresh(
        (token) => service.makeDisbursement(
          accessToken: token,
          receiverMobile: receiverMobile,
          issuer: issuer,
          amount: amount,
        ),
      );

      final transactionId = result["transaction_id"];
      if (transactionId == null) {
        throw CustomException(
            message:
                "Disbursement succeeded, but transaction ID was missing in the response.");
      }

      return right(transactionId.toString());
    } on CustomException catch (e) {
      return left(ServerFailure(message: e.message));
    } catch (e) {
      return left(ServerFailure(
          message:
              "An unexpected error occurred during disbursement: ${e.toString()}"));
    }
  }

  @override
  Future<Either<Failure, Map<String, dynamic>>> getDisbursementStatus({
    required String transactionId,
  }) async {
    try {
      final result = await _callApiWithTokenRefresh(
        (token) => service.getDisbursementStatus(
          accessToken: token,
          transactionId: transactionId,
        ),
      );

      return right(result);
    } on CustomException catch (e) {
      return left(ServerFailure(message: e.message));
    } catch (e) {
      return left(ServerFailure(
          message:
              "An unexpected error occurred getting status: ${e.toString()}"));
    }
  }
}
