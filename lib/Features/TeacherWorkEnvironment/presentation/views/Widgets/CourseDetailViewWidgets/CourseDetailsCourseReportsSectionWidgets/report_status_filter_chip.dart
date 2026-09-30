import 'package:flutter/material.dart';

class ReportStatusFilterChip extends StatelessWidget {
  const ReportStatusFilterChip({
    super.key,
    required this.label,
    required this.count,
    required this.selected,
    required this.onTap,
    this.compact = false,
  });

  final String label;
  final int count;
  final bool selected;
  final VoidCallback onTap;

  final bool compact;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;

    final onPrimary =
        ThemeData.estimateBrightnessForColor(scheme.primary) == Brightness.dark
            ? Colors.white
            : Colors.black;

    final backgroundColor = selected ? scheme.primary : scheme.surface;
    final foregroundColor = selected ? onPrimary : scheme.onSurface;
    final borderColor = selected
        ? Colors.transparent
        : scheme.onSurface.withValues(alpha: 0.16);

    final textStyle =
        (theme.textTheme.labelLarge ?? const TextStyle()).copyWith(
      color: foregroundColor,
      fontWeight: selected ? FontWeight.w700 : FontWeight.w500,
    );

    return MergeSemantics(
      child: Semantics(
        button: true,
        selected: selected,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          curve: Curves.easeOut,
          constraints: BoxConstraints(minHeight: compact ? 36 : 44),
          decoration: ShapeDecoration(
            color: backgroundColor,
            shape: StadiumBorder(side: BorderSide(color: borderColor)),
          ),
          child: Material(
            type: MaterialType.transparency,
            child: InkWell(
              customBorder: const StadiumBorder(),
              onTap: onTap,
              child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: compact ? 14 : 20,
                  vertical: 8,
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(label, style: textStyle, maxLines: 1, softWrap: false),
                    const SizedBox(width: 4),
                    Text('($count)', style: textStyle),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
