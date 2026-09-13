import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sintir/Core/helper/ShowBottomSheet.dart';
import 'package:sintir/Core/repos/PaymobPayoutRepo/PayoutRepo.dart';
import 'package:sintir/Core/repos/TeacherTranscationsRepo/TeacherTranscationsRepo.dart';
import 'package:sintir/Core/services/get_it_Service.dart';
import 'package:sintir/Core/widgets/CustomButton.dart';
import 'package:sintir/Features/Auth/Domain/Entities/TeacherWalletEntity.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/domain/Repos/TeacherWalletRepo.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/Widgets/TeacherWalletDetailsViewWidgets/PayOutBalanceWidgets/PayOutBalanceBody.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/manager/WithDrawTeacherBalanceCubit/WithDrawTeacherBalanceCubit.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/manager/payout_cubit/payout_cubit.dart';
import 'package:sintir/locale_keys.dart';

class TeacherWalletWithDrawButton extends StatelessWidget {
  const TeacherWalletWithDrawButton({
    super.key,
    required this.isCompact,
    required this.wallet,
  });

  final bool isCompact;
  final TeacherWalletEntity wallet;
  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final ColorScheme colorScheme = theme.colorScheme;
    return ConstrainedBox(
        constraints:
            BoxConstraints(maxWidth: isCompact ? double.infinity : 200),
        child: Custombutton(
            text: LocaleKeys.withdrawBalance,
            color: colorScheme.primary,
            textColor: Colors.white,
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
                          create: (context) => WithDrawTeacherBalanceCubit(
                            transcationsRepo: getIt<TeacherTranscationsRepo>(),
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
            }));
  }
}
