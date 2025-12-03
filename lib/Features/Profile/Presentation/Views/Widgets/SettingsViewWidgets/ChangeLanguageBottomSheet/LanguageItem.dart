import 'package:flutter/material.dart';
import 'package:sintir/Core/utils/textStyles.dart';
import 'package:sintir/Features/Profile/Domain/Entities/LocalizationEntity.dart';
import 'package:svg_flutter/svg_flutter.dart';

class LanguageItem extends StatelessWidget {
  const LanguageItem(
      {super.key, required this.locale, required this.isSelected});
  final LocalizationEntity locale;
  final bool isSelected;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final Color selectedBorderColor =
        theme.colorScheme.primary; // Use primary color for selection border
    final Color itemBackgroundColor =
        theme.cardColor; // Use theme card color for the item background
    final Color checkIconColor =
        theme.colorScheme.primary; // Use primary color for the checkmark
    final Color textColor = theme.textTheme.bodyLarge!.color!;

    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: itemBackgroundColor,
        border: Border.all(
          color: isSelected ? selectedBorderColor : Colors.transparent,
          width: isSelected ? 2.0 : 0.0,
        ),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          SvgPicture.asset(locale.svgIcon, height: 24, width: 24),
          const SizedBox(
            width: 8,
          ),
          Text(
            locale.title,
            style: AppTextStyles(context).semiBold20.copyWith(color: textColor),
          ),
          const Spacer(),
          // Selection Checkmark
          isSelected
              ? Icon(Icons.check, color: checkIconColor)
              : const SizedBox(),
        ],
      ),
    );
  }
}
