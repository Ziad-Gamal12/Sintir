// ignore_for_file: file_names

import 'package:dio/dio.dart';
import 'package:sintir/Core/entities/PaymentEntities/OrderDataEntity.dart';
import 'package:sintir/Core/entities/PaymentEntities/PaymentDataEntity.dart';
import 'package:sintir/Core/models/PaymentModels/OrderDataModel.dart';
import 'package:sintir/Core/models/PaymentModels/PaymentDataModel.dart';

class PayMobService {
  static String apiKey =
      'ZXlKaGJHY2lPaUpJVXpVeE1pSXNJblI1Y0NJNklrcFhWQ0o5LmV5SmpiR0Z6Y3lJNklrMWxjbU5vWVc1MElpd2ljSEp2Wm1sc1pWOXdheUk2TVRBek5EVTRPU3dpYm1GdFpTSTZJbWx1YVhScFlXd2lmUS5SNW9iQlI3Y0JDRWdFOWhvZXFfNnJBZVdHWnU4WnZfS0VEUWo3RDNYeVNvT0x1YnlFZ3UtdDJfMlJpYUhWdjl4WVh4LW1lRW4yaEJGNE9USWoxWXpGUQ==';
  final Dio dio = Dio();
  static String baseUrl = "https://accept.paymob.com/api/";

  Future<String?> getAuthToken() async {
    Response response = await dio.post(
      "${baseUrl}auth/tokens",
      data: {
        "api_key": apiKey,
      },
    );
    return response.data["token"];
  }

  Future<int?> createPaymentOrder(
      {required Orderdataentity orderEntity}) async {
    Response response = await dio.post("${baseUrl}ecommerce/orders",
        data: Orderdatamodel.fromEntity(orderEntity).toJson());
    return response.data["id"];
  }

  Future<String> getPaymentToken(
      {required Paymentdataentity paymententity}) async {
    Response response = await dio.post("${baseUrl}acceptance/payment_keys",
        data: Paymentdatamodel.formEntity(paymententity).toJson());
    return response.data["token"];
  }
}
