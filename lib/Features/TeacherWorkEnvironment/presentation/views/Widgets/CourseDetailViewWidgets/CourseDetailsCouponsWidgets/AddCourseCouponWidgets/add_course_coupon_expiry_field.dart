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
    final Color defaultTextColor =
        theme.textTheme.bodyMedium!.color!.withOpacity(0.7);
    final Color selectedTextColor = theme.textTheme.bodyLarge!.color!;
    final Color iconColor = defaultTextColor;
    final Color fillColor = theme.brightness == Brightness.dark
        ? theme.inputDecorationTheme.fillColor ?? Colors.grey.shade800
        : const Color(0xffF9FAFA); // Original light mode color or theme default

    final Color titleColor =
        pickedDate == null ? defaultTextColor : selectedTextColor;

    final String dateText = pickedDate == null
        ? LocaleKeys.expirationDate
        : "${pickedDate!.day}/${pickedDate!.month}/${pickedDate!.year}";

    return InkWell(
      onTap: onTap,
      child: Container(
        height: 56,
        width: double.infinity,
        decoration: BoxDecoration(
          color: fillColor,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: theme.dividerColor.withOpacity(0.5)),
        ),
        child: ListTile(
          dense: true,
          title: Text(
            dateText,
            style: AppTextStyles(context).bold14.copyWith(
                  color: titleColor,
                ),
          ),
          leading: Icon(
            Icons.date_range_outlined,
            color: iconColor,
          ),
        ),
      ),
    );
  }
}
