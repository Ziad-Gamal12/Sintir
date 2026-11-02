import 'package:flutter/material.dart';
import 'package:sintir/Features/MyTransactions/Presentation/Manager/my_transactions_cubit/my_transactions_cubit.dart';
import 'package:sintir/Features/MyTransactions/Presentation/Views/Widgets/filter_sheet/filter_choice.dart';
import 'package:sintir/Features/MyTransactions/Presentation/Views/Widgets/filter_sheet/filter_section_title.dart';
import 'package:sintir/locale_keys.dart';

class FilterDateSection extends StatelessWidget {
  const FilterDateSection({
    super.key,
    required this.range,
    required this.onChanged,
    required this.onCustom,
  });
  final TransactionsDateRange range;
  final ValueChanged<TransactionsDateRange> onChanged;
  final VoidCallback onCustom;

  @override
  Widget build(BuildContext context) => Column(
    crossAxisAlignment: CrossAxisAlignment.stretch,
    children: [
      FilterSectionTitle(title: LocaleKeys.transactionsDateRange),
      Wrap(
        spacing: 4,
        runSpacing: 4,
        children: [
          FilterChoice(
            label: LocaleKeys.transactionsToday,
            selected: range == TransactionsDateRange.today,
            onTap: () => onChanged(TransactionsDateRange.today),
          ),
          FilterChoice(
            label: LocaleKeys.transactionsLast7Days,
            selected: range == TransactionsDateRange.last7Days,
            onTap: () => onChanged(TransactionsDateRange.last7Days),
          ),
          FilterChoice(
            label: LocaleKeys.transactionsLast30Days,
            selected: range == TransactionsDateRange.last30Days,
            onTap: () => onChanged(TransactionsDateRange.last30Days),
          ),
          FilterChoice(
            label: LocaleKeys.transactionsCustomRange,
            selected: range == TransactionsDateRange.custom,
            icon: Icons.calendar_month_outlined,
            onTap: onCustom,
          ),
        ],
      ),
    ],
  );
}
