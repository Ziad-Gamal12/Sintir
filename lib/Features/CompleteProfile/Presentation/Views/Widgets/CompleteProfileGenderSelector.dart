import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sintir/locale_keys.dart';

class CompleteProfileGenderSelector extends StatelessWidget {
  const CompleteProfileGenderSelector({
    super.key,
    required this.selectedGender,
    required this.onGenderChanged,
    this.maleValue = 'male',
    this.femaleValue = 'female',
    this.maleLabel,
    this.femaleLabel,
  });

  final String? selectedGender;
  final ValueChanged<String> onGenderChanged;
  final String maleValue;
  final String femaleValue;
  final String? maleLabel;
  final String? femaleLabel;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: _GenderOptionCard(
            label: maleLabel ?? LocaleKeys.genderMale,
            isSelected: selectedGender == maleValue,
            onTap: () => _handleSelect(maleValue),
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: _GenderOptionCard(
            label: femaleLabel ?? LocaleKeys.genderFemale,
            isSelected: selectedGender == femaleValue,
            onTap: () => _handleSelect(femaleValue),
          ),
        ),
      ],
    );
  }

  void _handleSelect(String value) {
    if (selectedGender == value) return;
    HapticFeedback.selectionClick();
    onGenderChanged(value);
  }
}

class _GenderOptionCard extends StatelessWidget {
  const _GenderOptionCard({
    required this.label,
    required this.isSelected,
    required this.onTap,
  });

  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  static const _borderRadius = BorderRadius.all(Radius.circular(14));
  static const _duration = Duration(milliseconds: 200);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    final backgroundColor = isSelected
        ? Color.alphaBlend(
            colorScheme.primary.withValues(alpha: 0.08),
            theme.cardColor,
          )
        : theme.cardColor;

    final borderColor = isSelected ? colorScheme.primary : Color(0xffE2E7F0);

    final textColor = isSelected ? colorScheme.primary : colorScheme.onSurface;

    return Semantics(
      button: true,
      selected: isSelected,
      inMutuallyExclusiveGroup: true,
      label: label,
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          borderRadius: _borderRadius,
          splashColor: colorScheme.primary.withValues(alpha: 0.1),
          highlightColor: colorScheme.primary.withValues(alpha: 0.05),
          child: AnimatedContainer(
            duration: _duration,
            curve: Curves.easeOutCubic,
            height: 56,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            decoration: BoxDecoration(
              color: backgroundColor,
              borderRadius: _borderRadius,
              border: Border.all(
                color: borderColor,
                width: isSelected ? 1.8 : 1.0,
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Flexible(
                  child: AnimatedDefaultTextStyle(
                    duration: _duration,
                    style: (theme.textTheme.titleMedium ?? const TextStyle())
                        .copyWith(
                          color: textColor,
                          fontWeight: isSelected
                              ? FontWeight.w700
                              : FontWeight.w500,
                        ),
                    child: Text(
                      label,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                _GenderRadioIndicator(isSelected: isSelected),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _GenderRadioIndicator extends StatelessWidget {
  const _GenderRadioIndicator({required this.isSelected});

  final bool isSelected;

  static const _duration = Duration(milliseconds: 200);

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return AnimatedContainer(
      duration: _duration,
      curve: Curves.easeOutCubic,
      width: 22,
      height: 22,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(
          color: isSelected ? colorScheme.primary : Color(0xffD0D5DD),
          width: isSelected ? 2.0 : 1.5,
        ),
      ),
      child: Center(
        child: AnimatedScale(
          duration: _duration,
          curve: Curves.easeOutBack,
          scale: isSelected ? 1.0 : 0.0,
          child: Container(
            width: 11,
            height: 11,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: colorScheme.primary,
            ),
          ),
        ),
      ),
    );
  }
}
