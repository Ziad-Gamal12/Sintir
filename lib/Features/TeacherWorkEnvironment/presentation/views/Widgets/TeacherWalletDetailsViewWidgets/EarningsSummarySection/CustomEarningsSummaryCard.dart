import 'package:flutter/material.dart';
import 'package:sintir/Core/utils/textStyles.dart';

// ignore: must_be_immutable
class CustomEarningsSummaryCard extends StatelessWidget {
  CustomEarningsSummaryCard(
      {super.key,
      required this.value,
      required this.title,
      required this.currency,
      this.theme,
      this.valueColor});
  final String value, title, currency;
  ThemeData? theme;
  Color? valueColor;
  @override
  Widget build(BuildContext context) {
    final theme = this.theme ?? Theme.of(context);
    final isDarkMode = theme.brightness == Brightness.dark;
    return AspectRatio(
      aspectRatio: 112 / 100,
      child: Container(
          padding: EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: theme.colorScheme.surface,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: theme.colorScheme.onSurface.withValues(alpha: 0.1),
            ),
            boxShadow: [
              BoxShadow(
                color: theme.colorScheme.shadow.withValues(alpha: 0.1),
                blurRadius: 4,
                offset: Offset(0, 2),
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: AppTextStyles(context).medium12.copyWith(
                    color: isDarkMode ? Color(0xffC4C5D6) : Color(0xff64748B)),
              ),
              SizedBox(height: 4),
              FittedBox(
                fit: BoxFit.scaleDown,
                child: Text(value,
                    style: AppTextStyles(context).bold14.copyWith(
                        color: valueColor ??
                            (isDarkMode ? Colors.white : Colors.black))),
              ),
              Text(currency,
                  style: AppTextStyles(context)
                      .semiBold10
                      .copyWith(color: Color(0xff64748B)))
            ],
          )),
    );
  }
}
