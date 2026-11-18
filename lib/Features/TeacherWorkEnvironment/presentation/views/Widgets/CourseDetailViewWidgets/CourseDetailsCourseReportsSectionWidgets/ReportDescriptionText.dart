import 'package:flutter/material.dart';
import 'package:sintir/Core/utils/textStyles.dart';

class ReportDescriptionText extends StatelessWidget {
  const ReportDescriptionText({
    super.key,
    required this.description,
    this.maxLines = 3,
    this.muted = false,
  });
  final String description;
  final int maxLines;
  final bool muted;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return Text(
      description,
      maxLines: maxLines,
      overflow: TextOverflow.ellipsis,
      style: AppTextStyles(context).regular14.copyWith(
        height: 1.5,
        color: scheme.onSurface.withValues(alpha: muted ? 0.6 : 0.9),
      ),
    );
  }
}
