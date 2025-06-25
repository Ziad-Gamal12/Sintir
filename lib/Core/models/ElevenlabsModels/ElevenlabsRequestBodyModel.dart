import 'package:sintir/Core/entities/ElevenlabsEntities/ElevenlabsRequestBodyEntity.dart';
import 'package:sintir/Core/models/ElevenlabsModels/ElevenlabsvoicesettingsModel.dart';

class ElevenlabsRequestBodyModel {
  final String text;
  final String modelId;
  final Map<String, dynamic> voiceSettings;

  ElevenlabsRequestBodyModel(
      {required this.text, required this.modelId, required this.voiceSettings});
  factory ElevenlabsRequestBodyModel.fromJson(Map<String, dynamic> json) {
    return ElevenlabsRequestBodyModel(
      text: json['text'],
      modelId: json['model_id'],
      voiceSettings: json['voice_settings'],
    );
  }
  factory ElevenlabsRequestBodyModel.fromEntity(
      ElevenlabsRequestBodyEntity entity) {
    return ElevenlabsRequestBodyModel(
      text: entity.text,
      modelId: entity.modelId,
      voiceSettings:
          ElevenlabsvoicesettingsModel.formEntity(entity: entity.voiceSettings)
              .toJson(),
    );
  }
  ElevenlabsRequestBodyEntity toEntity() {
    return ElevenlabsRequestBodyEntity(
      text: text,
      modelId: modelId,
      voiceSettings:
          ElevenlabsvoicesettingsModel.fromJson(voiceSettings).toEntity(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'text': text,
      'model_id': modelId,
      'voice_settings': voiceSettings,
    };
  }
}
