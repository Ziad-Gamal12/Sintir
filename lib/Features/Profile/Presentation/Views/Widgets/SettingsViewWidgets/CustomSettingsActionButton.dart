import 'package:flutter/material.dart';
import 'package:sintir/Core/utils/textStyles.dart';

class CustomSettingsActionButton extends StatelessWidget {
  const CustomSettingsActionButton({
    super.key,
    required this.title,
    this.leadingIcon,
    this.trailing,
    this.iconData,
    this.onTap,
  });

  final String title;
  final IconData? leadingIcon;
  final Widget? trailing;
  final IconData? iconData;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    final Color contentColor =
        isDark ? Colors.white.withOpacity(0.9) : Colors.black87;

    // Use surface container for dark mode to ensure visibility without harshness
    final Color backgroundColor =
        isDark ? theme.colorScheme.surfaceContainerHighest : Colors.white;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20), // More rounded = softer feel
          boxShadow: [
            BoxShadow(
              // The key to soft shadows: low opacity (0.03 - 0.1) and high blur (15-30)
              color: isDark
                  ? Colors.black.withOpacity(0.3)
                  : theme.primaryColor.withOpacity(0.05),
              blurRadius: 25,
              spreadRadius: 1,
              offset:
                  const Offset(0, 8), // Moves the shadow down to feel 'lifted'
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: Material(
            color: backgroundColor,
            child: InkWell(
              onTap: onTap,
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(
                    // Almost invisible border just to catch the light
                    color: isDark
                        ? Colors.white.withOpacity(0.08)
                        : Colors.black.withOpacity(0.03),
                    width: 1.5,
                  ),
                ),
                child: Row(
                  children: [
                    if (leadingIcon != null) ...[
                      Icon(leadingIcon,
                          color: contentColor.withOpacity(0.6), size: 22),
                      const SizedBox(width: 16),
                    ],
                    Expanded(
                      child: Text(
                        title,
                        style: AppTextStyles(context).semiBold16.copyWith(
                              color: contentColor,
                              letterSpacing: 0.1,
                            ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    _buildTrailing(contentColor),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTrailing(Color color) {
    if (trailing != null) return trailing!;
    if (iconData != null) {
      return Icon(iconData, color: color, size: 22);
    }
    return Icon(
      Icons.chevron_right_rounded,
      size: 26,
      color: color.withOpacity(0.2),
    );
  }
}
