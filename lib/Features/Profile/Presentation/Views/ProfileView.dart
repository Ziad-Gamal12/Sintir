import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sintir/Core/repos/CoursesRepo/CoursesRepo.dart';
import 'package:sintir/Core/services/get_it_Service.dart';
import 'package:sintir/Core/widgets/CustomAppBar.dart';
import 'package:sintir/Features/Profile/Presentation/Manager/ProfileCubit/ProfileCubit.dart';
import 'package:sintir/Features/Profile/Presentation/Views/Widgets/ProfileViewBody.dart';

class ProfileView extends StatelessWidget {
  const ProfileView({super.key});
  static const String routeName = "/ProfileView";
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ProfileCubit(
        coursesrepo: getIt<Coursesrepo>(),
      ),
      child: const Scaffold(
        appBar: CustomAppBar(
          appBartitle: "الملف الشخصي",
        ),
        body: ProfileViewBody(),
      ),
    );
  }
}
