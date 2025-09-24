import 'package:collection/collection.dart';

class PromptTokensDetail {
  String? modality;
  int? tokenCount;

  PromptTokensDetail({this.modality, this.tokenCount});

  factory PromptTokensDetail.fromJson(Map<String, dynamic> json) {
    return PromptTokensDetail(
      modality: json['modality'] as String?,
      tokenCount: json['tokenCount'] as int?,
    );
  }

  Map<String, dynamic> toJson() => {
        'modality': modality,
        'tokenCount': tokenCount,
      };

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    if (other is! PromptTokensDetail) return false;
    final mapEquals = const DeepCollectionEquality().equals;
    return mapEquals(other.toJson(), toJson());
  }

  @override
  int get hashCode => modality.hashCode ^ tokenCount.hashCode;
}
