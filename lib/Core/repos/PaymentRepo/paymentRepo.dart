import 'package:dartz/dartz.dart';
import 'package:sintir/Core/entities/PaymentEntities/OrderDataEntity.dart';
import 'package:sintir/Core/entities/PaymentEntities/PaymentDataEntity.dart';
import 'package:sintir/Core/errors/Failures.dart';

abstract class Paymentrepo {
  Future<Either<Failure, String>> payWithFawry(
      {required Paymentdataentity paymententity,
      required Orderdataentity orderEntity});
}
