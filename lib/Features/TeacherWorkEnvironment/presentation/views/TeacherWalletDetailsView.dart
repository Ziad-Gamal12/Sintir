import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sintir/Core/helper/GetUserData.dart';
import 'package:sintir/Core/services/get_it_Service.dart';
import 'package:sintir/Core/widgets/CustomAppBar.dart';
import 'package:sintir/Core/widgets/SensitivePageWrapper.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/domain/Repos/TeacherLiveWalletRepo.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/domain/Repos/WithDrawalTeacherBalanceRepo.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/Widgets/TeacherWalletDetailsViewWidgets/TeacherWalletDetailsViewBody.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/manager/WithDrawTeacherBalanceCubit/WithDrawTeacherBalanceCubit.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/manager/teacher_wallet_cubit/teacher_wallet_cubit.dart';
import 'package:sintir/locale_keys.dart';

class TeacherWalletDetailsView extends StatelessWidget {
  const TeacherWalletDetailsView({super.key});
  static const routeName = '/TeacherWalletDetailsView';
  @override
  Widget build(BuildContext context) {
    final teacherId = getUserData().uid;

    return SensitivePageWrapper(
      requireBiometric: true,
      inactivityTimeout: const Duration(minutes: 5),
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => WithDrawTeacherBalanceCubit(
              withdrawalRepo: getIt<WithDrawalTeacherBalanceRepo>(),
            ),
          ),
          // Same live wallet source as the work environment screen.
          BlocProvider(
            create: (context) => TeacherWalletCubit(
              walletRepo: getIt<TeacherLiveWalletRepo>(),
              teacherId: teacherId,
            )..watchWallet(),
          ),
        ],
        child: Scaffold(
          appBar: CustomAppBar(appBartitle: LocaleKeys.walletDetailsTitle),
          body: TeacherWalletDetailsViewBody(teacherId: teacherId),
        ),
      ),
    );
  }
}
