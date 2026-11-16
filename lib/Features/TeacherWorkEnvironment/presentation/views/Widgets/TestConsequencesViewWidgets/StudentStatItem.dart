import 'package:flutter/material.dart';
import 'package:sintir/Core/utils/textStyles.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/Widgets/TestConsequencesViewWidgets/StudentStatItemIcon.dart';

class StudentStatItem extends StatelessWidget {
  const StudentStatItem({
    super.key,
    required this.icon,
    required this.title,
    required this.value,
    required this.backgroundColor,
    this.isHero = false,
    this.statusChip,
  });

  final String icon;
  final String title;
  final String value;
  final Color backgroundColor;
  final bool isHero;
  final Widget? statusChip;

  @override
  Widget build(BuildContext context) {
    final style = AppTextStyles(context);
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    // Refined shared neutral surface with subtle brand touch (Option B)
    final neutralBase = isDark
        ? const Color(0xFF1E222D).withValues(alpha: 0.60)
        : const Color(0xFFF6F8FC);

    final surfaceColor = Color.alphaBlend(
      backgroundColor.withValues(alpha: isDark ? 0.03 : 0.02),
      neutralBase,
    );

    final borderColor = isDark
        ? Colors.white.withValues(alpha: 0.06)
        : const Color(0xFFE2E8F0).withValues(alpha: 0.85);

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: surfaceColor,
        border: Border.all(color: borderColor, width: 0.75),
      ),
      child: Row(
        children: [
          StudentStatItemIcon(icon: icon, backgroundColor: backgroundColor),
          const SizedBox(width: 8),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  title,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: style.regular11.copyWith(
                    color: theme.colorScheme.onSurfaceVariant,
                    height: 1.1,
                  ),
                ),
                const SizedBox(height: 3),
                FittedBox(
                  fit: BoxFit.scaleDown,
                  alignment: AlignmentDirectional.centerStart,
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Directionality(
                        textDirection: TextDirection.ltr,
                        child: Text(
                          value,
                          maxLines: 1,
                          style: (isHero ? style.semiBold20 : style.semiBold16)
                              .copyWith(
                                color: theme.colorScheme.onSurface,
                                height: 1.1,
                              ),
                        ),
                      ),
                      if (statusChip != null) ...[
                        const SizedBox(width: 6),
                        statusChip!,
                      ],
                    ],
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
