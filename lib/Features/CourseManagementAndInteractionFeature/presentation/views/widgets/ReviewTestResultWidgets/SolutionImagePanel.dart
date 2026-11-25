import 'package:flutter/material.dart';
import 'package:sintir/Core/widgets/CustomCachedNetworkImage.dart';

/// The teacher's explanation image, shown inline under the answers so the
/// student can compare it with them.
///
/// It spans the card's width and keeps its own aspect ratio up to
/// [maxHeight]; taller images are scaled down whole, never cropped.
class SolutionImagePanel extends StatelessWidget {
  const SolutionImagePanel({
    super.key,
    required this.imageUrl,
    required this.maxHeight,
  });

  final String imageUrl;
  final double maxHeight;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: theme.colorScheme.surfaceContainerHighest.withValues(
            alpha: 0.5,
          ),
          border: Border.all(
            color: theme.primaryColor.withValues(alpha: 0.4),
          ),
          borderRadius: BorderRadius.circular(10),
        ),
        child: ConstrainedBox(
          constraints: BoxConstraints(maxHeight: maxHeight),
          child: CustomCachedNetworkImage(
            imageUrl: imageUrl,
            fit: BoxFit.contain,
          ),
        ),
      ),
    );
  }
}
