import 'package:collection/collection.dart';
import 'package:sintir/Core/entities/gemini/GeminiContent.dart';

import 'part.dart';

class Content {
  List<Map<String, dynamic>>? parts;
  String? role;

  Content({this.parts, this.role});

  factory Content.fromJson(Map<String, dynamic> json) => Content(
        parts: (json['parts'] as List<dynamic>?)
            ?.map((e) => e as Map<String, dynamic>)
            .toList(),
        role: json['role'] as String?,
      );
  factory Content.fromEntity(GeminiContent entity) => Content(
      parts: entity.parts?.map((e) => Part.fromEntity(e).toJson()).toList(),
      role: entity.role);

  Map<String, dynamic> toJson() => {
        'parts': parts,
        'role': role,
      };
  GeminiContent toEntity() => GeminiContent(
      parts: parts?.map((e) {
        return Part.fromJson(e).toEntity();
      }).toList(),
      role: role);
  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    if (other is! Content) return false;
    final mapEquals = const DeepCollectionEquality().equals;
    return mapEquals(other.toJson(), toJson());
  }

  @override
  int get hashCode => parts.hashCode ^ role.hashCode;
}
