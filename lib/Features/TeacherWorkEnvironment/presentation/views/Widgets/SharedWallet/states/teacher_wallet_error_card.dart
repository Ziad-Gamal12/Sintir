import 'package:flutter/material.dart';
import 'package:sintir/Core/utils/textStyles.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/Widgets/TeacherWorkenvironmentviewWidgets/TeacherWorkEnvironmentTheme.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/Widgets/SharedWallet/states/teacher_wallet_retry_button.dart';

/// Shown in place of the wallet card when no wallet could be loaded at all.
/// Uses the wallet card's surface so the page layout doesn't jump.
class TeacherWalletErrorCard extends StatelessWidget {
  const TeacherWalletErrorCard({
    super.key,
    required this.message,
    required this.onRetry,
  });

  final String message;
  final VoidCallback onRetry;

  @override
  Widget build(BuildContext context) {
    final tokens = WorkEnvironmentThemeExtension.of(context);
    final onSurface = Theme.of(context).colorScheme.onSurface;

    return Container(
      width: double.infinity,
      padding: const EdgeInsetsDirectional.fromSTEB(16, 20, 16, 12),
      decoration: BoxDecoration(
        color: tokens.cardBackground,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: tokens.cardBorder),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            Icons.account_balance_wallet_outlined,
            size: 28,
            color: tokens.mutedText,
          ),
          const SizedBox(height: 8),
          Text(
            message,
            textAlign: TextAlign.center,
            style: AppTextStyles(context).regular13.copyWith(color: onSurface),
          ),
          const SizedBox(height: 4),
          TeacherWalletRetryButton(onPressed: onRetry),
        ],
      ),
    );
  }
}
