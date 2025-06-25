part of 'ai_teacher_cubit.dart';

@immutable
sealed class AiTeacherState {}

final class AiTeacherInitial extends AiTeacherState {}

final class AiTeacherExtractTextLoading extends AiTeacherState {}

final class AiTeacherExtractTextSuccess extends AiTeacherState {
  final String text;

  AiTeacherExtractTextSuccess({required this.text});
}

final class AiTeacherExtractTextFailure extends AiTeacherState {
  final String errmessage;

  AiTeacherExtractTextFailure({required this.errmessage});
}

final class AiTeacherChatWithGeminiLoading extends AiTeacherState {}

final class AiTeacherChatWithGeminiSuccess extends AiTeacherState {
  final GeminiResponse geminiResponse;

  AiTeacherChatWithGeminiSuccess({required this.geminiResponse});
}

final class AiTeacherChatWithGeminiFailure extends AiTeacherState {
  final String errmessage;

  AiTeacherChatWithGeminiFailure({required this.errmessage});
}

final class AiTeacherTextToSpeechLoading extends AiTeacherState {}

final class AiTeacherTextToSpeechSuccess extends AiTeacherState {}

final class AiTeacherTextToSpeechFailure extends AiTeacherState {
  final String errmessage;

  AiTeacherTextToSpeechFailure({required this.errmessage});
}

final class AiTeacherSpeechToTextLoading extends AiTeacherState {}

final class AiTeacherSpeechToTextSuccess extends AiTeacherState {
  final String text;

  AiTeacherSpeechToTextSuccess({required this.text});
}

final class AiTeacherSpeechToTextFailure extends AiTeacherState {
  final String errmessage;

  AiTeacherSpeechToTextFailure({required this.errmessage});
}
