import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sintir/Core/entities/CourseEntities/CourseTestItemEntities/QuestionMistakeEntity.dart';
import 'package:sintir/Core/widgets/CustomEmptyWidget.dart';
import 'package:sintir/Core/widgets/CustomErrorWidget.dart';
import 'package:sintir/Features/MyMistakes/Presentation/Manager/get_my_mistakes_cubit/get_my_mistakes_cubit.dart';
import 'package:sintir/Features/MyMistakes/Presentation/Views/Widgets/GetMyMistakesViewBodyListViewLoading.dart';
import 'package:sintir/Features/MyMistakes/Presentation/Views/Widgets/MyMistakeCardItem.dart';
import 'package:sintir/locale_keys.dart';

class GetMyMistakesViewBodyListView extends StatefulWidget {
  const GetMyMistakesViewBodyListView(
      {super.key, required this.scrollController});
  final ScrollController scrollController;
  @override
  State<GetMyMistakesViewBodyListView> createState() =>
      _GetMyMistakesViewBodyListViewState();
}

class _GetMyMistakesViewBodyListViewState
    extends State<GetMyMistakesViewBodyListView> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GetMyMistakesCubit, GetMyMistakesState>(
        builder: (context, state) {
      List<QuestionMistakeEntity> myMistakes =
          context.read<GetMyMistakesCubit>().myMistakes;
      if (state is GetMyMistakesFailure) {
        return Center(child: CustomErrorWidget(errormessage: state.errmessage));
      } else if (state is GetMyMistakesLoading &&
          myMistakes.isEmpty &&
          state.isPaginate == false) {
        return const GetMyMistakesViewBodyListViewLoading();
      } else if (state is GetMyMistakesSuccess && myMistakes.isEmpty) {
        return CustomEmptyWidget(
          text: LocaleKeys.emptyContent,
        );
      } else {
        return ListView.builder(
          controller: widget.scrollController,
          itemCount: state is GetMyMistakesLoading && state.isPaginate
              ? myMistakes.length + 1
              : myMistakes.length,
          itemBuilder: (context, index) => Padding(
            padding: const EdgeInsets.only(bottom: 20),
            child: index == myMistakes.length
                ? const GetMyMistakesViewBodyListViewLoading()
                : MyMistakeCardItem(
                    mistake: myMistakes[index],
                  ),
          ),
        );
      }
    });
  }
}
