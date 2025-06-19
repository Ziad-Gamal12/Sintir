import 'package:collection/collection.dart';

import 'content.dart';

class Candidate {
  Content? content;
  String? finishReason;
  double? avgLogprobs;

  Candidate({this.content, this.finishReason, this.avgLogprobs});

  factory Candidate.fromJson(Map<String, dynamic> json) => Candidate(
        content: json['content'] == null
            ? null
            : Content.fromJson(json['content'] as Map<String, dynamic>),
        finishReason: json['finishReason'] as String?,
        avgLogprobs: (json['avgLogprobs'] as num?)?.toDouble(),
      );

  Map<String, dynamic> toJson() => {
        'content': content?.toJson(),
        'finishReason': finishReason,
        'avgLogprobs': avgLogprobs,
      };

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    if (other is! Candidate) return false;
    final mapEquals = const DeepCollectionEquality().equals;
    return mapEquals(other.toJson(), toJson());
  }

  @override
  int get hashCode =>
      content.hashCode ^ finishReason.hashCode ^ avgLogprobs.hashCode;
}
