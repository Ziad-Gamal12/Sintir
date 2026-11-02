import 'package:flutter/material.dart';
import 'package:sintir/Features/MyTransactions/Presentation/Views/Widgets/filter_sheet/filter_method_tile.dart';
import 'package:sintir/Features/MyTransactions/Presentation/Views/Widgets/filter_sheet/filter_section_title.dart';
import 'package:sintir/locale_keys.dart';

class FilterMethodsSection extends StatelessWidget {
  const FilterMethodsSection({
    super.key,
    required this.values,
    required this.onChanged,
  });
  final Set<String> values;
  final void Function(String, bool) onChanged;

  @override
  Widget build(BuildContext context) {
    final width = (MediaQuery.sizeOf(context).width - 64) / 2;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        FilterSectionTitle(
          title: LocaleKeys.transactionsPaymentMethods,
          helper: LocaleKeys.transactionsMultipleChoice,
        ),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: [
            SizedBox(
              width: width,
              child: FilterMethodTile(
                label: LocaleKeys.transactionsBankCard,
                icon: Icons.credit_card,
                id: 'card',
                values: values,
                onChanged: onChanged,
              ),
            ),
            SizedBox(
              width: width,
              child: FilterMethodTile(
                label: LocaleKeys.transactionsWallet,
                icon: Icons.account_balance_wallet_outlined,
                id: 'wallet',
                values: values,
                onChanged: onChanged,
              ),
            ),
            SizedBox(
              width: width,
              child: FilterMethodTile(
                label: LocaleKeys.transactionsFawry,
                icon: Icons.storefront_outlined,
                id: 'fawry',
                values: values,
                onChanged: onChanged,
              ),
            ),
            SizedBox(
              width: width,
              child: FilterMethodTile(
                label: LocaleKeys.transactionsCash,
                icon: Icons.payments_outlined,
                id: 'cash',
                values: values,
                onChanged: onChanged,
              ),
            ),
            FilterMethodTile(
              label: LocaleKeys.transactionsDirectTransfer,
              icon: Icons.swap_horiz,
              id: 'transfer',
              values: values,
              onChanged: onChanged,
              full: true,
            ),
          ],
        ),
      ],
    );
  }
}
