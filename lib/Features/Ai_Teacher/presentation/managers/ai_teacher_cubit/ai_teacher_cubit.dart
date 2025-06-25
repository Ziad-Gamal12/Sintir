// ignore_for_file: depend_on_referenced_packages

import 'dart:io';
import 'dart:typed_data';

import 'package:bloc/bloc.dart';
import 'package:just_audio/just_audio.dart';
import 'package:meta/meta.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sintir/Core/entities/ElevenlabsEntities/ElevenlabsRequestBodyEntity.dart';
import 'package:sintir/Core/entities/ElevenlabsEntities/ElevenlabsVoiceSettingsEntity.dart';
import 'package:sintir/Core/entities/gemini/GeminiContent.dart';
import 'package:sintir/Core/entities/gemini/GeminiResponse.dart';
import 'package:sintir/Features/Ai_Teacher/domain/Repos/AITeacherRepo.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;

part 'ai_teacher_state.dart';

class AiTeacherCubit extends Cubit<AiTeacherState> {
  AiTeacherCubit({required this.aiteacherrepo}) : super(AiTeacherInitial());
  final AiTeacherRepo aiteacherrepo;
  List<GeminiContent> geminiContents = [];

  Future<void> extractTextFromPDF() async {
    emit(AiTeacherExtractTextLoading());
    final result = await aiteacherrepo.extractTextFromFile();
    result.fold((failure) {
      emit(AiTeacherExtractTextFailure(errmessage: failure.message));
    }, (text) {
      emit(AiTeacherExtractTextSuccess(text: text));
    });
  }

  Future<void> chatWithGemini() async {
    emit(AiTeacherChatWithGeminiLoading());
    final result = await aiteacherrepo.chatWithGemini(body: geminiContents);
    result.fold((failure) {
      emit(AiTeacherChatWithGeminiFailure(errmessage: failure.message));
    }, (geminiResponse) async {
      emit(AiTeacherChatWithGeminiSuccess(geminiResponse: geminiResponse));
    });
  }

  void textToSpeech({required String text, required AudioPlayer player}) async {
    emit(AiTeacherTextToSpeechLoading());
    final result = await aiteacherrepo.textToSpeech(
        bodyEnity: ElevenlabsRequestBodyEntity(
            text: text,
            modelId: "eleven_multilingual_v1",
            voiceSettings: Elevenlabsvoicesettingsentity(
                stability: 0.5, similarityboost: 1)));
    result.fold((failure) {
      emit(AiTeacherTextToSpeechFailure(errmessage: failure.message));
    }, (bytes) {
      speak(bytes, player);
      emit(AiTeacherTextToSpeechSuccess());
    });
  }

  void speechToText({required stt.SpeechToText speech}) async {
    emit(AiTeacherSpeechToTextLoading());
    try {
      bool available = await speech.initialize(
        onError: (error) =>
            emit(AiTeacherSpeechToTextFailure(errmessage: error.errorMsg)),
      );
      if (available) {
        speech.listen(
            localeId: 'ar_EG',
            onResult: (result) {
              String text = "";
              for (var element in result.alternates) {
                text += element.recognizedWords;
              }
              emit(AiTeacherSpeechToTextSuccess(text: text));
            });
      } else {
        emit(AiTeacherSpeechToTextFailure(
            errmessage: "لا يمكن التواصل مع الخادم"));
      }
    } catch (e) {
      emit(AiTeacherSpeechToTextFailure(errmessage: e.toString()));
    }
  }

  void speak(Uint8List bytes, AudioPlayer player) async {
    final tempDir = await getTemporaryDirectory();
    final file = File('${tempDir.path}/tts_audio.mp3');
    await file.writeAsBytes(bytes);
    await player.setFilePath(file.path);
    await player.play();
  }
}
