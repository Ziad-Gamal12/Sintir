import 'package:flutter/material.dart';
import 'package:sintir/Features/MyTransactions/Presentation/Views/Widgets/styles/transactions_style_mapper.dart';
import 'package:sintir/locale_keys.dart';

class FilterApplyButton extends StatelessWidget {
  const FilterApplyButton({
    super.key,
    required this.count,
    required this.onPressed,
  });
  final int count;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) => SizedBox(
    width: double.infinity,
    height: 48,
    child: FilledButton.icon(
      style: FilledButton.styleFrom(
        backgroundColor: TransactionsStyleMapper.primary(Theme.of(context)),
        foregroundColor: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
      ),
      onPressed: count == 0 ? null : onPressed,
      icon: const Icon(Icons.done_all),
      label: Text(
        count == 0
            ? LocaleKeys.transactionsNoMatches
            : LocaleKeys.transactionsApplyFilters(count),
      ),
    ),
  );
}
