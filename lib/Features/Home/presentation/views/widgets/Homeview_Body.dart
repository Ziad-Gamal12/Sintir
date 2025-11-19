// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:sintir/Core/helper/GetUserData.dart';
import 'package:sintir/Core/widgets/AwesomeDialog.dart';
import 'package:sintir/Core/widgets/customRefreshWidget.dart';
import 'package:sintir/Features/Auth/Domain/Entities/UserEntity.dart';
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

class _HomeViewBodyState extends State<HomeViewBody>
    with AutomaticKeepAliveClientMixin {
  UserEntity user = getUserData();
  @override
  void initState() {
    super.initState();
    _initFetchData();
  }

  void _initFetchData() async {
    final getUserDataCubit = context.read<GetUserDataCubit>();
    if (getUserDataCubit.isUserDataFetched) return;
    getUserDataCubit.fetchUserData();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return BlocListener<GetUserDataCubit, GetUserDataState>(
      listener: (context, state) async {
        if (state is GetUserDataFailure) {
          if (mounted) {
            errordialog(context, state.errmessage, btnOkOnPress: () {
              GoRouter.of(context)
                  .pushReplacement(ChoosingUserKindView.routeName);
            }).show();
          }
        } else if (state is GetUserDataSuccess) {
          final cubit = context.read<GetCoursesCubit>();
          final favCubit = context.read<FavouritesCubit>();
          await Future.wait([
            cubit.fetchAllHomeData(context),
            favCubit.getFavorites(userId: user.uid)
          ]);
        }
      },
      child: Customrefreshwidget(
        onRefresh: () async {
          final getUserDataCubit = context.read<GetUserDataCubit>();
          getUserDataCubit.fetchUserData();
        },
        child: const HomeViewBodyBuilder(),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
