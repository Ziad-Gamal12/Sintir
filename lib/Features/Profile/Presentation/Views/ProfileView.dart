import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sintir/Core/services/get_it_Service.dart';
import 'package:sintir/Core/widgets/CustomAppBar.dart';
import 'package:sintir/Features/Profile/Domain/Repos/PersonalDetailsRepo.dart';
import 'package:sintir/Features/Profile/Presentation/Manager/user_personal_details_cubit/user_personal_details_cubit.dart';
import 'package:sintir/Features/Profile/Presentation/Views/Widgets/ProfileViewBody.dart';

class ProfileView extends StatelessWidget {
  const ProfileView({super.key});
  static const String routeName = "/ProfileView";
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => UserPersonalDetailsCubit(
        personalDetailsRepo: getIt.get<PersonalDetailsRepo>(),
      ),
      child: Scaffold(
        appBar: CustomAppBar(
          appBartitle: "الملف الشخصي",
          isPopUp: false,
        ),
        body: const ProfileViewBody(),
      ),
    );
  }
}
