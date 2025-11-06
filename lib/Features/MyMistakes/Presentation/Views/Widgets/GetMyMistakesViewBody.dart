import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sintir/Core/entities/CourseEntities/CourseTestItemEntities/ExamResultSolvedQuestionEntity.dart';
import 'package:sintir/Core/helper/GetUserData.dart';
import 'package:sintir/Features/MyMistakes/Presentation/Manager/cubit/get_my_mistakes_cubit.dart';
import 'package:sintir/Features/MyMistakes/Presentation/Views/Widgets/GetMyMistakesViewBodyListView.dart';
import 'package:sintir/constant.dart';

class GetMyMistakesViewBody extends StatefulWidget {
  const GetMyMistakesViewBody({super.key});

  @override
  State<GetMyMistakesViewBody> createState() => _GetMyMistakesViewBodyState();
}

class _GetMyMistakesViewBodyState extends State<GetMyMistakesViewBody> {
  late ScrollController scrollController;
  List<ExamResultSolvedQuestionEntity> myMistakes = [];
  bool hasMore = true;

  @override
  void initState() {
    super.initState();
    String userUID = getUserData().uid;
    scrollController = ScrollController();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context
          .read<GetMyMistakesCubit>()
          .getMyMistakes(isPaginate: false, userUID: userUID);
      scrollController.addListener(() {
        if (_canFetchMore()) {
          context
              .read<GetMyMistakesCubit>()
              .getMyMistakes(isPaginate: true, userUID: userUID);
        }
      });
    });
  }

  bool _canFetchMore() {
    if (scrollController.position.pixels >=
            scrollController.position.maxScrollExtent - 200 &&
        hasMore &&
        context.read<GetMyMistakesCubit>().state is! GetMyMistakesLoading) {
      return true;
    }
    return false;
  }

  @override
  void dispose() {
    super.dispose();
    scrollController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<GetMyMistakesCubit, GetMyMistakesState>(
        listener: (context, state) {
          if (state is GetMyMistakesSuccess) {
            if (state.getMyMistakesResponseEntity.isPaginate) {
              myMistakes.addAll(
                  state.getMyMistakesResponseEntity.questionsSolvedListEntity);
            } else {
              myMistakes =
                  state.getMyMistakesResponseEntity.questionsSolvedListEntity;
            }
            hasMore = state.getMyMistakesResponseEntity.hasMore;
            setState(() {});
          }
        },
        child: Padding(
          padding: const EdgeInsets.symmetric(
              horizontal: KHorizontalPadding, vertical: KVerticalPadding),
          child: GetMyMistakesViewBodyListView(
            myMistakes: myMistakes,
            scrollController: scrollController,
          ),
        ));
  }
}
