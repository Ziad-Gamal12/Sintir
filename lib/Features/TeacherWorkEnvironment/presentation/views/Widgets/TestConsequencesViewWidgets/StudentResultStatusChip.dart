import 'package:flutter/material.dart';
import 'package:sintir/Core/utils/textStyles.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/Widgets/TestConsequencesViewWidgets/ResultSemanticColors.dart';
import 'package:sintir/locale_keys.dart';

class StudentResultStatusChip extends StatelessWidget {
  const StudentResultStatusChip({
    super.key,
    required this.isPassed,
    this.color,
    this.semanticColors,
    this.label,
    this.icon,
    this.isCompact = true,
  });

  final bool isPassed;
  final Color? color;
  final ResultSemanticColors? semanticColors;
  final String? label;
  final IconData? icon;
  final bool isCompact;

  @override
  Widget build(BuildContext context) {
    final style = AppTextStyles(context);
    final isDark = Theme.of(context).brightness == Brightness.dark;

    final resolved =
        semanticColors ??
        (isPassed
            ? ResultSemanticColors.success(isDark)
            : ResultSemanticColors.failure(isDark));

    final fgColor = color ?? resolved.foreground;
    final bgColor = resolved.background;
    final borderColor = resolved.border;

    final text = label ?? (isPassed ? LocaleKeys.passed : LocaleKeys.failed);
    final iconData =
        icon ?? (isPassed ? Icons.check_circle_rounded : Icons.cancel_rounded);

    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: isCompact ? 6 : 8,
        vertical: isCompact ? 2 : 3,
      ),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(99),
        border: Border.all(color: borderColor, width: 0.75),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(iconData, size: isCompact ? 11 : 13, color: fgColor),
          const SizedBox(width: 3.5),
          Text(
            text,
            style: (isCompact ? style.semiBold11 : style.semiBold12).copyWith(
              color: fgColor,
              height: 1.1,
            ),
          ),
        ],
      ),
    );
  }
}
