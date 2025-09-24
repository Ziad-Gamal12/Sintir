import 'dart:typed_data';

import 'package:dartz/dartz.dart';
import 'package:sintir/Core/entities/ElevenlabsEntities/ElevenlabsRequestBodyEntity.dart';
import 'package:sintir/Core/entities/gemini/GeminiContent.dart';
import 'package:sintir/Core/entities/gemini/GeminiResponse.dart';
import 'package:sintir/Core/errors/Failures.dart';

abstract class AiTeacherRepo {
  Future<Either<Failure, String>> extractTextFromFile();
  Future<Either<Failure, GeminiResponse>> chatWithGemini(
      {required List<GeminiContent> body});
  Future<Either<Failure, Uint8List>> textToSpeech(
      {required ElevenlabsRequestBodyEntity bodyEnity});
}
