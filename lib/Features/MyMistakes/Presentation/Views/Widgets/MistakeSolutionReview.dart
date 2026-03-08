import 'package:flutter/material.dart';
import 'package:sintir/Core/utils/textStyles.dart';
import 'package:sintir/locale_keys.dart';

class MistakeSolutionReview extends StatelessWidget {
  final String selectedAnswer;
  final String correctAnswer;

  const MistakeSolutionReview(
      {super.key, required this.selectedAnswer, required this.correctAnswer});

  @override
  Widget build(BuildContext context) {
    final bool isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return Column(
      children: [
        _buildReviewRow(
          context,
          label: LocaleKeys.yourAnswer,
          value: selectedAnswer,
          color: Colors.redAccent,
          icon: Icons.close_rounded,
          isDarkMode: isDarkMode,
        ),
        const SizedBox(height: 8),
        _buildReviewRow(
          context,
          label: LocaleKeys.correctAnswer,
          value: correctAnswer,
          color: Colors.green,
          icon: Icons.check_rounded,
          isDarkMode: isDarkMode,
        ),
      ],
    );
  }

  Widget _buildReviewRow(BuildContext context,
      {required String label,
      required String value,
      required Color color,
      required IconData icon,
      required bool isDarkMode}) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: color.withOpacity(isDarkMode ? 0.1 : 0.05),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Icon(icon, size: 16, color: color),
          const SizedBox(width: 8),
          Text(label,
              style: AppTextStyles(context).regular13.copyWith(color: color)),
          const SizedBox(width: 6),
          Expanded(
            child: Text(
              value,
              style: AppTextStyles(context)
                  .bold13
                  .copyWith(color: isDarkMode ? Colors.white : Colors.black87),
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }
}
