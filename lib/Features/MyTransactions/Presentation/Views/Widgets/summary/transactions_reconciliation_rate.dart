import 'package:flutter/material.dart';
import 'package:intl/intl.dart' as intl;
import 'package:sintir/Core/utils/textStyles.dart';
import 'package:sintir/Features/MyTransactions/Presentation/Views/Widgets/styles/transactions_style_mapper.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/domain/Enums/TransactionsStatusEnum.dart';
import 'package:sintir/locale_keys.dart';

class TransactionsReconciliationRate extends StatelessWidget {
  const TransactionsReconciliationRate({super.key, required this.rate});
  final double rate;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final locale = Localizations.localeOf(context).languageCode;
    final value = intl.NumberFormat('0.0', locale).format(rate);
    final success = TransactionsStyleMapper.statusColor(
      theme,
      TransactionsStatus.success,
    );
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          LocaleKeys.transactionsReconciliationRate,
          style: AppTextStyles(
            context,
          ).regular12.copyWith(color: theme.colorScheme.onSurfaceVariant),
        ),
        const SizedBox(height: 3),
        Text(
          '$value%',
          style: AppTextStyles(
            context,
          ).bold20.copyWith(color: theme.colorScheme.onSurface),
        ),
        Text(
          LocaleKeys.transactionsThisWeek,
          style: AppTextStyles(context).regular11.copyWith(color: success),
        ),
      ],
    );
  }
}
