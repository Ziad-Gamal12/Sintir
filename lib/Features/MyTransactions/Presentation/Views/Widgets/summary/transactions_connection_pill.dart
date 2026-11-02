import 'package:flutter/material.dart';
import 'package:sintir/Core/utils/textStyles.dart';
import 'package:sintir/Features/MyTransactions/Presentation/Views/Widgets/styles/transactions_style_mapper.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/domain/Enums/TransactionsStatusEnum.dart';
import 'package:sintir/locale_keys.dart';

class TransactionsConnectionPill extends StatelessWidget {
  const TransactionsConnectionPill({super.key, required this.connected});
  final bool connected;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final color = connected
        ? TransactionsStyleMapper.statusColor(theme, TransactionsStatus.success)
        : theme.colorScheme.onSurfaceVariant;
    final surface = connected
        ? TransactionsStyleMapper.statusSurface(
            theme,
            TransactionsStatus.success,
          )
        : theme.colorScheme.surfaceContainerHighest;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 7),
      decoration: BoxDecoration(
        color: surface,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 7,
            height: 7,
            decoration: BoxDecoration(color: color, shape: BoxShape.circle),
          ),
          const SizedBox(width: 6),
          Text(
            connected
                ? LocaleKeys.transactionsSystemConnected
                : LocaleKeys.transactionsSystemConnecting,
            style: AppTextStyles(context).regular11.copyWith(color: color),
          ),
        ],
      ),
    );
  }
}
