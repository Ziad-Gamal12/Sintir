import 'package:flutter/material.dart';
import 'package:sintir/Core/utils/textStyles.dart';
import 'package:sintir/locale_keys.dart';

class ProfitSettlementNoteBody extends StatelessWidget {
  const ProfitSettlementNoteBody({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Text(
          LocaleKeys.profitSettlementNoteTitle,
          style: AppTextStyles(context)
              .bold12
              .copyWith(color: theme.textTheme.bodyLarge?.color),
        ),
        const SizedBox(height: 2),
        Text(LocaleKeys.profitSettlementNoteDescription,
            style: AppTextStyles(context).regular12),
      ],
    );
  }
}
