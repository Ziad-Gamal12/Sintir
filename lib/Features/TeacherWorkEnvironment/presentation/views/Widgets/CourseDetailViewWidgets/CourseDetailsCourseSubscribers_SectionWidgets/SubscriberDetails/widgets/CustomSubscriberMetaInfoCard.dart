import 'package:flutter/material.dart';
import 'package:sintir/Core/utils/textStyles.dart';

class CustomSubscriberMetaInfoCard extends StatelessWidget {
  const CustomSubscriberMetaInfoCard(
      {super.key,
      required this.text,
      required this.icon,
      this.iconColor,
      this.textDirection});
  final String text;
  final IconData icon;
  final Color? iconColor;
  final TextDirection? textDirection;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textStyles = AppTextStyles(context);
    final iconColor = this.iconColor ?? theme.colorScheme.onSurfaceVariant;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
      alignment: AlignmentDirectional.centerStart,
      decoration: BoxDecoration(
          border: Border.all(
              width: 1, color: theme.dividerColor.withValues(alpha: .45)),
          color:
              theme.colorScheme.surfaceContainerHighest.withValues(alpha: .45),
          borderRadius: BorderRadius.circular(12)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Icon(
            icon,
            color: iconColor,
            size: 16,
          ),
          SizedBox(
            width: 8,
          ),
          Expanded(
            child: Directionality(
              textDirection: textDirection ?? Directionality.of(context),
              child: Text(
                text,
                style: textStyles.semiBold12.copyWith(
                  color: theme.colorScheme.onSurface,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          )
        ],
      ),
    );
  }
}
