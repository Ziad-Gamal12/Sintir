import 'dart:io';
import 'dart:typed_data';

import 'package:dartz/dartz.dart';
import 'package:sintir/Core/entities/ElevenlabsEntities/ElevenlabsRequestBodyEntity.dart';
import 'package:sintir/Core/entities/gemini/GeminiContent.dart';
import 'package:sintir/Core/entities/gemini/GeminiResponse.dart';
import 'package:sintir/Core/errors/Exceptioons.dart';
import 'package:sintir/Core/errors/Failures.dart';
import 'package:sintir/Core/models/ElevenlabsModels/ElevenlabsRequestBodyModel.dart';
import 'package:sintir/Core/models/gemini/content.dart';
import 'package:sintir/Core/models/gemini/gemini.dart';
import 'package:sintir/Core/services/GeminiAPiService.dart';
import 'package:sintir/Core/services/PickerAssetsService.dart';
import 'package:sintir/Core/services/elevenlabsApi.dart';
import 'package:sintir/Features/Ai_Teacher/domain/Repos/AITeacherRepo.dart';
import 'package:syncfusion_flutter_pdf/pdf.dart';

class AiTeacherRepoImpli implements AiTeacherRepo {
  final Pickerassetsservice pickerassetsservice;
  final GeminiApiService geminiApiService;
  final ElevenlabsApi elevenlabsApi;
  AiTeacherRepoImpli(
      {required this.pickerassetsservice,
      required this.geminiApiService,
      required this.elevenlabsApi});
  @override
  Future<Either<Failure, String>> extractTextFromFile() async {
    try {
      File? file = await pickerassetsservice.getFile();
      if (file == null) return left(ServerFailure(message: "الملف غير موجودة"));
      final bytes = await file.readAsBytes();
      final document = PdfDocument(inputBytes: bytes);
      final text = PdfTextExtractor(document).extractText();
      return right(text);
    } catch (e) {
      return left(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, GeminiResponse>> chatWithGemini({
    required List<GeminiContent> body,
  }) async {
    try {
      final requestBody = {
        "contents": body.map((e) => Content.fromEntity(e).toJson()).toList(),
      };
      final response = await geminiApiService.post(body: requestBody);
      return right(Gemini.fromJson(response).toEntity());
    } on ApiException catch (e) {
      return left(ServerFailure(message: e.message));
    } on CustomException catch (e) {
      return left(ServerFailure(message: e.message));
    } catch (e) {
      return left(
          ServerFailure(message: "حدث خطأ غير متوقع، حاول مرة أخرى لاحقًا."));
    }
  }

  @override
  Future<Either<Failure, Uint8List>> textToSpeech(
      {required ElevenlabsRequestBodyEntity bodyEnity}) async {
    try {
      Uint8List bytes = await elevenlabsApi.post(
          body: ElevenlabsRequestBodyModel.fromEntity(bodyEnity).toJson());
      return right(bytes);
    } on ApiException catch (e) {
      return left(ServerFailure(message: e.message));
    } on CustomException catch (e) {
      return left(ServerFailure(message: e.message));
    } catch (e) {
      return left(
          ServerFailure(message: "حدث خطأ غير متوقع، حاول مرة أخرى لاحقًا."));
    }
  }
}
