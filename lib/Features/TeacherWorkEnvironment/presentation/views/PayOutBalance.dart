import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sintir/Core/repos/PaymobPayoutRepo/PaymobPayoutRepo.dart';
import 'package:sintir/Core/services/get_it_Service.dart';
import 'package:sintir/Core/widgets/CustomAppBar.dart';
import 'package:sintir/Features/Auth/Domain/Entities/TeacherWalletEntity.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/Widgets/TeacherWalletDetailsViewWidgets/PayOutBalanceWidgets/PayOutBalanceBody.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/manager/payout_cubit/payout_cubit.dart';

class PayOutBalance extends StatelessWidget {
  const PayOutBalance({super.key, required this.walletEntity});
  final TeacherWalletEntity walletEntity;
  static const String routeName = "/PayOutBalance";
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => PayoutCubit(
        payoutRepo: getIt<PaymobPayoutRepo>(),
      ),
      child: Scaffold(
        appBar: CustomAppBar(appBartitle: "سحب رصيد المحفظة"),
        body: PayOutBalanceBody(walletEntity: walletEntity),
      ),
    );
  }
}
