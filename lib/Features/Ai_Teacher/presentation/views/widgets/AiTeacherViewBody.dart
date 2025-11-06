// ignore_for_file: must_be_immutable, file_names

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:just_audio/just_audio.dart';
import 'package:sintir/Core/widgets/AwesomeDialog.dart';
import 'package:sintir/Features/Ai_Teacher/domain/entities/gemini/GeminiContent.dart';
import 'package:sintir/Features/Ai_Teacher/domain/entities/gemini/GeminiContentPart.dart';
import 'package:sintir/Features/Ai_Teacher/presentation/managers/ai_teacher_cubit/ai_teacher_cubit.dart';
import 'package:sintir/Features/Ai_Teacher/presentation/views/widgets/CustomAiTeacherBodyColourfulBackground.dart';
import 'package:sintir/Features/Ai_Teacher/presentation/views/widgets/CustomAiTeacherStatesActionsWidget.dart';
import 'package:sintir/Features/Ai_Teacher/presentation/views/widgets/CustomCirclarContainer.dart';

class AiTeacherViewBody extends StatefulWidget {
  const AiTeacherViewBody({super.key});

  @override
  State<AiTeacherViewBody> createState() => _AiTeacherViewBodyState();
}

class _AiTeacherViewBodyState extends State<AiTeacherViewBody> {
  TextEditingController customAiChatController = TextEditingController();
  late AudioPlayer player;

  @override
  void initState() {
    player = AudioPlayer();
    super.initState();
  }

  @override
  void dispose() {
    player.dispose();
    customAiChatController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AiTeacherCubit, AiTeacherState>(
      listener: (context, state) {
        aiTeacherBlocListenerMethod(state, context);
      },
      builder: (context, state) {
        return Stack(
          children: [
            Positioned.fill(child: CustomAiTeacherBodyColourfulBackground()),
            const Positioned(
                top: 150, left: 0, right: 0, child: CustomCirclarContainer()),
            const Positioned(
                left: 16,
                right: 16,
                bottom: 30,
                child: CustomAiTeacherStatesActionsWidget())
          ],
        );
      },
    );
  }

  void aiTeacherBlocListenerMethod(AiTeacherState state, BuildContext context) {
    if (state is AiTeacherExtractTextFailure) {
      errordialog(context, state.errmessage).show();
    } else if (state is AiTeacherExtractTextSuccess) {
      GeminiContent geminiContent = GeminiContent(role: "user", parts: [
        GeminiContentPart(
            text:
                '''You are a teacher. Please explain and Summarize the following text to me as if I am a student and you are my teacher.
                   Make the explanation clear, structured, and easy to understand.
                   Speak in the same language as the original text. Do not translate it.
                   Here is the text:${state.text}'''),
      ]);
      context.read<AiTeacherCubit>().geminiContents.add(geminiContent);
      context.read<AiTeacherCubit>().chatWithGemini();
    } else if (state is AiTeacherChatWithGeminiSuccess) {
      state.geminiResponse.candidates![0].content!.parts!.map((e) {
        context
            .read<AiTeacherCubit>()
            .textToSpeech(text: e.text ?? "", player: player);
      }).toList();
    } else if (state is AiTeacherChatWithGeminiFailure) {
      errordialog(context, state.errmessage).show();
    } else if (state is AiTeacherTextToSpeechFailure) {
      errordialog(context, state.errmessage).show();
    } else if (state is AiTeacherSpeechToTextSuccess) {
      GeminiContent geminiContent = GeminiContent(
          role: "user", parts: [GeminiContentPart(text: state.text)]);
      context.read<AiTeacherCubit>().geminiContents.add(geminiContent);
      context.read<AiTeacherCubit>().chatWithGemini();
    } else if (state is AiTeacherSpeechToTextFailure) {
      errordialog(context, state.errmessage).show();
    }
  }
}
