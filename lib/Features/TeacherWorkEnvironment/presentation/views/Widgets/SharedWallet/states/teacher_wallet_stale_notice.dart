import 'package:flutter/material.dart';
import 'package:sintir/Core/utils/textStyles.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/Widgets/TeacherWorkenvironmentviewWidgets/TeacherWorkEnvironmentTheme.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/Widgets/SharedWallet/states/teacher_wallet_retry_button.dart';
import 'package:sintir/locale_keys.dart';

/// Warning strip under the wallet card when live updates stopped: the card
/// still shows the last known balance, and this offers a reconnect.
class TeacherWalletStaleNotice extends StatelessWidget {
  const TeacherWalletStaleNotice({super.key, required this.onRetry});

  final VoidCallback onRetry;

  @override
  Widget build(BuildContext context) {
    final tokens = WorkEnvironmentThemeExtension.of(context);

    return Semantics(
      liveRegion: true,
      child: Container(
        padding: const EdgeInsetsDirectional.fromSTEB(12, 4, 4, 4),
        decoration: BoxDecoration(
          color: tokens.warningBackground,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: tokens.warningBorder),
        ),
        child: Row(
          children: [
            Icon(
              Icons.sync_problem_rounded,
              size: 18,
              color: tokens.warningForeground,
            ),
            const SizedBox(width: 8),
            Expanded(
              child: Text(
                LocaleKeys.walletStaleNotice,
                style: AppTextStyles(
                  context,
                ).regular12.copyWith(color: tokens.warningForeground),
              ),
            ),
            TeacherWalletRetryButton(onPressed: onRetry),
          ],
        ),
      ),
    );
  }
}
