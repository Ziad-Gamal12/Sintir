// CustomSubscriberMetaInfoCard.dart
import 'package:flutter/material.dart';
import 'package:sintir/Core/utils/textStyles.dart';
import 'package:sintir/Core/widgets/results/results_tokens.dart';

class CustomSubscriberMetaInfoCard extends StatelessWidget {
  const CustomSubscriberMetaInfoCard({
    super.key,
    required this.text,
    required this.icon,
    this.accent,
    this.textDirection,
    this.maxLines = 1,
    this.isPlaceholder = false,
  });

  final String text;
  final IconData icon;
  final Color? accent;
  final TextDirection? textDirection;
  final int maxLines;
  final bool isPlaceholder;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDarkMode = theme.brightness == Brightness.dark;
    final scheme = theme.colorScheme;
    final radius = BorderRadius.circular(14);
    final tokens = ResultsTokens.of(theme);

    final mutedColor = scheme.onSurfaceVariant;

    final badgeColor = isPlaceholder ? mutedColor : (accent ?? scheme.primary);
    final textColor = isPlaceholder ? mutedColor : scheme.onSurface;

    return Semantics(
      child: Material(
        color: tokens.inner,
        clipBehavior: Clip.antiAlias,
        shape: RoundedRectangleBorder(
          borderRadius: radius,
          side: BorderSide(color: tokens.border),
        ),
        child: ConstrainedBox(
          constraints: const BoxConstraints(minHeight: 44),
          child: Padding(
            padding: const EdgeInsetsDirectional.fromSTEB(8, 8, 12, 8),
            child: Row(children: [
              _MetaIconBadge(icon: icon, color: badgeColor),
              const SizedBox(width: 8),
              Expanded(
                child: Align(
                  alignment: AlignmentDirectional.centerStart,
                  child: Directionality(
                    textDirection: textDirection ?? Directionality.of(context),
                    child: Text(
                      text,
                      maxLines: maxLines,
                      overflow: TextOverflow.ellipsis,
                      style: AppTextStyles(context).medium12.copyWith(
                        color: textColor,
                        fontFeatures: const [FontFeature.tabularFigures()],
                      ),
                    ),
                  ),
                ),
              ),
            ]),
          ),
        ),
      ),
    );
  }
}

class _MetaIconBadge extends StatelessWidget {
  const _MetaIconBadge({required this.icon, required this.color});
  final IconData icon;
  final Color color;

  @override
  Widget build(BuildContext context) => Container(
        width: 28,
        height: 28,
        decoration: BoxDecoration(
          color: color.withValues(alpha: .14),
          borderRadius: BorderRadius.circular(9),
        ),
        child: Icon(icon, size: 16, color: color),
      );
}
