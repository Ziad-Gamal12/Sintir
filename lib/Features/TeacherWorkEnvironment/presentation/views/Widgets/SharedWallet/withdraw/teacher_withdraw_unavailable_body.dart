import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:sintir/Core/utils/textStyles.dart';
import 'package:sintir/Features/Auth/Domain/Entities/TeacherWalletStatus.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/Widgets/SharedWallet/card/teacher_wallet_status_pill.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/Widgets/SharedWallet/utils/teacher_wallet_status_style.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/Widgets/TeacherWorkspace/TeachespaceEnvironmentTheme.dart';
import 'package:sintir/locale_keys.dart';

class TeacherWithdrawUnavailableBody extends StatelessWidget {
  const TeacherWithdrawUnavailableBody({super.key, required this.status});

  final TeacherWalletStatus status;

  @override
  Widget build(BuildContext context) {
    final tokens = WorkEnvironmentThemeExtension.of(context);
    final textStyles = AppTextStyles(context);
    final colorScheme = Theme.of(context).colorScheme;

    return Center(
      child: SingleChildScrollView(
        padding: const EdgeInsetsDirectional.symmetric(
          horizontal: 24,
          vertical: 32,
        ),
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 420),
          child: Semantics(
            liveRegion: true,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: 72,
                  height: 72,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: status.background(tokens),
                    border: Border.all(color: status.border(tokens)),
                  ),
                  child: Icon(
                    status.lockIcon,
                    size: 32,
                    color: status.foreground(tokens),
                  ),
                ),
                const SizedBox(height: 20),
                Text(
                  LocaleKeys.walletWithdrawUnavailableTitle,
                  textAlign: TextAlign.center,
                  style: textStyles.bold18.copyWith(
                    color: colorScheme.onSurface,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  LocaleKeys.walletWithdrawUnavailableMessage,
                  textAlign: TextAlign.center,
                  style: textStyles.regular14.copyWith(color: tokens.mutedText),
                ),
                const SizedBox(height: 16),
                TeacherWalletStatusPill(status: status),
                const SizedBox(height: 28),
                SizedBox(
                  width: double.infinity,
                  child: FilledButton(
                    style: FilledButton.styleFrom(
                      backgroundColor: colorScheme.primary,
                      foregroundColor: Colors.white,
                      minimumSize: const Size(0, 48),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    onPressed: () => context.pop(),
                    child: Text(
                      LocaleKeys.walletWithdrawUnavailableBack,
                      style: textStyles.semiBold14.copyWith(
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
