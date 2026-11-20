import 'package:animated_custom_dropdown/custom_dropdown.dart';
import 'package:flutter/material.dart';
import 'package:sintir/Core/utils/textStyles.dart';
import 'package:sintir/locale_keys.dart';

class CustomAnimatedDropDownButton extends StatelessWidget {
  const CustomAnimatedDropDownButton({
    super.key,
    required this.items,
    required this.onChanged,
    this.hintText,
  });

  final List<String> items;
  final ValueChanged<String?> onChanged;
  final String? hintText;

  Future<List<String>> _getFakeRequestData(String query) async {
    await Future.delayed(const Duration(milliseconds: 500));

    return items.where((e) {
      return e.toLowerCase().contains(query.toLowerCase());
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDarkMode = theme.brightness == Brightness.dark;

    final Color fillColor = isDarkMode
        ? Colors.white.withValues(alpha: 0.05)
        : const Color(0xFFF8F9FA);

    final Color borderColor = isDarkMode
        ? Colors.white10
        : const Color(0xFFE4E6E8);

    final Color expandedColor = isDarkMode
        ? const Color(0xFF1E1E1E)
        : Colors.white;

    return CustomDropdown<String>.searchRequest(
      futureRequest: _getFakeRequestData,
      hintText: hintText ?? LocaleKeys.chooseOption,

      headerBuilder: (context, selectedItem, enabled) => Text(
        selectedItem,
        style: AppTextStyles(
          context,
        ).semiBold14.copyWith(color: theme.textTheme.bodyLarge?.color),
      ),

      hintBuilder: (context, hint, enabled) => Text(
        hint,
        style: AppTextStyles(
          context,
        ).regular14.copyWith(color: theme.hintColor.withValues(alpha: 0.5)),
      ),

      decoration: CustomDropdownDecoration(
        expandedShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: isDarkMode ? 0.25 : 0.08),
            blurRadius: 16,
            offset: const Offset(0, 6),
          ),
        ],

        searchFieldDecoration: SearchFieldDecoration(
          fillColor: fillColor,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(color: borderColor, width: 1),
          ),
          textStyle: AppTextStyles(
            context,
          ).regular14.copyWith(color: theme.textTheme.bodyLarge?.color),
        ),

        expandedFillColor: expandedColor,

        closedFillColor: fillColor,

        closedBorder: BoxBorder.all(color: borderColor, width: 1),

        expandedBorder: BoxBorder.all(
          color: theme.primaryColor.withValues(alpha: 0.5),
          width: 1.2,
        ),

        closedBorderRadius: BorderRadius.circular(14),
        expandedBorderRadius: BorderRadius.circular(14),
      ),

      items: items,
      onChanged: onChanged,
    );
  }
}
