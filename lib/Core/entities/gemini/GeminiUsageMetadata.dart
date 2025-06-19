import 'package:sintir/Core/entities/gemini/GeminiCandidateTokenInfo.dart';
import 'package:sintir/Core/entities/gemini/PromptTokenInfo.dart';

class GeminiUsageMetadata {
  final int? promptTokenCount;
  final int? candidatesTokenCount;
  final int? totalTokenCount;
  final List<PromptTokenInfo>? promptTokensDetails;
  final List<GeminiCandidateTokenInfo>? candidatesTokensDetails;

  const GeminiUsageMetadata({
    this.promptTokenCount,
    this.candidatesTokenCount,
    this.totalTokenCount,
    this.promptTokensDetails,
    this.candidatesTokensDetails,
  });
}
