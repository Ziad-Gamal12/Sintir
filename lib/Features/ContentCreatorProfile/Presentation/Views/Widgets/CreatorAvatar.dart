import 'package:flutter/material.dart';
import 'package:sintir/Core/widgets/CustomCachedNetworkImage.dart';

class CreatorAvatar extends StatelessWidget {
  final String imageUrl;

  const CreatorAvatar({super.key, required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final Color primaryColor = theme.colorScheme.primary;

    return Container(
      padding: const EdgeInsets.all(3),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(
          color: primaryColor.withValues(alpha: 0.5),
          width: 2,
        ),
      ),
      child: SizedBox(
        width: 92,
        height: 92,
        child: ClipOval(
          child: CustomCachedNetworkImage(
            imageUrl: imageUrl,
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}
