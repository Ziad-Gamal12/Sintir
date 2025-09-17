import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:sintir/Features/Ai_Teacher/presentation/managers/ai_teacher_cubit/ai_teacher_cubit.dart';

class CustomCirclarContainer extends StatefulWidget {
  const CustomCirclarContainer({super.key});

  @override
  State<CustomCirclarContainer> createState() => _CustomCirclarContainerState();
}

class _CustomCirclarContainerState extends State<CustomCirclarContainer> {
  bool isTalking = false;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AiTeacherCubit, AiTeacherState>(
      listener: (context, state) {
        if (state is AiTeacherTextToSpeechSuccess) {
          isTalking = true;
        } else {
          isTalking = false;
        }
      },
      builder: (context, state) {
        if (isTalking == false) {
          return SizedBox(
            width: MediaQuery.sizeOf(context).width * .4,
            child: AspectRatio(
              aspectRatio: 1,
              child: LottieBuilder.asset(
                "assets/LottieFiles/thinkingBot.json",
                fit: BoxFit.fill,
              ),
            ),
          );
        } else {
          return LottieBuilder.asset("assets/LottieFiles/speakingBot.json");
        }
      },
    );
  }
}
