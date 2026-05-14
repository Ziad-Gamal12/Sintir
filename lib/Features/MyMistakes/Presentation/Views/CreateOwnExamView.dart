import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sintir/Features/MyMistakes/Presentation/Manager/get_my_mistakes_cubit/get_my_mistakes_cubit.dart';
import 'package:sintir/Features/MyMistakes/Presentation/Views/Widgets/CreateOwnExamWidgets/CreateOwnExamViewBody.dart';

class CreateOwnExamView extends StatelessWidget {
  const CreateOwnExamView({super.key, required this.cubit});

  final GetMyMistakesCubit cubit;
  static const routeName = '/CreateOwnExamView';

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: cubit,
      child: const Scaffold(
        body: CreateOwnExamViewBody(),
      ),
    );
  }
}
