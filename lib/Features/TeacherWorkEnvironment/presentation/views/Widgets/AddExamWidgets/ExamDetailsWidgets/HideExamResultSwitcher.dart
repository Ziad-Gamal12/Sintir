import 'package:flutter/material.dart';
import 'package:sintir/Core/utils/textStyles.dart';
import 'package:sintir/locale_keys.dart';

class HideExamResultSwitcher extends StatefulWidget {
  const HideExamResultSwitcher({
    super.key,
    required this.isHiddin,
    required this.onChanged,
  });

  final bool isHiddin;
  final ValueChanged<bool> onChanged;

  @override
  State<HideExamResultSwitcher> createState() => _HideExamResultSwitcherState();
}

class _HideExamResultSwitcherState extends State<HideExamResultSwitcher> {
  late bool currentValue;

  @override
  void initState() {
    super.initState();
    currentValue = widget.isHiddin;
  }

  void _handleToggle() {
    setState(() => currentValue = !currentValue);
    widget.onChanged(currentValue);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final isDark = theme.brightness == Brightness.dark;
    final activeBg = colorScheme.primary.withOpacity(isDark ? 0.15 : 0.05);
    final inactiveBorder =
        isDark ? Colors.white10 : Colors.black.withOpacity(0.05);

    return InkWell(
      onTap: _handleToggle,
      borderRadius: BorderRadius.circular(16),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: currentValue ? colorScheme.primary : inactiveBorder,
            width: 1.2,
          ),
          color: currentValue ? activeBg : theme.cardColor,
        ),
        child: Row(
          children: [
            Expanded(
              child: Text(
                LocaleKeys.hideResultAfterSubmit,
                style: AppTextStyles(context).regular16.copyWith(
                      fontWeight: FontWeight.w600,
                      color: currentValue
                          ? colorScheme.primary
                          : theme.textTheme.bodyLarge?.color,
                    ),
              ),
            ),
            _CustomToggle(
              isActive: currentValue,
              activeColor: colorScheme.primary,
              thumbColor:
                  theme.cardColor, // Thumb uses the background card color
            ),
          ],
        ),
      ),
    );
  }
}

class _CustomToggle extends StatelessWidget {
  final bool isActive;
  final Color activeColor;
  final Color thumbColor;

  const _CustomToggle({
    required this.isActive,
    required this.activeColor,
    required this.thumbColor,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return AnimatedContainer(
      duration: const Duration(milliseconds: 250),
      curve: Curves.easeOutBack,
      width: 52,
      height: 28,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: isActive
            ? activeColor
            : theme.unselectedWidgetColor.withOpacity(0.2),
      ),
      child: AnimatedAlign(
        duration: const Duration(milliseconds: 250),
        curve: Curves.easeOutBack,
        alignment: isActive ? Alignment.centerRight : Alignment.centerLeft,
        child: Container(
          width: 22,
          height: 22,
          margin: const EdgeInsets.symmetric(horizontal: 3),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: isActive ? Colors.white : thumbColor,
            boxShadow: const [
              BoxShadow(
                color: Colors.black26,
                blurRadius: 4,
                offset: Offset(0, 1),
              )
            ],
          ),
        ),
      ),
    );
  }
}
