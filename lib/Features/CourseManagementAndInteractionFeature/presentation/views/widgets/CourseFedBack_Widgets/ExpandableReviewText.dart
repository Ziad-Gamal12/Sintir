// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:sintir/Core/utils/textStyles.dart';
import 'package:sintir/constant.dart';
import 'package:sintir/locale_keys.dart';

class ExpandableReviewText extends StatefulWidget {
  const ExpandableReviewText({
    super.key,
    required this.text,
    this.style,
    this.collapsedMaxLines = 3,
  });

  final String text;
  final TextStyle? style;
  final int collapsedMaxLines;

  @override
  State<ExpandableReviewText> createState() => _ExpandableReviewTextState();
}

class _ExpandableReviewTextState extends State<ExpandableReviewText> {
  bool _expanded = false;

  @override
  void didUpdateWidget(covariant ExpandableReviewText oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.text != widget.text) _expanded = false;
  }

  @override
  Widget build(BuildContext context) {
    final style = DefaultTextStyle.of(context).style.merge(widget.style);
    return LayoutBuilder(
      builder: (context, constraints) {
        final overflows = _overflows(context, style, constraints.maxWidth);
        final collapsed = overflows && !_expanded;
        final text = Text(
          widget.text,
          style: style,
          maxLines: collapsed ? widget.collapsedMaxLines : null,
          overflow: collapsed ? TextOverflow.ellipsis : null,
        );
        if (!overflows) return text;
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            text,
            TextButton(
              key: const ValueKey('review-text-toggle'),
              onPressed: () => setState(() => _expanded = !_expanded),
              style: TextButton.styleFrom(
                foregroundColor: KMainColor,
                padding: const EdgeInsets.symmetric(horizontal: 4),
                minimumSize: const Size(48, 36),
                visualDensity: VisualDensity.compact,
              ),
              child: Text(
                _expanded ? LocaleKeys.showLess : LocaleKeys.showMore,
                style: AppTextStyles(context).semiBold12,
              ),
            ),
          ],
        );
      },
    );
  }

  bool _overflows(BuildContext context, TextStyle style, double maxWidth) {
    if (!maxWidth.isFinite) return false;
    final painter = TextPainter(
      text: TextSpan(text: widget.text, style: style),
      maxLines: widget.collapsedMaxLines,
      textDirection: Directionality.of(context),
      textScaler: MediaQuery.textScalerOf(context),
      locale: Localizations.maybeLocaleOf(context),
    )..layout(maxWidth: maxWidth);
    final overflows = painter.didExceedMaxLines;
    painter.dispose();
    return overflows;
  }
}
