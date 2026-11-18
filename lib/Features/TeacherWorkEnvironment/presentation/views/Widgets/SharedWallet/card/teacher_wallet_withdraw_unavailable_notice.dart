import 'package:flutter/material.dart';
import 'package:sintir/Core/utils/textStyles.dart';
import 'package:sintir/Features/Auth/Domain/Entities/TeacherWalletStatus.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/Widgets/SharedWallet/utils/teacher_wallet_status_style.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/Widgets/TeacherWorkspace/TeachespaceEnvironmentTheme.dart';
import 'package:sintir/locale_keys.dart';

/// Replaces the withdraw button on wallets that can't withdraw, explaining
/// why instead of offering a dead action.
class TeacherWalletWithdrawUnavailableNotice extends StatelessWidget {
  const TeacherWalletWithdrawUnavailableNotice({
    super.key,
    required this.status,
  });

  final TeacherWalletStatus status;

  @override
  Widget build(BuildContext context) {
    final tokens = WorkEnvironmentThemeExtension.of(context);
    final textStyles = AppTextStyles(context);
    final foreground = status.foreground(tokens);

    return Semantics(
      container: true,
      liveRegion: true,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsetsDirectional.fromSTEB(12, 10, 12, 10),
        decoration: BoxDecoration(
          color: status.background(tokens),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: status.border(tokens)),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(status.lockIcon, size: 18, color: foreground),
            const SizedBox(width: 10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    LocaleKeys.walletWithdrawUnavailableTitle,
                    style: textStyles.semiBold13.copyWith(color: foreground),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    LocaleKeys.walletWithdrawUnavailableMessage,
                    style: textStyles.regular12.copyWith(
                      color: tokens.mutedText,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
