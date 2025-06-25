import 'package:collection/collection.dart';
import 'package:sintir/Core/entities/gemini/GeminiResponse.dart';

import 'candidate.dart';
import 'usage_metadata.dart';

class Gemini {
  List<Candidate>? candidates;
  UsageMetadata? usageMetadata;
  String? modelVersion;
  String? responseId;

  Gemini({
    this.candidates,
    this.usageMetadata,
    this.modelVersion,
    this.responseId,
  });

  factory Gemini.fromJson(Map<String, dynamic> json) => Gemini(
        candidates: (json['candidates'] as List<dynamic>?)
            ?.map((e) => Candidate.fromJson(e as Map<String, dynamic>))
            .toList(),
        usageMetadata: json['usageMetadata'] == null
            ? null
            : UsageMetadata.fromJson(
                json['usageMetadata'] as Map<String, dynamic>),
        modelVersion: json['modelVersion'] as String?,
        responseId: json['responseId'] as String?,
      );

  Map<String, dynamic> toJson() => {
        'candidates': candidates?.map((e) => e.toJson()).toList(),
        'usageMetadata': usageMetadata?.toJson(),
        'modelVersion': modelVersion,
        'responseId': responseId,
      };
  GeminiResponse toEntity() =>
      GeminiResponse(candidates: candidates?.map((e) => e.toEntity()).toList());
  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    if (other is! Gemini) return false;
    final mapEquals = const DeepCollectionEquality().equals;
    return mapEquals(other.toJson(), toJson());
  }

  @override
  int get hashCode =>
      candidates.hashCode ^
      usageMetadata.hashCode ^
      modelVersion.hashCode ^
      responseId.hashCode;
}
