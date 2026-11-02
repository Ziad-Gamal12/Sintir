import 'package:flutter/material.dart';
import 'package:sintir/Core/utils/locale_formatter.dart';
import 'package:sintir/Core/utils/textStyles.dart';
import 'package:sintir/Features/MyTransactions/Presentation/Views/Widgets/styles/transactions_style_mapper.dart';

class TransactionStatusChip extends StatelessWidget {
  const TransactionStatusChip({
    super.key,
    required this.label,
    required this.count,
    required this.selected,
    required this.onTap,
    this.dotColor,
  });

  final String label;
  final int count;
  final bool selected;
  final VoidCallback onTap;
  final Color? dotColor;

  @override
  Widget build(BuildContext context) {
    final locale = Localizations.localeOf(context).languageCode;
    final theme = Theme.of(context);
    final primary = TransactionsStyleMapper.primary(theme);
    final allSelected = selected && dotColor == null;
    final foreground = allSelected ? Colors.white : theme.colorScheme.onSurface;
    return Padding(
      padding: const EdgeInsetsDirectional.only(end: 8),
      child: ChoiceChip(
        selected: selected,
        showCheckmark: false,
        backgroundColor: theme.brightness == Brightness.dark
            ? const Color(0xFF1E1E1E)
            : const Color(0xFFF8FAFC),
        selectedColor: allSelected ? primary : primary.withValues(alpha: .12),
        side: BorderSide(
          color: allSelected
              ? primary
              : TransactionsStyleMapper.cardBorder(theme),
        ),
        onSelected: (_) => onTap(),
        label: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (dotColor != null) ...[
              Container(
                width: 7,
                height: 7,
                decoration: BoxDecoration(
                  color: dotColor,
                  shape: BoxShape.circle,
                ),
              ),
              const SizedBox(width: 5),
            ],
            Text(
              label,
              style: AppTextStyles(
                context,
              ).regular12.copyWith(color: foreground),
            ),
            const SizedBox(width: 6),
            if (allSelected)
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                decoration: BoxDecoration(
                  color: primary,
                  shape: BoxShape.circle,
                ),
                child: Text(
                  LocaleFormatter.number(count, locale),
                  style: AppTextStyles(
                    context,
                  ).regular10.copyWith(color: Colors.white),
                ),
              )
            else
              Text(
                LocaleFormatter.number(count, locale),
                style: AppTextStyles(
                  context,
                ).regular10.copyWith(color: foreground),
              ),
          ],
        ),
      ),
    );
  }
}
