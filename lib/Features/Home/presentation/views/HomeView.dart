// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sintir/Core/repos/CoursesRepo/CoursesRepo.dart';
import 'package:sintir/Core/responsive/breakpoints.dart';
import 'package:sintir/Core/services/FireBase/FirebaseAuth_Service.dart';
import 'package:sintir/Core/services/get_it_Service.dart';
import 'package:sintir/Features/Auth/Domain/Repos/AuthRepo.dart';
import 'package:sintir/Features/Home/presentation/manager/bottom_nav_cubit/bottom_nav_cubit.dart';
import 'package:sintir/Features/Home/presentation/manager/get_courses_cubit/get_courses_cubit.dart';
import 'package:sintir/Features/Home/presentation/manager/get_user_data_cubit/get_user_data_cubit.dart';
import 'package:sintir/Features/Home/presentation/views/widgets/BottomNavBar.dart';
import 'package:sintir/Features/Home/presentation/views/widgets/HomeNavigationDrawer.dart';
import 'package:sintir/Features/Home/presentation/views/widgets/Homeview_Body.dart';
import 'package:sintir/Features/MyCourses/Presentation/Views/MyCoursesView.dart';
import 'package:sintir/Features/Profile/Presentation/Views/ProfileView.dart';
import 'package:sintir/Features/Search/Presentation/Views/SearchView.dart';

class Homeview extends StatefulWidget {
  const Homeview({super.key});
  static const String routeName = '/HomeView';

  @override
  State<Homeview> createState() => _HomeviewState();
}

class _HomeviewState extends State<Homeview> {
  static final List<Widget Function()> _builders = [
    () => const HomeViewBody(),
    () => const SearchView(),
    () => MyCoursesView(isPopUp: false),
    () => const ProfileView(),
  ];

  final Map<int, Widget> _cache = {};
  final GlobalKey _pagesKey = GlobalKey();

  Widget _screen(int i) => _cache.putIfAbsent(i, () => _builders[i]());
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) =>
              GetCoursesCubit(coursesrepo: getIt<Coursesrepo>()),
        ),
        BlocProvider(
          create: (context) => GetUserDataCubit(
            authService: getIt<firebaseAuthService>(),
            authRepo: getIt<AuthRepo>(),
          ),
        ),
        BlocProvider(create: (context) => BottomNavCubit()),
      ],
      child: Builder(
        builder: (context) {
          void onPageChanged(int index) {
            context.read<BottomNavCubit>().changeIndex(index);
          }

          final pages = KeyedSubtree(
            key: _pagesKey,
            child: BlocBuilder<BottomNavCubit, BottomNavState>(
              builder: (context, state) {
                final cubit = context.read<BottomNavCubit>();
                return IndexedStack(
                  index: cubit.currentIndex,
                  children: List.generate(_builders.length, (i) {
                    return cubit.visited.contains(i)
                        ? _screen(i)
                        : const SizedBox.shrink();
                  }),
                );
              },
            ),
          );

          if (context.hasSideNavigation) {
            return Scaffold(
              body: SafeArea(
                bottom: false,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    HomeNavigationDrawer(onPageChanged: onPageChanged),
                    Expanded(child: pages),
                  ],
                ),
              ),
            );
          }

          return Scaffold(
            extendBody: true,
            bottomNavigationBar: BottomNavBar(onPageChanged: onPageChanged),
            body: MediaQuery.removePadding(
              context: context,
              removeBottom: false,
              child: SafeArea(bottom: true, child: pages),
            ),
          );
        },
      ),
    );
  }
}
