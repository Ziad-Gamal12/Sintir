import 'package:flutter/material.dart';
import 'package:sintir/Core/utils/textStyles.dart';
import 'package:sintir/locale_keys.dart';

class AddCourseCouponExpiryField extends StatelessWidget {
  final DateTime? pickedDate;
  final VoidCallback onTap;

  const AddCourseCouponExpiryField({
    super.key,
    required this.pickedDate,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final bool isDarkMode = theme.brightness == Brightness.dark;

    final Color fillBg = isDarkMode
        ? Colors.white.withValues(alpha: 0.05)
        : const Color(0xFFF8F9FA);

    final String dateText = pickedDate == null
        ? LocaleKeys.expirationDate
        : "${pickedDate!.day}/${pickedDate!.month}/${pickedDate!.year}";

    return InkWell(
      onTap: onTap,
      child: Container(
        height: 56,
        width: double.infinity,
        decoration: BoxDecoration(
          color: fillBg,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
              color: isDarkMode ? Colors.white10 : const Color(0xFFE4E6E8)),
        ),
        child: ListTile(
          dense: true,
          title: Text(
            dateText,
            style: pickedDate == null
                ? AppTextStyles(context).regular14.copyWith(
                      color: theme.hintColor.withValues(alpha: 0.5),
                    )
                : AppTextStyles(context).regular14.copyWith(
                      color: isDarkMode ? Colors.white : Colors.black,
                    ),
          ),
          leading: Icon(
            Icons.date_range_outlined,
            size: 20,
            color: theme.primaryColor.withValues(alpha: 0.7),
          ),
        ),
      ),
    );
  }
}
