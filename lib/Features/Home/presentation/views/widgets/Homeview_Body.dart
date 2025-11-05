import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sintir/Core/widgets/AwesomeDialog.dart';
import 'package:sintir/Core/widgets/CustomListORGridTextHeader.dart';
import 'package:sintir/Core/widgets/customRefreshWidget.dart';
import 'package:sintir/Features/Home/presentation/manager/get_courses_cubit/get_courses_cubit.dart';
import 'package:sintir/Features/Home/presentation/manager/get_user_data_cubit/get_user_data_cubit.dart';
import 'package:sintir/Features/Home/presentation/views/widgets/HomeHeader.dart';
import 'package:sintir/Features/Home/presentation/views/widgets/popularCoursesSection.dart';
import 'package:sintir/Features/Home/presentation/views/widgets/recentCoursesSection.dart';
import 'package:sintir/constant.dart';

class HomeViewBody extends StatefulWidget {
  const HomeViewBody({super.key});

  @override
  State<HomeViewBody> createState() => _HomeViewBodyState();
}

class _HomeViewBodyState extends State<HomeViewBody> {
  final TextEditingController homeSearchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _initFetchData();
  }

  void _initFetchData() async {
    final getUserDataCubit = context.read<GetUserDataCubit>();
    if (getUserDataCubit.isUserDataFetched) return;
    getUserDataCubit.getUserData();
  }

  @override
  void dispose() {
    super.dispose();
    homeSearchController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<GetUserDataCubit, GetUserDataState>(
      listener: (context, state) {
        if (state is GetUserDataFailure) {
          errordialog(context, state.errmessage).show();
        } else if (state is GetUserDataSuccess) {
          context.read<GetCoursesCubit>().getRecentCourses(isPaginate: false);
          context.read<GetCoursesCubit>().getPopularCourses(isPaginate: false);
        }
      },
      child: Customrefreshwidget(
        onRefresh: () async {
          context.read<GetCoursesCubit>().handleRefresh();
        },
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: KHorizontalPadding,
          ),
          child: CustomScrollView(
            slivers: [
              SliverToBoxAdapter(
                  child: HomeHeader(
                controller: homeSearchController,
              )),
              const SliverToBoxAdapter(child: SizedBox(height: 20)),
              const PopularCoursesSection(),
              const SliverToBoxAdapter(child: SizedBox(height: 20)),
              SliverToBoxAdapter(
                child: Column(
                  children: [
                    CustomListORGridTextHeader(text: "أحدث الكورسات"),
                    const SizedBox(height: 10),
                  ],
                ),
              ),
              const RecentCoursesSection(),
            ],
          ),
        ),
      ),
    );
  }
}
