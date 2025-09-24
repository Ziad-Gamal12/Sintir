import 'package:collection/collection.dart';

class CandidatesTokensDetail {
  String? modality;
  int? tokenCount;

  CandidatesTokensDetail({this.modality, this.tokenCount});

  factory CandidatesTokensDetail.fromJson(Map<String, dynamic> json) {
    return CandidatesTokensDetail(
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
    if (other is! CandidatesTokensDetail) return false;
    final mapEquals = const DeepCollectionEquality().equals;
    return mapEquals(other.toJson(), toJson());
  }

  @override
  int get hashCode => modality.hashCode ^ tokenCount.hashCode;
}
