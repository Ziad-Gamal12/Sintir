import 'package:dio/dio.dart';
import 'package:sintir/Core/errors/Exceptioons.dart';
import 'package:sintir/locale_keys.dart';

class PayMobService {
  final Dio dio;

  /// Unified Checkout base URL
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

  /// Intention creation is server-side. This client service remains only to
  /// fail closed for legacy callers while existing installations migrate.
  Future<Map<String, dynamic>> createPaymentIntention({
    required int amountCents,
    required String currency,
    required List<int> integrationIds,
    required Map<String, dynamic> billingData,
    required List<Map<String, dynamic>> items,
  }) async {
    throw CustomException(message: LocaleKeys.unexpectedError);
  }

  String buildCheckoutUrl({
    required String clientSecret,
  }) {
    throw CustomException(message: LocaleKeys.unexpectedError);
  }
}
