import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:sintir/Core/helper/GetUserData.dart';
import 'package:sintir/Core/services/get_it_Service.dart';
import 'package:sintir/Core/widgets/CustomAppBar.dart';
import 'package:sintir/Core/widgets/SensitivePageWrapper.dart';
import 'package:sintir/Features/Auth/Domain/Entities/TeacherWalletEntity.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/domain/Repos/TeacherLiveWalletRepo.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/domain/Repos/WithDrawalTeacherBalanceRepo.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/Widgets/SharedWallet/withdraw/teacher_withdraw_access_gate.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/Widgets/WithDrawBalance/WithDrawBalanceViewBody.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/manager/WithDrawTeacherBalanceCubit/WithDrawTeacherBalanceCubit.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/manager/teacher_wallet_cubit/teacher_wallet_cubit.dart';
import 'package:sintir/locale_keys.dart';

class WithDrawBalanceView extends StatelessWidget {
  const WithDrawBalanceView({super.key, required this.currentWallet});
  final TeacherWalletEntity currentWallet;
  static const routeName = "/WithDrawBalanceView";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(appBartitle: LocaleKeys.withdrawBalance),
      body: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (_) => WithDrawTeacherBalanceCubit(
              withdrawalRepo: getIt<WithDrawalTeacherBalanceRepo>(),
            ),
          ),
          // Live status, so the form locks if the wallet is deactivated
          // while the teacher is on this screen.
          BlocProvider(
            create: (_) => TeacherWalletCubit(
              walletRepo: getIt<TeacherLiveWalletRepo>(),
              teacherId: getUserData().uid,
            )..watchWallet(),
          ),
        ],
        child: Provider.value(
          value: currentWallet,
          // The gate sits outside the sensitive wrapper: an inactive wallet
          // gets the explanation without a biometric prompt first.
          child: TeacherWithdrawAccessGate(
            initialWallet: currentWallet,
            child: SensitivePageWrapper(
              hardBlockOnRisk: true,
              requireBiometric: true,
              inactivityTimeout: const Duration(minutes: 5),
              child: WithDrawBalanceViewBody(),
            ),
          ),
        ),
      ),
    );
  }
}
