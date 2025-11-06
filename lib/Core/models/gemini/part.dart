import 'package:collection/collection.dart';
import 'package:sintir/Features/Ai_Teacher/domain/entities/gemini/GeminiContentPart.dart';

class Part {
  String? text;

  Part({this.text});

  factory Part.fromJson(Map<String, dynamic> json) => Part(
        text: json['text'] as String?,
      );
  factory Part.fromEntity(GeminiContentPart entity) => Part(text: entity.text);

  Map<String, dynamic> toJson() => {
        'text': text,
      };

  GeminiContentPart toEntity() => GeminiContentPart(text: text ?? "");
  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    if (other is! Part) return false;
    final mapEquals = const DeepCollectionEquality().equals;
    return mapEquals(other.toJson(), toJson());
  }

  @override
  int get hashCode => text.hashCode;
}
