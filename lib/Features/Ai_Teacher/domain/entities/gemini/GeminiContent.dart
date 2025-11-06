import 'package:sintir/Features/Ai_Teacher/domain/entities/gemini/GeminiContentPart.dart';

class GeminiContent {
  final List<GeminiContentPart>? parts;
  final String? role;

  const GeminiContent({this.parts, this.role});
}
