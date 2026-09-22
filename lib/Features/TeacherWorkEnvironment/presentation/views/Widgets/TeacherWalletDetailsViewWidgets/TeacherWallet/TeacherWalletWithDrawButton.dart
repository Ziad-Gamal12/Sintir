import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:sintir/Core/widgets/CustomButton.dart';
import 'package:sintir/Features/Auth/Domain/Entities/TeacherWalletEntity.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/WithDrawBalanceView.dart';
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
              GoRouter.of(context)
                  .push(WithDrawBalanceView.routeName, extra: wallet);
              // showCustomBottomSheet(
              //     child: IntrinsicHeight(
              //       child: MultiBlocProvider(
              //         providers: [
              //           BlocProvider(
              //             create: (context) => PayoutCubit(
              //               payoutRepo: getIt<PayoutRepo>(),
              //             ),
              //           ),
              //           BlocProvider(
              //             create: (context) => WithDrawTeacherBalanceCubit(
              //               transcationsRepo: getIt<TeacherTranscationsRepo>(),
              //               teacherWalletRepo: getIt<TeacherWalletRepo>(),
              //               paymobPayoutRepo: getIt<PayoutRepo>(),
              //             ),
              //           ),
              //         ],
              //         child: PayOutBalanceBody(
              //           currentWallet: wallet,
              //         ),
              //       ),
              //     ),
              //     context: context);
            }));
  }
}
