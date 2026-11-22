// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:sintir/Core/utils/textStyles.dart';
import 'package:sintir/constant.dart';
import 'package:sintir/locale_keys.dart';

/// Two-option gender picker styled like the text fields (56dp, radius 14).
/// Emits "Male" / "Female", the same values the old radio inputs stored.
class GenderSegmentedInput extends StatefulWidget {
  const GenderSegmentedInput({
    super.key,
    required this.onChanged,
    this.initialValue,
  });

  final ValueChanged<String> onChanged;
  final String? initialValue;

  @override
  State<GenderSegmentedInput> createState() => _GenderSegmentedInputState();
}

class _GenderSegmentedInputState extends State<GenderSegmentedInput> {
  String? _value;

  @override
  void initState() {
    super.initState();
    _value = widget.initialValue;
  }

  void _select(String value) {
    setState(() => _value = value);
    widget.onChanged(value);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    final fill =
        isDark ? Colors.white.withValues(alpha: 0.05) : const Color(0xFFF8F9FA);
    final border = isDark ? Colors.white10 : const Color(0xFFE4E6E8);

    return Container(
      height: 56,
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: fill,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: border),
      ),
      child: Row(
        spacing: 4,
        children: [
          Expanded(
            child: _Segment(
              label: LocaleKeys.male,
              icon: Icons.male_rounded,
              selected: _value == 'Male',
              onTap: () => _select('Male'),
            ),
          ),
          Expanded(
            child: _Segment(
              label: LocaleKeys.female,
              icon: Icons.female_rounded,
              selected: _value == 'Female',
              onTap: () => _select('Female'),
            ),
          ),
        ],
      ),
    );
  }
}

class _Segment extends StatelessWidget {
  const _Segment({
    required this.label,
    required this.icon,
    required this.selected,
    required this.onTap,
  });

  final String label;
  final IconData icon;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final color = selected ? KMainColor : theme.hintColor;

    return Semantics(
      button: true,
      selected: selected,
      inMutuallyExclusiveGroup: true,
      label: label,
      excludeSemantics: true,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 180),
        decoration: BoxDecoration(
          color: selected
              ? (isDark ? theme.cardColor : Colors.white)
              : Colors.transparent,
          borderRadius: BorderRadius.circular(10),
          boxShadow: selected
              ? [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: isDark ? .3 : .08),
                    blurRadius: 4,
                    offset: const Offset(0, 1),
                  ),
                ]
              : null,
        ),
        child: Material(
          type: MaterialType.transparency,
          child: InkWell(
            onTap: onTap,
            borderRadius: BorderRadius.circular(10),
            child: Center(
              child: Row(
                mainAxisSize: MainAxisSize.min,
                spacing: 8,
                children: [
                  Icon(icon, size: 18, color: color),
                  Flexible(
                    child: Text(
                      label,
                      overflow: TextOverflow.ellipsis,
                      style: (selected
                              ? AppTextStyles(context).bold14
                              : AppTextStyles(context).semiBold14)
                          .copyWith(color: color),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
