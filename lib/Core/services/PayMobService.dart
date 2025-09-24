import 'package:dio/dio.dart';
import 'package:sintir/Core/errors/Exceptioons.dart';
import 'package:sintir/constant.dart';

class PayMobService {
  final Dio dio;

  /// Unified Checkout base URL
  static const String _baseUrl = "https://accept.paymob.com/v1/";

  PayMobService({Dio? dio})
      : dio = dio ??
            Dio(
              BaseOptions(
                connectTimeout: const Duration(seconds: 15),
                receiveTimeout: const Duration(seconds: 15),
                headers: {
                  "Content-Type": "application/json",
                },
              ),
            );

  /// Step 1: Create Payment Intention
  Future<Map<String, dynamic>> createPaymentIntention({
    required int amountCents,
    required String currency,
    required int integrationId,
    required Map<String, dynamic> billingData,
  }) async {
    try {
      final response = await dio.post(
        "${_baseUrl}intention/",
        data: {
          "amount": amountCents,
          "currency": currency,
          "payment_methods": [integrationId],
          "billing_data": billingData,
        },
        options: Options(
          headers: {
            "Authorization": "Token $PayMobSecretKey", // Secret Key (Test Mode)
          },
        ),
      );

      return response.data;
    } on DioException catch (e) {
      throw CustomException(
          message: e.response?.data?["message"] ?? "Payment intention error");
    } catch (e) {
      throw CustomException(message: "Unexpected error occurred");
    }
  }

  /// Step 2: Build Unified Checkout URL
  String buildCheckoutUrl({
    required String clientSecret,
  }) {
    return "https://accept.paymob.com/unifiedcheckout/?publicKey=$PayMobTestPublicKey&clientSecret=$clientSecret";
  }
}
