import 'package:flutter/material.dart';
import 'package:sintir/Core/utils/textStyles.dart';
import 'package:sintir/Features/MyTransactions/Presentation/Views/Widgets/styles/transactions_style_mapper.dart';
import 'package:sintir/locale_keys.dart';

class TransactionSearchField extends StatelessWidget {
  const TransactionSearchField({
    super.key,
    required this.controller,
    required this.onChanged,
  });

  final TextEditingController controller;
  final ValueChanged<String> onChanged;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final primary = TransactionsStyleMapper.primary(theme);
    final border = OutlineInputBorder(
      borderRadius: BorderRadius.circular(14),
      borderSide: BorderSide(color: theme.dividerColor.withValues(alpha: .25)),
    );
    return TextField(
      controller: controller,
      onChanged: onChanged,
      textInputAction: TextInputAction.search,
      style: AppTextStyles(context).regular14,
      decoration: InputDecoration(
        hintText: LocaleKeys.transactionsSearchHint,
        prefixIcon: Icon(Icons.search, color: primary),
        isDense: true,
        filled: true,
        border: border,
        enabledBorder: border,
        focusedBorder: border.copyWith(
          borderSide: BorderSide(color: primary, width: 1.5),
        ),
      ),
    );
  }
}
