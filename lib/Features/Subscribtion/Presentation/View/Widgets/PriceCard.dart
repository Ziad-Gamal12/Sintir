import 'package:flutter/material.dart';
import 'package:sintir/Core/utils/textStyles.dart';

class PriceCard extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;
  final bool highlight;
  final bool isOriginal;
  final bool showStrike;

  const PriceCard({
    super.key,
    required this.icon,
    required this.label,
    required this.value,
    this.highlight = false,
    this.isOriginal = false,
    this.showStrike = false,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    final Color baseTextColor = isDark ? Colors.white : Colors.black87;
    final Color baseIconColor = isDark ? Colors.grey.shade300 : Colors.grey;
    final Color highlightColor = Colors.green.shade600;
    final Color containerColor = highlight
        ? highlightColor.withOpacity(0.12)
        : (isDark
            ? Colors.grey.shade800.withOpacity(0.15)
            : Colors.blueGrey.withOpacity(0.07));
    final Color borderColor = highlight
        ? highlightColor.withOpacity(0.9)
        : (isDark
            ? Colors.grey.shade700.withOpacity(0.4)
            : Colors.blueGrey.withOpacity(0.2));

    return Stack(
      children: [
        AnimatedContainer(
          duration: const Duration(milliseconds: 400),
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            color: containerColor,
            border: Border.all(
              color: borderColor,
              width: highlight ? 1.5 : 1,
            ),
          ),
          child: Row(
            children: [
              Icon(icon,
                  size: 20, color: highlight ? highlightColor : baseIconColor),
              const SizedBox(width: 12),

              // PRICE LABEL
              Expanded(
                child: Text(
                  label,
                  style: AppTextStyles(context).semiBold14.copyWith(
                      color: highlight ? highlightColor : baseTextColor),
                ),
              ),

              AnimatedOpacity(
                opacity: 1,
                duration: const Duration(milliseconds: 300),
                child: Text(
                  value,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    decoration:
                        (showStrike ? TextDecoration.lineThrough : null),
                    decorationColor: Colors.red,
                    decorationThickness: 2,
                    color: highlight ? highlightColor : baseTextColor,
                  ),
                ),
              ),
            ],
          ),
        ),

        // ANIMATED STRIKE LINE FOR ORIGINAL PRICE
        if (showStrike)
          Positioned.fill(
            child: Align(
              alignment: Alignment.center,
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 600),
                height: 2,
                width: double.infinity,
                margin: const EdgeInsets.symmetric(horizontal: 12),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Colors.red.withOpacity(.0),
                      Colors.red.withOpacity(.8),
                      Colors.red.withOpacity(.0),
                    ],
                  ),
                ),
              ),
            ),
          ),
      ],
    );
  }
}
