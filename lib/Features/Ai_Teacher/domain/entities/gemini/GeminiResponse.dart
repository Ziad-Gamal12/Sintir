import 'package:sintir/Features/Ai_Teacher/domain/entities/gemini/GeminiCandidate.dart';
import 'package:sintir/Features/Ai_Teacher/domain/entities/gemini/GeminiUsageMetadata.dart';

class GeminiResponse {
  final List<GeminiCandidate>? candidates;
  final GeminiUsageMetadata? usageMetadata;
  final String? modelVersion;
  final String? responseId;

  const GeminiResponse({
    this.candidates,
    this.usageMetadata,
    this.modelVersion,
    this.responseId,
  });
}
