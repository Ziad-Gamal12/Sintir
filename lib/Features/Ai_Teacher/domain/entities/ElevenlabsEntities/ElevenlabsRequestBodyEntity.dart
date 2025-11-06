import 'package:sintir/Features/Ai_Teacher/domain/entities/ElevenlabsEntities/ElevenlabsVoiceSettingsEntity.dart';

class ElevenlabsRequestBodyEntity {
  final String text;
  final String modelId;
  final Elevenlabsvoicesettingsentity voiceSettings;

  ElevenlabsRequestBodyEntity(
      {required this.text, required this.modelId, required this.voiceSettings});
}
