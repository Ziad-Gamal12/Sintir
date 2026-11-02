import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final locale = Localizations.localeOf(context).languageCode;
    final primary = TransactionsStyleMapper.primary(theme);

    // تحديد لون الشريحة النشطة بناءً على التصميم
    final activeColor = dotColor ?? primary;

    // إعدادات الخلفية والحدود
    final Color backgroundColor;
    final Color borderColor;
    final Color foregroundColor;
    final Color badgeBackgroundColor;
    final Color badgeTextColor;

    if (selected) {
      backgroundColor = activeColor;
      borderColor = activeColor;
      foregroundColor = Colors.white;
      badgeBackgroundColor = Colors.white.withValues(alpha: 0.22);
      badgeTextColor = Colors.white;
    } else {
      backgroundColor = isDark ? const Color(0xFF1E1E1E) : Colors.white;
      borderColor = TransactionsStyleMapper.cardBorder(theme);
      foregroundColor = isDark
          ? const Color(0xFFF1F5F9)
          : const Color(0xFF1E293B);
      badgeBackgroundColor = isDark
          ? const Color(0xFF2C2C2E)
          : const Color(0xFFF1F5F9);
      badgeTextColor = isDark
          ? const Color(0xFF94A3B8)
          : const Color(0xFF64748B);
    }

    return AnimatedContainer(
      duration: const Duration(milliseconds: 220),
      curve: Curves.easeInOut,
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(50),
        border: Border.all(color: borderColor, width: 1.2),
        boxShadow: selected
            ? [
                BoxShadow(
                  color: activeColor.withValues(alpha: isDark ? 0.25 : 0.2),
                  blurRadius: 8,
                  offset: const Offset(0, 2),
                ),
              ]
            : null,
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(50),
          onTap: () {
            HapticFeedback.selectionClick();
            onTap();
          },
          child: Padding(
            padding: const EdgeInsetsDirectional.symmetric(
              horizontal: 14,
              vertical: 8,
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                if (dotColor != null) ...[
                  Container(
                    width: 7,
                    height: 7,
                    decoration: BoxDecoration(
                      color: selected ? Colors.white : dotColor,
                      shape: BoxShape.circle,
                    ),
                  ),
                  const SizedBox(width: 7),
                ],

                Text(
                  label,
                  style: AppTextStyles(context).semiBold12.copyWith(
                    color: foregroundColor,
                    letterSpacing: -0.2,
                  ),
                ),

                const SizedBox(width: 7),

                Container(
                  constraints: const BoxConstraints(minWidth: 20),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 6,
                    vertical: 2,
                  ),
                  decoration: BoxDecoration(
                    color: badgeBackgroundColor,
                    borderRadius: BorderRadius.circular(50),
                  ),
                  alignment: Alignment.center,
                  child: Text(
                    LocaleFormatter.number(count, locale),
                    style: AppTextStyles(context).bold12.copyWith(
                      color: badgeTextColor,
                      fontFeatures: const [FontFeature.tabularFigures()],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
