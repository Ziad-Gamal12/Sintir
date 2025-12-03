import 'package:flutter/material.dart';
import 'package:sintir/Core/utils/textStyles.dart';
import 'package:sintir/locale_keys.dart';

class ExamDuration extends StatelessWidget {
  const ExamDuration({
    super.key,
    required this.duration,
  });

  final int duration;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final textStyle = AppTextStyles(context).regular14.copyWith(
          color: isDark ? Colors.white70 : Colors.black87,
        );

    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: Colors.blueAccent.withOpacity(.2),
            shape: BoxShape.circle,
          ),
          child: Icon(
            Icons.timer,
            color: isDark ? Colors.white70 : Colors.black,
            size: 20,
          ),
        ),
        const SizedBox(width: 12),
        Text("$duration ${LocaleKeys.durationMinutes}", style: textStyle),
      ],
    );
  }
}
