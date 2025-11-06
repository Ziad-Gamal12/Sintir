import 'package:sintir/Features/Ai_Teacher/domain/entities/gemini/GeminiContent.dart';

class GeminiCandidate {
  final GeminiContent? content;
  final String? finishReason;
  final double? avgLogprobs;

  const GeminiCandidate({this.content, this.finishReason, this.avgLogprobs});
}
