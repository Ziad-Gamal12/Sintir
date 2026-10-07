import 'package:flutter/material.dart';
import 'package:sintir/Core/utils/textStyles.dart';
import 'package:sintir/locale_keys.dart';

class SelectedVideoActions extends StatelessWidget {
  const SelectedVideoActions({
    super.key,
    required this.enabled,
    required this.onChange,
    required this.onRemove,
  });

  final bool enabled;
  final VoidCallback onChange;
  final VoidCallback onRemove;

  @override
  Widget build(BuildContext context) {
    final styles = AppTextStyles(context);
    const minimumSize = Size(48, 48);

    return Wrap(
      alignment: WrapAlignment.spaceBetween,
      crossAxisAlignment: WrapCrossAlignment.center,
      children: [
        TextButton.icon(
          onPressed: enabled ? onChange : null,
          icon: const Icon(Icons.swap_horiz),
          label: Text(LocaleKeys.changeVideo, style: styles.semiBold14),
          style: TextButton.styleFrom(minimumSize: minimumSize),
        ),
        TextButton.icon(
          onPressed: enabled ? onRemove : null,
          icon: const Icon(Icons.delete_outline),
          label: Text(LocaleKeys.removeSelectedVideo, style: styles.semiBold14),
          style: TextButton.styleFrom(
            minimumSize: minimumSize,
            foregroundColor: Colors.red,
          ),
        ),
      ],
    );
  }
}
