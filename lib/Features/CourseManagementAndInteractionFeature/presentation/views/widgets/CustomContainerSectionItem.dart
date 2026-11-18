import 'package:flutter/material.dart';

class CustomContainerSectionItem extends StatelessWidget {
  const CustomContainerSectionItem({
    super.key,
    required this.child,
    this.onTap,
  });
  final Widget child;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return SizedBox(
      width: double.infinity,
      child: Material(
        color: scheme.onSurface.withValues(alpha: 0.05),
        borderRadius: BorderRadius.circular(12),
        clipBehavior: Clip.antiAlias,
        child: InkWell(
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsetsDirectional.only(start: 14, end: 4),
            child: child,
          ),
        ),
      ),
    );
  }
}
