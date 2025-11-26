import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:sintir/Core/errors/Exceptioons.dart';
import 'package:sintir/constant.dart';
import 'package:sintir/locale_keys.dart';

class ElevenlabsApi {
  final Dio dio;
  static const baseUrl = "https://api.elevenlabs.io/v1/text-to-speech/";

  ElevenlabsApi({required this.dio});
  Future<Uint8List> post({
    required Map<String, dynamic> body,
  }) async {
    try {
      Response response = await dio.post("$baseUrl$ElevenlabsVoiceId",
          data: body,
          options: Options(headers: {
            'Content-Type': 'application/json',
            'xi-api-key': ElevenlabsApiKey2
          }, responseType: ResponseType.bytes));
      return Uint8List.fromList(response.data);
    } on DioException catch (e) {
      throw DioStatusHandler.handle(e);
    } catch (e) {
      throw CustomException(message: LocaleKeys.unknownError);
    }
  }
}
