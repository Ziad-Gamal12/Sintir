import 'package:sintir/Core/entities/ElevenlabsEntities/ElevenlabsVoiceSettingsEntity.dart';

class ElevenlabsRequestBodyEntity {
  final String text;
  final String modelId;
  final Elevenlabsvoicesettingsentity voiceSettings;

  ElevenlabsRequestBodyEntity(
      {required this.text, required this.modelId, required this.voiceSettings});
}
