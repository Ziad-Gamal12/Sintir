import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sintir/Core/services/get_it_Service.dart';
import 'package:sintir/Features/Ai_Teacher/domain/Repos/AITeacherRepo.dart';
import 'package:sintir/Features/Ai_Teacher/presentation/managers/ai_teacher_cubit/ai_teacher_cubit.dart';
import 'package:sintir/Features/Ai_Teacher/presentation/views/widgets/AiTeacherViewBody.dart';

class AiTeacherview extends StatelessWidget {
  const AiTeacherview({super.key});
  static const routeName = '/Aichatview';
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          AiTeacherCubit(aiteacherrepo: getIt<AiTeacherRepo>()),
      child: const Scaffold(
        body: AiTeacherViewBody(),
      ),
    );
  }
}
