import 'package:flutter/material.dart';
import 'package:sintir/Features/MyTransactions/Presentation/Views/Widgets/filter_sheet/filter_choice.dart';
import 'package:sintir/Features/MyTransactions/Presentation/Views/Widgets/filter_sheet/filter_section_title.dart';
import 'package:sintir/locale_keys.dart';

class FilterSortSection extends StatelessWidget {
  const FilterSortSection({
    super.key,
    required this.newestFirst,
    required this.onChanged,
  });
  final bool newestFirst;
  final ValueChanged<bool> onChanged;

  @override
  Widget build(BuildContext context) => Column(
    children: [
      FilterSectionTitle(title: LocaleKeys.transactionsSort),
      Row(
        children: [
          Expanded(
            child: FilterChoice(
              label: LocaleKeys.transactionsNewest,
              selected: newestFirst,
              icon: Icons.south,
              onTap: () => onChanged(true),
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: FilterChoice(
              label: LocaleKeys.transactionsOldest,
              selected: !newestFirst,
              icon: Icons.north,
              onTap: () => onChanged(false),
            ),
          ),
        ],
      ),
    ],
  );
}
