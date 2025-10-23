import 'package:dartz/dartz.dart';
import 'package:sintir/Core/errors/Failures.dart';

abstract class PaymobPayoutRepo {
  Future<Either<Failure, String>> sendDisbursement({
    required String receiverMobile,
    required double amount,
    required String issuer,
    String currency = "EGP",
  });

  Future<Either<Failure, Map<String, dynamic>>> getDisbursementStatus({
    required String transactionId,
  });
}
