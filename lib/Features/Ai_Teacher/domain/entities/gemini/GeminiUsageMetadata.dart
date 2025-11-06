import 'package:sintir/Features/Ai_Teacher/domain/entities/gemini/GeminiCandidateTokenInfo.dart';
import 'package:sintir/Features/Ai_Teacher/domain/entities/gemini/PromptTokenInfo.dart';

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
