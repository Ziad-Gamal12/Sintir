// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sintir/Core/repos/CoursesRepo/CoursesRepo.dart';
import 'package:sintir/Core/services/get_it_Service.dart';
import 'package:sintir/Features/Auth/Domain/Repos/AuthRepo.dart';
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
  PageController pageController = PageController();
  List<Widget> screens = [
    const HomeViewBody(),
    const SearchView(),
    // const AiTeacherview(),
    const SizedBox(),
    const ProfileView()
  ];
  @override
  void dispose() {
    super.dispose();
    pageController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
            create: (context) =>
                GetCoursesCubit(coursesrepo: getIt<Coursesrepo>())),
        BlocProvider(
            create: (context) => GetUserDataCubit(authRepo: getIt<AuthRepo>()))
      ],
      child: Scaffold(
        bottomNavigationBar: BottomNavBar(
          pageController: pageController,
        ),
        body: SafeArea(
            child: PageView(
          controller: pageController,
          children: screens,
        )),
      ),
    );
  }
}
