// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:sintir/Core/services/get_it_Service.dart';
import 'package:sintir/Core/utils/Backend_EndPoints.dart';
import 'package:sintir/Core/widgets/CustomAppBar.dart';
import 'package:sintir/Features/Auth/Domain/Entities/StudentExtraDataEntity.dart';
import 'package:sintir/Features/Auth/Domain/Entities/UserEntity.dart';
import 'package:sintir/Features/Auth/Domain/Repos/AuthRepo.dart';
import 'package:sintir/Features/Auth/StudentPresentation/manager/student_sign_up_cubit/student_sign_up_cubit.dart';
import 'package:sintir/Features/Auth/StudentPresentation/views/widgets/StudentSignupViewBody.dart';
import 'package:sintir/locale_keys.dart';

class StudentSignupView extends StatefulWidget {
  const StudentSignupView({super.key});
  static const routeName = "/StudentSignupView";

  @override
  State<StudentSignupView> createState() => _StudentSignupViewState();
}

class _StudentSignupViewState extends State<StudentSignupView> {
  UserEntity userEntity = UserEntity(
      uid: "",
      firstName: "",
      lastName: "",
      email: "",
      address: "",
      phoneNumber: "",
      deviceId: "",
      studentExtraDataEntity: StudentExtraDataEntity(
          educationLevel: "", birthDate: DateTime.now().toString()),
      gender: "",
      profilePicurl: "https://cdn-icons-png.flaticon.com/128/149/149071.png",
      status: BackendEndpoints.activeStatus,
      role: BackendEndpoints.studentRole,
      joinedDate: DateTime.now().toString(),
      fullName: "");
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => StudentSignUpCubit(getIt<AuthRepo>()),
      child: Scaffold(
        appBar: CustomAppBar(appBartitle: LocaleKeys.createAccount),
        body: Provider.value(
            value: userEntity, child: const StudentSignupViewBody()),
      ),
    );
  }
}
