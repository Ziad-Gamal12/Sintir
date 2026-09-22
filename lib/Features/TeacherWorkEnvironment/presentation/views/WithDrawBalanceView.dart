import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:sintir/Core/services/get_it_Service.dart';
import 'package:sintir/Core/widgets/CustomAppBar.dart';
import 'package:sintir/Features/Auth/Domain/Entities/TeacherWalletEntity.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/domain/Repos/WithDrawalTeacherBalanceRepo.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/Widgets/WithDrawBalance/WithDrawBalanceViewBody.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/manager/WithDrawTeacherBalanceCubit/WithDrawTeacherBalanceCubit.dart';
import 'package:sintir/locale_keys.dart';

class WithDrawBalanceView extends StatelessWidget {
  const WithDrawBalanceView({super.key, required this.currentWallet});
  final TeacherWalletEntity currentWallet;
  static const routeName = "/WithDrawBalanceView";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(appBartitle: LocaleKeys.withdrawBalance),
      body: BlocProvider(
        create: (_) => WithDrawTeacherBalanceCubit(
            withdrawalRepo: getIt<WithDrawalTeacherBalanceRepo>()),
        child: Provider.value(
            value: currentWallet, child: WithDrawBalanceViewBody()),
      ),
    );
  }
}
