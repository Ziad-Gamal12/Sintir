// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sintir/Core/repos/CoursesRepo/CoursesRepo.dart';
import 'package:sintir/Core/services/FireBase/FirebaseAuth_Service.dart';
import 'package:sintir/Core/services/get_it_Service.dart';
import 'package:sintir/Features/Auth/Domain/Repos/AuthRepo.dart';
import 'package:sintir/Features/Favorites/presentation/views/FavoritesView.dart';
import 'package:sintir/Features/Home/presentation/manager/cubit/bottom_nav_cubit.dart';
import 'package:sintir/Features/Home/presentation/manager/get_courses_cubit/get_courses_cubit.dart';
import 'package:sintir/Features/Home/presentation/manager/get_user_data_cubit/get_user_data_cubit.dart';
import 'package:sintir/Features/Home/presentation/views/widgets/BottomNavBar.dart';
import 'package:sintir/Features/Home/presentation/views/widgets/Homeview_Body.dart';
import 'package:sintir/Features/Profile/Presentation/Views/ProfileView.dart';
import 'package:sintir/Features/Search/Presentation/Views/SearchView.dart';

class Homeview extends StatefulWidget {
  const Homeview({super.key});
  static const String routeName = '/HomeView';

  @override
  State<Homeview> createState() => _HomeviewState();
}

class _HomeviewState extends State<Homeview> {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
            create: (context) =>
                GetCoursesCubit(coursesrepo: getIt<Coursesrepo>())),
        BlocProvider(
            create: (context) => GetUserDataCubit(
                authService: getIt<firebaseAuthService>(),
                authRepo: getIt<AuthRepo>())),
        BlocProvider(create: (context) => BottomNavCubit()),
      ],
      child: Builder(builder: (context) {
        return Scaffold(
          bottomNavigationBar: BottomNavBar(
            onPageChanged: (index) {
              context.read<BottomNavCubit>().changeIndex(index);
            },
          ),
          body: BlocBuilder<BottomNavCubit, BottomNavState>(
            builder: (context, state) {
              return SafeArea(
                  child: IndexedStack(
                      index: context.read<BottomNavCubit>().currentIndex,
                      children: context.read<BottomNavCubit>().screens));
            },
          ),
        );
      }),
    );
  }
}
