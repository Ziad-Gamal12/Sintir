// ignore_for_file: file_names

import 'package:dio/dio.dart';
import 'package:sintir/locale_keys.dart';

class CustomException implements Exception {
  final String message;
  CustomException({required this.message});
  @override
  String toString() {
    return message;
  }
}

class ApiException implements Exception {
  final String message;
  ApiException(this.message);

  @override
  String toString() => message;
}

class DioStatusHandler {
  static ApiException handle(DioException error) {
    if (error.type == DioExceptionType.connectionTimeout) {
      throw ApiException(LocaleKeys.connectionTimeout);
    } else if (error.type == DioExceptionType.sendTimeout) {
      throw ApiException(LocaleKeys.sendTimeout);
    } else if (error.type == DioExceptionType.receiveTimeout) {
      throw ApiException(LocaleKeys.receiveTimeout);
    } else if (error.type == DioExceptionType.badCertificate) {
      throw ApiException(LocaleKeys.badCertificate);
    } else if (error.type == DioExceptionType.cancel) {
      throw ApiException(LocaleKeys.requestCancelled);
    } else if (error.type == DioExceptionType.unknown) {
      throw ApiException(LocaleKeys.unknownError);
    } else if (error.type == DioExceptionType.badResponse) {
      final statusCode = error.response?.statusCode ?? 0;
      switch (statusCode) {
        case 400:
          throw ApiException(LocaleKeys.badRequest);
        case 401:
          throw ApiException(LocaleKeys.unauthorized);
        case 403:
          throw ApiException(LocaleKeys.forbidden);
        case 404:
          throw ApiException(LocaleKeys.notFound);
        case 422:
          throw ApiException(LocaleKeys.unprocessableEntity);
        case 500:
          throw ApiException(LocaleKeys.internalServerError);
        case 503:
          throw ApiException(LocaleKeys.serviceUnavailable);
        default:
          throw ApiException('${LocaleKeys.unknownStatusCode}$statusCode');
      }
    } else {
      throw ApiException(LocaleKeys.serverConnectionError);
    }
  }
}
