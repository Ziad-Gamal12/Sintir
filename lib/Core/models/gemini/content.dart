import 'package:collection/collection.dart';

import 'part.dart';

class Content {
  List<Part>? parts;
  String? role;

  Content({this.parts, this.role});

  factory Content.fromJson(Map<String, dynamic> json) => Content(
        parts: (json['parts'] as List<dynamic>?)
            ?.map((e) => Part.fromJson(e as Map<String, dynamic>))
            .toList(),
        role: json['role'] as String?,
      );

  Map<String, dynamic> toJson() => {
        'parts': parts?.map((e) => e.toJson()).toList(),
        'role': role,
      };

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
