import 'package:flutter/material.dart';
import 'package:sintir/Core/utils/textStyles.dart';
import 'package:sintir/Features/MyTransactions/Presentation/Views/Widgets/styles/transactions_style_mapper.dart';

class FilterChoice extends StatelessWidget {
  const FilterChoice({
    super.key,
    required this.label,
    required this.selected,
    required this.onTap,
    this.icon,
  });
  final String label;
  final bool selected;
  final VoidCallback onTap;
  final IconData? icon;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final color = TransactionsStyleMapper.primary(theme);
    return ChoiceChip(
      showCheckmark: false,
      selectedColor: color,
      backgroundColor: theme.brightness == Brightness.dark
          ? const Color(0xFF1E1E1E)
          : const Color(0xFFF8FAFC),
      side: BorderSide(
        color: selected ? color : TransactionsStyleMapper.cardBorder(theme),
      ),
      labelStyle: AppTextStyles(context).regular12.copyWith(
        color: selected ? Colors.white : theme.colorScheme.onSurface,
      ),
      label: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (icon != null) ...[Icon(icon, size: 16), const SizedBox(width: 5)],
          Text(label),
        ],
      ),
      selected: selected,
      onSelected: (_) => onTap(),
    );
  }
}
