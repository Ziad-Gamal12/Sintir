import 'package:flutter/material.dart';
import 'package:sintir/locale_keys.dart';

class ReportDescriptionText extends StatefulWidget {
  const ReportDescriptionText(
      {super.key,
      required this.description,
      this.maxLines = 3,
      this.muted = false});
  final String description;
  final int maxLines;
  final bool muted;
  @override
  State<ReportDescriptionText> createState() => _ReportDescriptionTextState();
}

class _ReportDescriptionTextState extends State<ReportDescriptionText> {
  bool expanded = false;
  @override
  Widget build(BuildContext context) =>
      LayoutBuilder(builder: (context, constraints) {
        final theme = Theme.of(context);
        final style = theme.textTheme.bodyMedium ?? const TextStyle();
        final painter = TextPainter(
            text: TextSpan(text: widget.description, style: style),
            textDirection: Directionality.of(context),
            textScaler: MediaQuery.textScalerOf(context),
            maxLines: widget.maxLines)
          ..layout(maxWidth: constraints.maxWidth);
        final overflows = painter.didExceedMaxLines;
        return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text(widget.description,
              maxLines: expanded ? null : widget.maxLines,
              overflow: expanded ? TextOverflow.visible : TextOverflow.ellipsis,
              style: style.copyWith(
                  color: widget.muted
                      ? theme.colorScheme.onSurfaceVariant
                      : theme.colorScheme.onSurface)),
          if (overflows)
            Align(
                alignment: AlignmentDirectional.centerEnd,
                child: TextButton(
                    onPressed: () => setState(() => expanded = !expanded),
                    child: Text(expanded
                        ? LocaleKeys.reportShowLess
                        : LocaleKeys.reportShowMore))),
        ]);
      });
}
