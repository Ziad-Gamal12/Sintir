import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sintir/Core/helper/GetUserData.dart';
import 'package:sintir/Core/utils/Backend_EndPoints.dart';
import 'package:sintir/Features/MyResults/Presentation/Manager/cubit/my_results_cubit.dart';
import 'package:sintir/Features/MyResults/Presentation/Views/Widgets/results_body_content.dart';

class MyResultsViewBody extends StatefulWidget {
  const MyResultsViewBody({super.key});

  @override
  State<MyResultsViewBody> createState() => _MyResultsViewBodyState();
}

class _MyResultsViewBodyState extends State<MyResultsViewBody> {
  late final ScrollController scrollController;

  @override
  void initState() {
    super.initState();
    final user = getUserData();
    scrollController = ScrollController();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context
          .read<MyResultsCubit>()
          .getMyResults(isPaginate: false, userId: user.uid);
      scrollController.addListener(() {
        if (_canFetchMore()) {
          context
              .read<MyResultsCubit>()
              .getMyResults(isPaginate: true, userId: user.uid);
        }
      });
    });
  }

  bool _canFetchMore() {
    if (scrollController.hasClients &&
        scrollController.position.pixels >=
            scrollController.position.maxScrollExtent - 200 &&
        (context.read<MyResultsCubit>().state is GetMyResultsSuccess &&
            (context.read<MyResultsCubit>().state as GetMyResultsSuccess)
                .hasMore) &&
        context.read<MyResultsCubit>().state is! GetMyResultsLoading) {
      return true;
    }
    return false;
  }

  Future<void> _refresh() => context
      .read<MyResultsCubit>()
      .getMyResults(isPaginate: false, userId: getUserData().uid);

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isActive = getUserData().status == BackendEndpoints.activeStatus;
    return BlocBuilder<MyResultsCubit, MyResultsState>(
      buildWhen: (previous, current) =>
          previous.runtimeType != current.runtimeType ||
          current is GetMyResultsSuccess ||
          current is GetMyResultsFailure,
      builder: (context, state) => ResultsBodyContent(
          state: state,
          isActive: isActive,
          scrollController: scrollController,
          onRefresh: _refresh),
    );
  }
}
