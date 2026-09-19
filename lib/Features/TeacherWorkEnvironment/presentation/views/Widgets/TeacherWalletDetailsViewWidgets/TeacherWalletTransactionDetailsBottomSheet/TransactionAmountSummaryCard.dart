import 'package:flutter/material.dart';
import 'package:sintir/Core/utils/textStyles.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/domain/Entities/TeacherWalletTransactionItemRequirements.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/Widgets/TeacherWalletDetailsViewWidgets/TeacherWalletTransactions/TransactionStatusBadge.dart';

class TransactionAmountSummaryCard extends StatelessWidget {
  const TransactionAmountSummaryCard({super.key, required this.requirements});

  final TeacherWalletTransactionItemRequirements requirements;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textStyles = AppTextStyles(context);
    final isDarkMode = theme.brightness == Brightness.dark;
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 16),
      decoration: BoxDecoration(
          color: isDarkMode ? Colors.grey.shade900 : Colors.grey.shade100,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
              color: isDarkMode ? Colors.grey.shade800 : Colors.grey.shade200)),
      child: Column(
        children: [
          Text(
            requirements.transactionTypeLabel,
            style: textStyles.regular12.copyWith(
              color: theme.textTheme.bodySmall?.color,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            requirements.amountLabel,
            style: textStyles.bold24.copyWith(color: theme.colorScheme.error),
          ),
          const SizedBox(height: 10),
          TransactionStatusBadge(
            label: requirements.statusLabel,
            color: requirements.statusColor,
          ),
        ],
      ),
    );
  }
}
