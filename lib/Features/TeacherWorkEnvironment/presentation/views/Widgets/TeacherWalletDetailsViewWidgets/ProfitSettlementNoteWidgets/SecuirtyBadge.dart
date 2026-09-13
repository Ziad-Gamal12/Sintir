import 'package:flutter/material.dart';
import 'package:sintir/Core/utils/imageAssets.dart';
import 'package:svg_flutter/svg.dart';

class SecuirtyBadge extends StatelessWidget {
  const SecuirtyBadge({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return CircleAvatar(
      radius: 20,
      backgroundColor: theme.colorScheme.primary.withValues(alpha: 0.1),
      child: SvgPicture.asset(Assets.assetsIconsSVGIconsSecuirtyBadge,
          color: theme.colorScheme.primary, width: 20, height: 20),
    );
  }
}
