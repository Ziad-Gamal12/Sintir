import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:sintir/Core/widgets/CustomButton.dart';
import 'package:sintir/Features/Ai_Teacher/presentation/managers/ai_teacher_cubit/ai_teacher_cubit.dart';
import 'package:sintir/Features/Ai_Teacher/presentation/views/widgets/CustomTextLoadingWidget.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;

class CustomAiTeacherStatesActionsWidget extends StatefulWidget {
  const CustomAiTeacherStatesActionsWidget({
    super.key,
  });

  @override
  State<CustomAiTeacherStatesActionsWidget> createState() =>
      _CustomAiTeacherStatesActionsWidgetState();
}

class _CustomAiTeacherStatesActionsWidgetState
    extends State<CustomAiTeacherStatesActionsWidget> {
  stt.SpeechToText speech = stt.SpeechToText();
  bool isTalking = false;

  @override
  void dispose() {
    speech.stop();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AiTeacherCubit, AiTeacherState>(
      builder: (context, state) {
        if (state is AiTeacherExtractTextLoading) {
          return const CustomTextLoadingWidget(
            text: "جاري أستخراج النص ...",
          );
        } else if (state is AiTeacherChatWithGeminiLoading) {
          return const CustomTextLoadingWidget(
            text: "جاري التحليل ...",
          );
        } else if (state is AiTeacherTextToSpeechLoading) {
          return const CustomTextLoadingWidget(
            text: "جاري أعداد الرد ...",
          );
        } else if (state is AiTeacherSpeechToTextLoading) {
          return const CustomTextLoadingWidget(
            text: "جاري الأستماع...",
          );
        } else if (state is AiTeacherInitial) {
          return Custombutton(
                  text: "اختر pdf",
                  color: Colors.white,
                  textColor: Colors.black,
                  onPressed: () {
                    context.read<AiTeacherCubit>().extractTextFromPDF();
                  })
              .animate()
              .moveY(begin: 20, duration: 800.ms, delay: 800.ms)
              .fadeIn(
                duration: 600.ms,
              );
        } else {
          return Center(
            child: GestureDetector(
              onLongPressCancel: () async {
                await speech.stop();
                setState(() {
                  isTalking = false;
                });
              },
              onLongPress: () {
                context.read<AiTeacherCubit>().speechToText(speech: speech);
                setState(() {
                  isTalking = true;
                });
              },
              child: CircleAvatar(
                backgroundColor: Colors.white,
                child: Padding(
                  padding: EdgeInsets.all(isTalking == true ? 30 : 15),
                  child: const Icon(
                    FontAwesomeIcons.microphone,
                    color: Colors.black,
                  ),
                ),
              ),
            ),
          );
        }
      },
    );
  }
}
