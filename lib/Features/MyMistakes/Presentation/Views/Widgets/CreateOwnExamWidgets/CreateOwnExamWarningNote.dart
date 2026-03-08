import 'package:flutter/material.dart';
import 'package:sintir/Core/utils/textStyles.dart';
import 'package:sintir/locale_keys.dart';

class CreateOwnExamWarningNote extends StatelessWidget {
  const CreateOwnExamWarningNote({super.key});

  @override
  Widget build(BuildContext context) {
    final bool isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color:
            isDarkMode ? Colors.amber.withOpacity(0.05) : Colors.amber.shade50,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: isDarkMode
              ? Colors.amber.withOpacity(0.2)
              : Colors.amber.shade200,
          width: 1,
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(
            Icons.info_outline_rounded,
            color: isDarkMode ? Colors.amber.shade300 : Colors.amber.shade700,
            size: 24,
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  LocaleKeys.noteTitle,
                  style: AppTextStyles(context).bold16.copyWith(
                        color: isDarkMode
                            ? Colors.amber.shade300
                            : Colors.amber.shade800,
                      ),
                ),
                const SizedBox(height: 6),
                Text(
                  LocaleKeys.noteBody,
                  style: AppTextStyles(context).regular14.copyWith(
                        color: isDarkMode ? Colors.white70 : Colors.black87,
                        height: 1.5,
                      ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
