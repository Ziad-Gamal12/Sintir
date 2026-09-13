import 'package:flutter/material.dart';
import 'package:sintir/Core/utils/textStyles.dart';

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
          "تسوية آمنة وسريعة للأرباح",
          style: AppTextStyles(context)
              .bold12
              .copyWith(color: theme.textTheme.bodyLarge?.color),
        ),
        SizedBox(height: 2),
        Text(
            "تتم معالجة تحويلات السحب عبر فودافون كاش والمحافظ الإلكترونية خلال 24 ساعة دون أي رسوم إدارية إضافية.",
            style: AppTextStyles(context).regular12),
      ],
    );
  }
}
