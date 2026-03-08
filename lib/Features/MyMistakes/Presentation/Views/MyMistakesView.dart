import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:sintir/Core/services/get_it_Service.dart';
import 'package:sintir/Core/widgets/CustomAppBar.dart';
import 'package:sintir/Core/widgets/CustomButton.dart';
import 'package:sintir/Features/MyMistakes/Domain/Repo/MyMistakesRepo.dart';
import 'package:sintir/Features/MyMistakes/Presentation/Manager/cubit/get_my_mistakes_cubit.dart';
import 'package:sintir/Features/MyMistakes/Presentation/Views/CreateOwnExamView.dart';
import 'package:sintir/Features/MyMistakes/Presentation/Views/Widgets/GetMyMistakesViewBody.dart';
import 'package:sintir/constant.dart';
import 'package:sintir/locale_keys.dart';

class MyMistakesView extends StatelessWidget {
  const MyMistakesView({super.key});
  static const routeName = '/MyMistakesView';

  @override
  Widget build(BuildContext context) {
    // Keep the provider here so it's scoped to this flow
    return BlocProvider(
      create: (context) => GetMyMistakesCubit(
        myMistakesRepo: getIt.get<MyMistakesRepo>(),
      ),
      child: Scaffold(
        appBar: CustomAppBar(appBartitle: LocaleKeys.myMistakesAppbar),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: Builder(
          builder: (innerContext) {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Custombutton(
                text: "إنشاء إمتحانك الخاص",
                color: KMainColor,
                textColor: Colors.white,
                onPressed: () {
                  GoRouter.of(innerContext).push(
                    CreateOwnExamView.routeName,
                    extra: BlocProvider.of<GetMyMistakesCubit>(innerContext),
                  );
                },
              ),
            );
          },
        ),
        body: const GetMyMistakesViewBody(),
      ),
    );
  }
}
