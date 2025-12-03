import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sintir/Core/helper/ShowBottomSheet.dart';
import 'package:sintir/Core/repos/PaymobPayoutRepo/PayoutRepo.dart';
import 'package:sintir/Core/repos/TranscationsRepo/TranscationsRepo.dart';
import 'package:sintir/Core/services/get_it_Service.dart';
import 'package:sintir/Core/widgets/CustomButton.dart';
import 'package:sintir/Features/Auth/Domain/Entities/TeacherWalletEntity.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/domain/Repos/TeacherWalletRepo.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/Widgets/TeacherWalletDetailsViewWidgets/PayOutBalanceWidgets/PayOutBalanceBody.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/manager/TransactionsCubit/TransactionsCubit.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/manager/payout_cubit/payout_cubit.dart';
import 'package:sintir/locale_keys.dart';

class WithDrawBalanceActionButton extends StatelessWidget {
  const WithDrawBalanceActionButton({
    super.key,
    required this.colorScheme,
    required this.wallet,
  });

  final ColorScheme colorScheme;
  final TeacherWalletEntity wallet;

  @override
  Widget build(BuildContext context) {
    return Custombutton(
        text: LocaleKeys.withdrawBalance,
        color: colorScheme.primary,
        textColor: colorScheme.onPrimary,
        onPressed: () {
          showCustomBottomSheet(
              child: IntrinsicHeight(
                child: MultiBlocProvider(
                  providers: [
                    BlocProvider(
                      create: (context) => PayoutCubit(
                        payoutRepo: getIt<PayoutRepo>(),
                      ),
                    ),
                    BlocProvider(
                      create: (context) => TransactionsCubit(
                        transcationsRepo: getIt<TranscationsRepo>(),
                        teacherWalletRepo: getIt<TeacherWalletRepo>(),
                        paymobPayoutRepo: getIt<PayoutRepo>(),
                      ),
                    ),
                  ],
                  child: PayOutBalanceBody(
                    currentWallet: wallet,
                  ),
                ),
              ),
              context: context);
        });
  }
}
