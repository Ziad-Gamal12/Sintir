import 'package:flutter/material.dart';
import 'package:sintir/Core/utils/textStyles.dart';
import 'package:sintir/locale_keys.dart';

/// Tonal "View result" button (same look as the original design, but placed
/// last in the card). Presentational only: navigation is handled by the
/// card's InkWell in StudentResultCard.
class StudentResultCardAction extends StatelessWidget {
  const StudentResultCardAction({super.key});

  @override
  Widget build(BuildContext context) {
    final style = AppTextStyles(context);
    final theme = Theme.of(context);
    final primary = theme.colorScheme.primary;

    // Raw brand blue on the dark card is ~3.4:1; use a lighter tint of the
    // same hue for text/icon in dark mode.
    final contentColor = theme.brightness == Brightness.dark
        ? Color.lerp(primary, Colors.white, .3)!
        : primary;

    return Container(
      constraints: const BoxConstraints(minHeight: 44),
      alignment: Alignment.center,
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: primary.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.visibility_rounded, color: contentColor, size: 20),
          const SizedBox(width: 6),
          Flexible(
            child: Text(
              LocaleKeys.viewResult,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: style.semiBold14.copyWith(color: contentColor),
            ),
          ),
        ],
      ),
    );
  }
}
