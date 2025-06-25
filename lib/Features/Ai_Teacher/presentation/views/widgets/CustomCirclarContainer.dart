import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
    List<Color> containerColors = [
      Colors.white,
      Colors.grey.shade200,
    ];

    return BlocConsumer<AiTeacherCubit, AiTeacherState>(
      listener: (context, state) {
        if (state is AiTeacherTextToSpeechSuccess) {
          isTalking = true;
        } else {
          isTalking = false;
        }
      },
      builder: (context, state) {
        var container = Container(
          height: 150,
          width: 150,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: containerColors,
            ),
            shape: BoxShape.circle,
          ),
        );
        return isTalking == true
            ? container
                .animate(
                    onPlay: (controller) => controller.repeat(reverse: true))
                .scaleXY(begin: 1, end: 1.15)
                .fade(begin: 1, end: 0.85)
            : container;
      },
    );
  }
}
