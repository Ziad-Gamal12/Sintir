import 'package:flutter/material.dart';

class WalletDetailRow extends StatelessWidget {
  const WalletDetailRow({
    super.key,
    required this.label,
    required this.value,
    this.showDivider = true,
  });

  final String label;
  final Widget value;
  final bool showDivider;

  factory WalletDetailRow.text({
    Key? key,
    required String label,
    required String value,
    bool showDivider = true,
  }) {
    return WalletDetailRow(
      key: key,
      label: label,
      value: Text(
        value,
        textAlign: TextAlign.end,
      ),
      showDivider: showDivider,
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 20,
            vertical: 14,
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                label,
                textAlign: TextAlign.end,
                style: theme.textTheme.bodyMedium?.copyWith(
                  color: colorScheme.onSurface.withValues(
                    alpha: 0.65,
                  ),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Align(
                  alignment: AlignmentDirectional.centerEnd,
                  child: value,
                ),
              ),
            ],
          ),
        ),
        if (showDivider)
          Divider(
            height: 1,
            indent: 20,
            endIndent: 20,
            color: colorScheme.onSurface.withValues(
              alpha: 0.06,
            ),
          ),
      ],
    );
  }
}
