import 'package:sintir/Features/Ai_Teacher/domain/entities/ElevenlabsEntities/ElevenlabsVoiceSettingsEntity.dart';

class ElevenlabsvoicesettingsModel {
  final double stability;
  final double similarityboost;

  ElevenlabsvoicesettingsModel(
      {required this.stability, required this.similarityboost});
  factory ElevenlabsvoicesettingsModel.fromJson(Map<String, dynamic> json) {
    return ElevenlabsvoicesettingsModel(
      stability: json['stability'],
      similarityboost: json['similarity_boost'],
    );
  }
  factory ElevenlabsvoicesettingsModel.formEntity(
      {required Elevenlabsvoicesettingsentity entity}) {
    return ElevenlabsvoicesettingsModel(
      stability: entity.stability,
      similarityboost: entity.similarityboost,
    );
  }
  Elevenlabsvoicesettingsentity toEntity() {
    return Elevenlabsvoicesettingsentity(
      stability: stability,
      similarityboost: similarityboost,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'stability': stability,
      'similarity_boost': similarityboost,
    };
  }
}
