import 'package:sintir/Core/entities/gemini/GeminiCandidate.dart';
import 'package:sintir/Core/entities/gemini/GeminiUsageMetadata.dart';

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
