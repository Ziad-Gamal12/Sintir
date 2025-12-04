import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:sintir/Core/errors/Exceptioons.dart';
import 'package:sintir/constant.dart';
import 'package:uuid/uuid.dart';

class PaymobPayoutService {
  final Dio dio;
  final Uuid _uuid = const Uuid();

  static const String _baseUrl =
      "https://stagingpayouts.paymobsolutions.com/api/secure/";

  PaymobPayoutService({Dio? dio})
      : dio = dio ??
            Dio(
              BaseOptions(
                connectTimeout: const Duration(seconds: 30),
                receiveTimeout: const Duration(seconds: 30),
              ),
            );

  String _getBasicAuthHeader() {
    const clientId = PayMobPayOutClientID;
    const clientSecret = PayMobPayOutClientSecret;
    final credentials = base64Encode(utf8.encode('$clientId:$clientSecret'));
    return "Basic $credentials";
  }

  CustomException _handleDioError(DioException e, String defaultMessage) {
    String errorMessage = defaultMessage;

    final statusCode = e.response?.statusCode ?? 0;

    if (e.response?.data is Map) {
      errorMessage = e.response!.data["error_description"] ??
          e.response!.data["message"] ??
          defaultMessage;
    } else if (e.response?.data is String) {
      errorMessage = e.response!.data.toString();
    }

    return CustomException(
      message: "$errorMessage (HTTP $statusCode)",
    );
  }

  Future<Map<String, dynamic>> generateAccessToken() async {
    try {
      const username = PayMobPayOutUsername;
      const password = PayMobPayOutPassword;

      final body = {
        "grant_type": "password",
        "username": username,
        "password": password,
      };

      final response = await dio.post(
        "${_baseUrl}o/token/",
        data: body,
        options: Options(
          contentType: Headers.formUrlEncodedContentType,
          headers: {
            "Authorization": _getBasicAuthHeader(),
          },
        ),
      );

      return response.data;
    } on DioException catch (e) {
      throw _handleDioError(e, "Failed to generate initial access token.");
    }
  }

  Future<Map<String, dynamic>> refreshAccessToken(String refreshToken) async {
    try {
      final body = {
        "grant_type": "refresh_token",
        "refresh_token": refreshToken,
      };

      final response = await dio.post(
        "${_baseUrl}o/token/",
        data: body,
        options: Options(
          contentType: Headers.formUrlEncodedContentType,
          headers: {
            "Authorization": _getBasicAuthHeader(),
          },
        ),
      );

      return response.data;
    } on DioException catch (e) {
      throw _handleDioError(e, "Token refresh failed.");
    }
  }

  Future<Map<String, dynamic>> makeDisbursement({
    required String accessToken,
    required double amount,
    required String receiverMobile,
    String issuer = "vodafone",
    String? clientReferenceId,
  }) async {
    try {
      final response = await dio.post(
        "${_baseUrl}disburse/",
        data: {
          "issuer": issuer.toLowerCase(),
          "amount": amount,
          "msisdn": receiverMobile,
          "client_reference_id": clientReferenceId ?? _uuid.v4(),
        },
        options: Options(
          headers: {
            "Authorization": "Bearer $accessToken",
            "Content-Type": "application/json",
          },
        ),
      );

      if (response.statusCode != 200 && response.statusCode != 201) {
        throw CustomException(
            message:
                "Disbursement failed with status code ${response.statusCode}");
      }

      return response.data;
    } on DioException catch (e) {
      throw _handleDioError(e, "Failed to make disbursement.");
    }
  }

  /// Step 4: Check Disbursement Status
  Future<Map<String, dynamic>> getDisbursementStatus({
    required String accessToken,
    required String transactionId,
    bool isBankTransaction = false,
  }) async {
    const path = "transaction/inquire/";

    try {
      final requestBody = {
        "transactions_ids_list": [transactionId],
        "bank_transactions": isBankTransaction,
      };

      final response = await dio.get(
        "$_baseUrl$path",
        data: requestBody,
        options: Options(
          headers: {
            "Authorization": "Bearer $accessToken",
            "Content-Type": "application/json",
          },
        ),
      );

      if (response.data is Map &&
          response.data.containsKey('results') &&
          response.data['results'] is List &&
          (response.data['results'] as List).isNotEmpty) {
        return response.data['results'][0];
      }

      if (response.data is Map) {
        return response.data;
      }

      return response.data;
    } on DioException catch (e) {
      throw _handleDioError(e, "Failed to get status.");
    } catch (e) {
      throw CustomException(message: e.toString());
    }
  }
}
