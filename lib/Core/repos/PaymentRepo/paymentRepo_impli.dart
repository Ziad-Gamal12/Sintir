import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:sintir/Core/entities/PaymentEntities/OrderDataEntity.dart';
import 'package:sintir/Core/entities/PaymentEntities/PaymentDataEntity.dart';
import 'package:sintir/Core/errors/Failures.dart';
import 'package:sintir/Core/models/PaymentModels/OrderDataModel.dart';
import 'package:sintir/Core/models/PaymentModels/PaymentDataModel.dart';
import 'package:sintir/Core/repos/PaymentRepo/paymentRepo.dart';
import 'package:sintir/Core/services/PayMobService.dart';

class PaymentrepoImpli implements Paymentrepo {
  final PayMobService payMobService;

  PaymentrepoImpli({required this.payMobService});

  Future<int?> createPaymentOrder(
      {required Orderdataentity orderEntity}) async {
    int? id = await payMobService.createPaymentOrder(orderEntity: orderEntity);
    return id;
  }

  Future<String?> getAuthToken() async {
    String? token = await payMobService.getAuthToken();
    return token;
  }

  Future<String> getPaymentToken(
      {required Paymentdataentity paymententity}) async {
    String token =
        await payMobService.getPaymentToken(paymententity: paymententity);
    return token;
  }

  @override
  Future<Either<Failure, String>> payWithFawry(
      {required Paymentdataentity paymententity,
      required Orderdataentity orderEntity}) async {
    try {
      String? authtoken = await getAuthToken();
      if (authtoken == null) {
        return Left(
            ServerFailure(message: "حدث خطأ أثناء الحصول على التوكن الخاص بك"));
      } else {
        orderEntity.authToken = authtoken;
        log(Orderdatamodel.fromEntity(orderEntity).toJson().toString());
        paymententity.authToken = authtoken;
      }
      int? paymentToken = await createPaymentOrder(orderEntity: orderEntity);
      if (paymentToken == null) {
        return Left(ServerFailure(message: "حدث خطاء في انشاء الطلبية"));
      } else {
        paymententity.orderId = paymentToken;
      }
      log(Paymentdatamodel.formEntity(paymententity).toJson().toString());
      String token = await getPaymentToken(paymententity: paymententity);
      return right(token);
    } catch (e) {
      log("Exception from PaymentrepoImpli.payWithFawry in catch With Firebase Exception: ${e.toString()}");
      return Left(ServerFailure(message: e.toString()));
    }
  }
}
