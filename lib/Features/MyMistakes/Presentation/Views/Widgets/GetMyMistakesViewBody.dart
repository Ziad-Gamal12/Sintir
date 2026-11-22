import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sintir/Core/helper/GetUserData.dart';
import 'package:sintir/Core/responsive/breakpoints.dart';
import 'package:sintir/Features/MyMistakes/Presentation/Manager/get_my_mistakes_cubit/get_my_mistakes_cubit.dart';
import 'package:sintir/Features/MyMistakes/Presentation/Views/Widgets/GetMyMistakesViewBodyListView.dart';
import 'package:sintir/constant.dart';

class GetMyMistakesViewBody extends StatefulWidget {
  const GetMyMistakesViewBody({super.key});

  @override
  State<GetMyMistakesViewBody> createState() => _GetMyMistakesViewBodyState();
}

class _GetMyMistakesViewBodyState extends State<GetMyMistakesViewBody> {
  late ScrollController scrollController;

  static const double _floatingActionSpace = 72;

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
        context.read<GetMyMistakesCubit>().hasMore &&
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
    return LayoutBuilder(
      builder: (context, constraints) {
        final gutter = ContentWidth.gutter(
          constraints.maxWidth,
          ContentWidth.reading,
          min: KHorizontalPadding,
        );
        return GetMyMistakesViewBodyListView(
          scrollController: scrollController,
          padding: EdgeInsets.fromLTRB(
            gutter,
            KVerticalPadding,
            gutter,
            KVerticalPadding +
                _floatingActionSpace +
                MediaQuery.paddingOf(context).bottom,
          ),
        );
      },
    );
  }
}
