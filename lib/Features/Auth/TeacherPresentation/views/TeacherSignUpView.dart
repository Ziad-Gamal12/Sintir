// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:sintir/Core/services/get_it_Service.dart';
import 'package:sintir/Core/utils/Backend_EndPoints.dart';
import 'package:sintir/Core/widgets/CustomAppBar.dart';
import 'package:sintir/Features/Auth/Domain/Entities/TeacherExtraDataEntity.dart';
import 'package:sintir/Features/Auth/Domain/Entities/TeacherWalletEntity.dart';
import 'package:sintir/Features/Auth/Domain/Entities/UserEntity.dart';
import 'package:sintir/Features/Auth/Domain/Repos/AuthRepo.dart';
import 'package:sintir/Features/Auth/TeacherPresentation/manager/TeacherSignUP/teacher_sign_up_cubit.dart';
import 'package:sintir/Features/Auth/TeacherPresentation/views/widgets/TeacherSignUpViewBody.dart';

class TeacherSignUpView extends StatefulWidget {
  const TeacherSignUpView({super.key});
  static const routeName = "/TeacherSignUpView";

  @override
  State<TeacherSignUpView> createState() => _TeacherSignUpViewState();
}

class _TeacherSignUpViewState extends State<TeacherSignUpView> {
  late UserEntity userEntity;
  @override
  void initState() {
    userEntity = UserEntity(
        uid: "",
        firstName: "",
        lastName: "",
        email: "",
        deviceId: "",
        address: "",
        phoneNumber: "",
        teacherExtraDataEntity: TeacherExtraDataEntity(
            subject: "",
            workExperience: "",
            wallet: TeacherWalletEntity(
                walletId: DateTime.now().microsecondsSinceEpoch,
                teacherId: "",
                balance: 0,
                totalEarned: 0,
                payoutPending: 0,
                currency: "EGP",
                status: BackendEndpoints.walletSuspended,
                createdAt: DateTime.now().toIso8601String(),
                updatedAt: DateTime.now().toIso8601String())),
        gender: "",
        profilePicurl: "https://cdn-icons-png.flaticon.com/128/149/149071.png",
        status: BackendEndpoints.pendingStatus,
        role: BackendEndpoints.teacherRole,
        joinedDate: DateTime.now().toString(),
        fullName: "");
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => TeacherSignUpCubit(getIt<AuthRepo>()),
      child: Scaffold(
        appBar: CustomAppBar(appBartitle: "انشاء حساب"),
        body: Provider.value(
            value: userEntity, child: const TeacherSignUpViewBody()),
      ),
    );
  }
}
