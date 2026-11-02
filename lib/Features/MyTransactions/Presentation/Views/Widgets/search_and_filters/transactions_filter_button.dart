import 'package:flutter/material.dart';
import 'package:sintir/Features/MyTransactions/Presentation/Views/Widgets/filter_sheet/transactions_filter_launcher.dart';
import 'package:sintir/Features/MyTransactions/Presentation/Views/Widgets/styles/transactions_style_mapper.dart';
import 'package:sintir/locale_keys.dart';

class TransactionsFilterButton extends StatelessWidget {
  const TransactionsFilterButton({super.key, required this.isActive});
  final bool isActive;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Stack(
      clipBehavior: Clip.none,
      children: [
        IconButton.filledTonal(
          style: IconButton.styleFrom(
            foregroundColor: TransactionsStyleMapper.primary(theme),
            backgroundColor: TransactionsStyleMapper.primary(
              theme,
            ).withValues(alpha: .1),
            side: BorderSide(color: TransactionsStyleMapper.cardBorder(theme)),
          ),
          tooltip: LocaleKeys.transactionsFilter,
          onPressed: () => showTransactionsFilter(context),
          icon: const Icon(Icons.tune_rounded),
        ),
        if (isActive)
          PositionedDirectional(
            top: 5,
            end: 5,
            child: Container(
              width: 8,
              height: 8,
              decoration: BoxDecoration(
                color: TransactionsStyleMapper.primary(theme),
                shape: BoxShape.circle,
              ),
            ),
          ),
      ],
    );
  }
}
