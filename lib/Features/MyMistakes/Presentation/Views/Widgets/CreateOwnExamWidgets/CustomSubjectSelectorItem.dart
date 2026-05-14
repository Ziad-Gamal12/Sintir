import 'package:flutter/material.dart';
import 'package:sintir/Features/MyMistakes/Presentation/Views/Widgets/CreateOwnExamWidgets/MistakesCountIndicator.dart';
import 'package:sintir/constant.dart';

class CustomSubjectSelectorItem extends StatelessWidget {
  const CustomSubjectSelectorItem({
    super.key,
    required this.label,
    required this.value,
    required this.isSelected,
    required this.onTap,
  });

  final String label, value;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDarkMode = theme.brightness == Brightness.dark;

    final Color contentColor = isSelected
        ? Colors.white
        : (isDarkMode ? Colors.white70 : Colors.black87);

    final Color backgroundColor = isSelected
        ? KMainColor
        : (isDarkMode ? Colors.white.withOpacity(0.05) : Colors.grey.shade100);

    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
        decoration: _buildDecoration(isDarkMode),
        child: IntrinsicWidth(
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                label,
                style: TextStyle(
                  color: contentColor,
                  fontWeight: isSelected ? FontWeight.w700 : FontWeight.w500,
                  fontSize: 14,
                ),
              ),
              const SizedBox(width: 6),
              MistakesCountIndicator(
                subjectId: value,
                color: contentColor,
              ),
            ],
          ),
        ),
      ),
    );
  }

  BoxDecoration _buildDecoration(bool isDarkMode) {
    return BoxDecoration(
      color: isSelected
          ? KMainColor
          : (isDarkMode
              ? Colors.white.withOpacity(0.05)
              : Colors.grey.shade100),
      borderRadius: BorderRadius.circular(16),
      border: Border.all(
        color: isSelected
            ? KMainColor
            : (isDarkMode ? Colors.white10 : Colors.grey.shade300),
        width: 1.5,
      ),
      boxShadow: (isSelected)
          ? [
              BoxShadow(
                color: KMainColor.withOpacity(isDarkMode ? 0.4 : 0.2),
                blurRadius: 10,
                offset: const Offset(0, 4),
              )
            ]
          : [],
    );
  }
}
