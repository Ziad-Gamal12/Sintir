import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sintir/Core/entities/CourseEntities/CourseTestItemEntities/TestResulteEntity.dart';
import 'package:sintir/Core/helper/GetUserData.dart';
import 'package:sintir/Features/MyResults/Presentation/Manager/cubit/my_results_cubit.dart';
import 'package:sintir/Features/MyResults/Presentation/Views/Widgets/MyResultsViewBodyListView.dart';
import 'package:sintir/constant.dart';

class MyResultsViewBody extends StatefulWidget {
  const MyResultsViewBody({super.key});

  @override
  State<MyResultsViewBody> createState() => _MyResultsViewBodyState();
}

class _MyResultsViewBodyState extends State<MyResultsViewBody> {
  late ScrollController scrollController;
  List<TestResultEntity> myResults = [];
  bool hasMore = true;

  @override
  void initState() {
    super.initState();
    String userUID = getUserData().uid;
    scrollController = ScrollController();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context
          .read<MyResultsCubit>()
          .getMyResults(isPaginate: false, userId: userUID);
      scrollController.addListener(() {
        if (_canFetchMore()) {
          context
              .read<MyResultsCubit>()
              .getMyResults(isPaginate: true, userId: userUID);
        }
      });
    });
  }

  bool _canFetchMore() {
    if (scrollController.position.pixels >=
            scrollController.position.maxScrollExtent - 200 &&
        hasMore &&
        context.read<MyResultsCubit>().state is! GetMyResultsLoading) {
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
    return BlocListener<MyResultsCubit, MyResultsState>(
      listener: (context, state) {
        if (state is GetMyResultsSuccess) {
          if (state.getMyResultsResponseEntity.isPaginate) {
            myResults.addAll(state.getMyResultsResponseEntity.results);
          } else {
            myResults = state.getMyResultsResponseEntity.results;
          }
          hasMore = state.getMyResultsResponseEntity.hasMore;
          setState(() {});
        }
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(
            horizontal: KHorizontalPadding, vertical: KVerticalPadding),
        child: MyResultsViewBodyListView(
          myResults: myResults,
          scrollController: scrollController,
        ),
      ),
    );
  }
}
