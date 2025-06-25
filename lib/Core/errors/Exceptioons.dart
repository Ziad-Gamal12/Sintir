// ignore_for_file: file_names

import 'package:dio/dio.dart';

class CustomException implements Exception {
  final String message;
  CustomException({required this.message});
  @override
  String toString() {
    return message;
  }
}

/// استثناء مخصص لعرض رسالة مفهومة للمستخدم
class ApiException implements Exception {
  final String message;
  ApiException(this.message);

  @override
  String toString() => message;
}

class DioStatusHandler {
  static ApiException handle(DioException error) {
    if (error.type == DioExceptionType.connectionTimeout) {
      throw ApiException('انتهت مهلة الاتصال بالخادم. حاول مرة أخرى.');
    } else if (error.type == DioExceptionType.sendTimeout) {
      throw ApiException('انتهت مهلة إرسال البيانات. حاول مرة أخرى.');
    } else if (error.type == DioExceptionType.receiveTimeout) {
      throw ApiException('انتهت مهلة استلام البيانات من الخادم.');
    } else if (error.type == DioExceptionType.badCertificate) {
      throw ApiException('فشل التحقق من شهادة الخادم.');
    } else if (error.type == DioExceptionType.cancel) {
      throw ApiException('تم إلغاء الطلب.');
    } else if (error.type == DioExceptionType.unknown) {
      throw ApiException('حدث خطأ غير متوقع. تأكد من الاتصال بالإنترنت.');
    } else if (error.type == DioExceptionType.badResponse) {
      final statusCode = error.response?.statusCode ?? 0;
      switch (statusCode) {
        case 400:
          throw ApiException('الطلب غير صحيح (400).');
        case 401:
          throw ApiException(
              'غير مصرح لك بالوصول (401). تأكد من تسجيل الدخول.');
        case 403:
          throw ApiException('ليس لديك صلاحية لتنفيذ هذا الإجراء (403).');
        case 404:
          throw ApiException('العنصر المطلوب غير موجود (404).');
        case 422:
          throw ApiException('البيانات المدخلة غير صالحة (422).');
        case 500:
          throw ApiException('خطأ داخلي في الخادم (500). حاول لاحقًا.');
        case 503:
          throw ApiException(
              'الخدمة غير متوفرة حاليًا. الرجاء المحاولة لاحقًا (503).');
        default:
          throw ApiException('حدث خطأ غير معروف: $statusCode');
      }
    } else {
      throw ApiException('حدث خطأ أثناء الاتصال بالخادم.');
    }
  }
}
