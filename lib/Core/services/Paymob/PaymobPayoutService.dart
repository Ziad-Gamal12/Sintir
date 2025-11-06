import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:sintir/Core/errors/Exceptioons.dart';
import 'package:sintir/constant.dart';
import 'package:uuid/uuid.dart';

class PaymobPayoutService {
  final Dio dio;
  final Uuid _uuid = const Uuid();

  /// Base URL for Payout API
  static const String _baseUrl =
      "https://stagingpayouts.paymobsolutions.com/api/secure/";

  PaymobPayoutService({Dio? dio})
      : dio = dio ??
            Dio(
              BaseOptions(
                connectTimeout: const Duration(seconds: 20),
                receiveTimeout: const Duration(seconds: 20),
              ),
            );

  /// Step 1: Generate Access Token
  Future<Map<String, dynamic>> generateAccessToken() async {
    try {
      const clientId = PayMobPayOutClientID;
      const clientSecret = PayMobPayOutClientSecret;
      const username = PayMobPayOutUsername;
      const password = PayMobPayOutPassword;

      final credentials = base64Encode(utf8.encode('$clientId:$clientSecret'));

      final body = {
        "grant_type": "password",
        "username": username,
        "password": password,
      };

      final encodedBody = body.entries
          .map((e) =>
              "${Uri.encodeQueryComponent(e.key)}=${Uri.encodeQueryComponent(e.value)}")
          .join("&");

      final response = await Dio().post(
        "${_baseUrl}o/token/",
        data: encodedBody,
        options: Options(
          contentType: Headers.formUrlEncodedContentType,
          headers: {
            "Authorization": "Basic $credentials",
            "Content-Type": "application/x-www-form-urlencoded",
          },
        ),
      );

      return response.data;
    } on DioException catch (e, s) {
      throw CustomException(message: "Failed to generate access token");
    }
  }

  /// Step 2: Refresh Access Token
  Future<Map<String, dynamic>> refreshAccessToken(String refreshToken) async {
    try {
      const clientId = PayMobPayOutClientID;
      const clientSecret = PayMobPayOutClientSecret;
      final credentials = base64Encode(utf8.encode('$clientId:$clientSecret'));

      final response = await dio.post(
        "${_baseUrl}o/token/",
        data: {
          "grant_type": "refresh_token",
          "refresh_token": refreshToken,
        },
        options: Options(
          headers: {
            "Authorization": "Basic $credentials",
            "Content-Type": "application/x-www-form-urlencoded",
          },
        ),
      );

      return response.data;
    } on DioException catch (e) {
      throw CustomException(
          message:
              e.response?.data?["error_description"] ?? "Token refresh failed");
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
          "issuer": issuer.toLowerCase(), // e.g. vodafone, etisalat, aman...
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

      return response.data;
    } on DioException catch (e) {
      throw CustomException(
        message: "Failed to make disbursement",
      );
    }
  }

  /// Step 4: Check Disbursement Status
  Future<Map<String, dynamic>> getDisbursementStatus({
    required String accessToken,
    required String transactionId,
  }) async {
    try {
      final response = await dio.get(
        "${_baseUrl}disbursement_status/?transaction_id=$transactionId",
        options: Options(
          headers: {
            "Authorization": "Bearer $accessToken",
            "Content-Type": "application/json",
          },
        ),
      );

      return response.data;
    } on DioException catch (e, s) {
      throw CustomException(
          message:
              e.response?.data?["error_description"] ?? "Failed to get status");
    }
  }
}
