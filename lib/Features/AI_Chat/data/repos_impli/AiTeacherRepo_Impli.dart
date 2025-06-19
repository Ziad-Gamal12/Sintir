import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:sintir/Core/errors/Failures.dart';
import 'package:sintir/Core/services/PickerAssetsService.dart';
import 'package:sintir/Features/AI_Chat/domain/Repos/AITeacherRepo.dart';
import 'package:syncfusion_flutter_pdf/pdf.dart';

class AiTeacherRepoImpli implements AiTeacherRepo {
  final Pickerassetsservice pickerassetsservice;
  AiTeacherRepoImpli({required this.pickerassetsservice});
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
}
