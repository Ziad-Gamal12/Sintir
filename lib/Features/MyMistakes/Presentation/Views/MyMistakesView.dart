import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sintir/Core/services/get_it_Service.dart';
import 'package:sintir/Core/widgets/CustomAppBar.dart';
import 'package:sintir/Features/MyMistakes/Domain/Repo/MyMistakesRepo.dart';
import 'package:sintir/Features/MyMistakes/Presentation/Manager/cubit/get_my_mistakes_cubit.dart';
import 'package:sintir/Features/MyMistakes/Presentation/Views/Widgets/GetMyMistakesViewBody.dart';

class MyMistakesView extends StatelessWidget {
  const MyMistakesView({super.key});
  static const routeName = '/MyMistakesView';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(appBartitle: "أخطائي"),
      body: BlocProvider(
        create: (context) => GetMyMistakesCubit(
          myMistakesRepo: getIt.get<MyMistakesRepo>(),
        ),
        child: const GetMyMistakesViewBody(),
      ),
    );
  }
}
