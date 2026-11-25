import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sintir/Core/Themes/brand_palette.dart';
import 'package:sintir/Core/utils/textStyles.dart';
import 'package:sintir/constant.dart';

class CustomTextField extends StatelessWidget {
  final String hintText;
  final IconData? prefixIcon;
  final Widget? suffixIcon;
  final bool obscureText;
  final TextEditingController? controller;
  final TextInputType textInputType;
  final String? Function(String?)? validator;
  final List<TextInputFormatter>? inputFormatters;
  final Function(String?)? onSaved;
  final int maxLines;

  /// With [maxLines] above 1, lets the field start this short and grow as
  /// the text wraps, instead of always being [maxLines] tall.
  final int? minLines;
  final int? maxLength;
  final bool floatingLabel;

  const CustomTextField({
    super.key,
    this.inputFormatters,
    required this.hintText,
    this.prefixIcon,
    this.suffixIcon,
    required this.obscureText,
    this.controller,
    required this.textInputType,
    required this.validator,
    this.onSaved,
    this.maxLength,
    this.maxLines = 1,
    this.minLines,
    this.floatingLabel = false,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDarkMode = theme.brightness == Brightness.dark;
    final palette = BrandPalette.of(context);
    final styles = AppTextStyles(context);

    final Color borderColor = palette.outline;
    final Color fillBg = isDarkMode
        ? Colors.white.withValues(alpha: 0.05)
        : const Color(0xFFF8F9FA);

    Color stateColor(Set<WidgetState> states) {
      if (states.contains(WidgetState.error)) return Colors.redAccent;
      if (states.contains(WidgetState.focused)) return palette.link;
      return palette.placeholder;
    }

    return TextFormField(
      onSaved: onSaved,
      inputFormatters: inputFormatters,
      controller: controller,
      keyboardType: textInputType,
      obscureText: obscureText,
      validator: validator,
      maxLines: maxLines,
      minLines: minLines,
      maxLength: maxLength,
      style: styles.semiBold14.copyWith(
            color: theme.textTheme.bodyLarge?.color,
          ),
      decoration: InputDecoration(
        hintText: floatingLabel ? null : hintText,
        labelText: floatingLabel ? hintText : null,
        hintStyle: styles.regular14.copyWith(color: palette.placeholder),
        labelStyle: styles.regular14.copyWith(color: palette.placeholder),
        floatingLabelStyle: WidgetStateTextStyle.resolveWith(
          (states) => styles.semiBold14.copyWith(color: stateColor(states)),
        ),
        alignLabelWithHint: maxLines > 1,

        filled: true,
        fillColor: fillBg,
        prefixIconColor: WidgetStateColor.resolveWith(stateColor),
        prefixIcon: prefixIcon != null
            ? Container(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                child: Icon(
                  prefixIcon,
                  size: 20,
                ),
              )
            : null,
        prefixIconConstraints: const BoxConstraints(minWidth: 40, minHeight: 0),

        suffixIcon: suffixIcon,

        // Modern Borders
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: BorderSide(color: borderColor, width: 1),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: const BorderSide(color: KMainColor, width: 2),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: const BorderSide(color: Colors.redAccent, width: 1),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: const BorderSide(color: Colors.redAccent, width: 2),
        ),

        contentPadding: const EdgeInsets.symmetric(
          vertical: 18,
          horizontal: 20,
        ),
      ),
    );
  }
}
