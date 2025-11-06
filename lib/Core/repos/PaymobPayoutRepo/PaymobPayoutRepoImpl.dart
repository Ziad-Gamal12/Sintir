import 'package:dartz/dartz.dart';
import 'package:sintir/Core/errors/Exceptioons.dart';
import 'package:sintir/Core/errors/Failures.dart';
import 'package:sintir/Core/repos/PaymobPayoutRepo/PaymobPayoutRepo.dart';
import 'package:sintir/Core/services/Paymob/PaymobPayoutService.dart';

class PaymobPayoutRepoImpl implements PaymobPayoutRepo {
  final PaymobPayoutService service;
  String? accessToken;
  String? refreshToken;

  PaymobPayoutRepoImpl({required this.service});

  @override
  Future<Either<Failure, String>> sendDisbursement({
    required String receiverMobile,
    required double amount,
    required String issuer,
    String currency = "EGP",
  }) async {
    try {
      // Step 1: Generate token if not available
      if (accessToken == null) {
        final tokenData = await service.generateAccessToken();
        accessToken = tokenData["access_token"];
        refreshToken = tokenData["refresh_token"];
      }

      // Step 2: Make disbursement
      final result = await service.makeDisbursement(
        accessToken: accessToken!,
        receiverMobile: receiverMobile,
        issuer: issuer,
        amount: amount,
      );

      return right(result["transaction_id"].toString());
    } on CustomException catch (e) {
      return left(ServerFailure(message: e.message));
    }
  }

  @override
  Future<Either<Failure, Map<String, dynamic>>> getDisbursementStatus({
    required String transactionId,
  }) async {
    try {
      if (accessToken == null) {
        final tokenData = await service.generateAccessToken();
        accessToken = tokenData["access_token"];
      }

      final result = await service.getDisbursementStatus(
        accessToken: accessToken!,
        transactionId: transactionId,
      );

      return right(result);
    } on CustomException catch (e) {
      return left(ServerFailure(message: e.message));
    }
  }
}
