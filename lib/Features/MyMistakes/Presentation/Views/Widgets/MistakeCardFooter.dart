import 'package:flutter/material.dart';
import 'package:sintir/Core/utils/textStyles.dart';
import 'package:sintir/locale_keys.dart';

class MistakeCardFooter extends StatelessWidget {
  final int wrongCount;
  final int correctStreak;

  const MistakeCardFooter(
      {super.key, required this.wrongCount, required this.correctStreak});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Row(
          children: [
            const Icon(Icons.history_rounded,
                size: 18, color: Colors.redAccent),
            const SizedBox(width: 4),
            Text(LocaleKeys.totalMistakes,
                style: AppTextStyles(context).regular13), // Localized
            const SizedBox(width: 4),
            Text("$wrongCount",
                style: AppTextStyles(context)
                    .bold13
                    .copyWith(color: Colors.redAccent)),
          ],
        ),
        const Spacer(),
        _buildStreakIndicator(),
      ],
    );
  }

  Widget _buildStreakIndicator() {
    return Row(
      children: List.generate(3, (index) {
        bool isAchieved = index < correctStreak;
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 2),
          child: Icon(
            Icons.offline_bolt_rounded,
            size: 20,
            color: isAchieved ? Colors.amber : Colors.grey.withOpacity(0.3),
          ),
        );
      }),
    );
  }
}
