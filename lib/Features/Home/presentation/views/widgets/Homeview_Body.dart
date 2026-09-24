// ignore_for_file: use_build_context_synchronously, file_names

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:sintir/Core/helper/GetUserData.dart';
import 'package:sintir/Core/widgets/AwesomeDialog.dart';
import 'package:sintir/Core/widgets/customRefreshWidget.dart';
import 'package:sintir/Features/ChoosingUserKind/Presentation/views/ChoosingUserKindView.dart';
import 'package:sintir/Features/Favorites/presentation/views/Manager/favourites_cubit/favourites_cubit.dart';
import 'package:sintir/Features/Home/Extensions/HomeDataFetch.dart';
import 'package:sintir/Features/Home/presentation/manager/get_courses_cubit/get_courses_cubit.dart';
import 'package:sintir/Features/Home/presentation/manager/get_user_data_cubit/get_user_data_cubit.dart';
import 'package:sintir/Features/Home/presentation/views/widgets/HomeViewBodyBuilder.dart';

class HomeViewBody extends StatefulWidget {
  const HomeViewBody({super.key});

  @override
  State<HomeViewBody> createState() => _HomeViewBodyState();
}

class _HomeViewBodyState extends State<HomeViewBody> {
  @override
  void initState() {
    super.initState();
    _initFetchData();
  }

  void _initFetchData() {
    final getUserDataCubit = context.read<GetUserDataCubit>();
    if (getUserDataCubit.isUserDataFetched) return;
    getUserDataCubit.fetchUserData();
  }

  Future<void> _fetchHomeData() async {
    if (!mounted) return;
    final coursesCubit = context.read<GetCoursesCubit>();
    final favCubit = context.read<FavouritesCubit>();
    final uid = getUserData().uid;

    try {
      await Future.wait([
        coursesCubit.fetchAllHomeData(context),
        favCubit.getFavorites(userId: uid),
      ]);
    } catch (e) {
      debugPrint('Home data fetch failed: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<GetUserDataCubit, GetUserDataState>(
      listener: (context, state) {
        if (state is GetUserDataFailure) {
          if (!mounted) return;
          errordialog(context, state.errmessage, btnOkOnPress: () {
            GoRouter.of(context)
                .pushReplacement(ChoosingUserKindView.routeName);
          }).show();
        } else if (state is GetUserDataSuccess) {
          _fetchHomeData();
        }
      },
      child: Customrefreshwidget(
        onRefresh: () async {
          context.read<GetUserDataCubit>().fetchUserData();
        },
        child: HomeViewBodyBuilder(),
      ),
    );
  }
}
