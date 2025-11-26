import 'package:dio/dio.dart';
import 'package:sintir/Core/errors/Exceptioons.dart';
import 'package:sintir/constant.dart';
import 'package:sintir/locale_keys.dart';

class GeminiApiService {
  final Dio dio;

  GeminiApiService({required this.dio});
  static const String baseUrl =
      "https://generativelanguage.googleapis.com/v1beta/models/gemini-2.0-flash:generateContent?";
  Future<Map<String, dynamic>> post({
    required Map<String, dynamic> body,
  }) async {
    try {
      Response response = await dio.post(
        "${baseUrl}key=$GeminiApiKey",
        data: body,
      );
      return response.data;
    } on DioException catch (e) {
      throw DioStatusHandler.handle(e);
    } catch (e) {
      throw CustomException(message: LocaleKeys.unknownError);
    }
  }
}
