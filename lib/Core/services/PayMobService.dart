// ignore_for_file: file_names

import 'package:dio/dio.dart';
import 'package:sintir/Core/entities/PaymentEntities/OrderDataEntity.dart';
import 'package:sintir/Core/entities/PaymentEntities/PaymentDataEntity.dart';
import 'package:sintir/Core/models/PaymentModels/OrderDataModel.dart';
import 'package:sintir/Core/models/PaymentModels/PaymentDataModel.dart';
import 'package:sintir/constant.dart';

class PayMobService {
  final Dio dio = Dio();
  static String baseUrl = "https://accept.paymob.com/api/";

  Future<String?> getAuthToken() async {
    Response response = await dio.post(
      "${baseUrl}auth/tokens",
      data: {
        "api_key": PaymobApiKey,
      },
    );
    return response.data["token"];
  }

  Future<int?> createPaymentOrder(
      {required Orderdataentity orderEntity}) async {
    Response response = await dio.post("${baseUrl}ecommerce/orders",
        options: Options(headers: {
          "Content-Type": "application/json",
          "Authorization": orderEntity.authToken
        }),
        data: Orderdatamodel.fromEntity(orderEntity).toJson());
    return response.data["id"];
  }

  Future<String> getPaymentToken(
      {required Paymentdataentity paymententity}) async {
    Response response = await dio.post("${baseUrl}acceptance/payment_keys",
        options: Options(headers: {
          "Content-Type": "application/json",
          "Authorization": paymententity.authToken
        }),
        data: Paymentdatamodel.formEntity(paymententity).toJson());
    return response.data["token"];
  }

  Future<String> payWithWallet({required Map<String, dynamic> body}) async {
    Response response = await dio.post("${baseUrl}acceptance/payments/pay",
        options: Options(headers: {
          "Content-Type": "application/json",
        }),
        data: body);
    return response.data["iframe_redirection_url"];
  }
}
