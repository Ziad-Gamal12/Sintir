import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:sintir/Core/services/get_it_Service.dart';
import 'package:sintir/Core/utils/textStyles.dart';
import 'package:sintir/Core/widgets/CustomAppBar.dart';
import 'package:sintir/Core/widgets/CustomButton.dart';
import 'package:sintir/Features/Course%20Management%20and%20Interaction%20Feature/presentation/views/courseTestView.dart';
import 'package:sintir/Features/MyMistakes/Domain/Repo/MyMistakesRepo.dart';
import 'package:sintir/Features/MyMistakes/Presentation/Manager/cubit/get_my_mistakes_cubit.dart';
import 'package:sintir/Features/MyMistakes/Presentation/Views/Widgets/GetMyMistakesViewBody.dart';
import 'package:sintir/constant.dart';
import 'package:sintir/locale_keys.dart';

class MyMistakesView extends StatelessWidget {
  const MyMistakesView({super.key});
  static const routeName = '/MyMistakesView';
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => GetMyMistakesCubit(
        myMistakesRepo: getIt.get<MyMistakesRepo>(),
      ),
      child: Scaffold(
        appBar: CustomAppBar(appBartitle: LocaleKeys.myMistakesAppbar),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton:
            BlocSelector<GetMyMistakesCubit, GetMyMistakesState, bool>(
          selector: (state) => state is GetMyMistakesSuccess,
          builder: (context, isSuccess) {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: isSuccess &&
                      context
                          .read<GetMyMistakesCubit>()
                          .myMistakesActiveQuestions
                          .isNotEmpty
                  ? Custombutton(
                      text: "إنشاء إمتحانك الخاص",
                      color: KMainColor,
                      textColor: Colors.white,
                      onPressed: () {
                        GoRouter.of(context).push(Coursetestview.routename,
                            extra: context
                                .read<GetMyMistakesCubit>()
                                .getCreatingMyExamRequirmentsEntity());
                      })
                  : Text(
                      "لا توجد أخطاء نشطة لإنشاء إمتحانك الخاص",
                      style: AppTextStyles(context).regular13,
                    ),
            );
          },
        ),
        body: const GetMyMistakesViewBody(),
      ),
    );
  }
}
