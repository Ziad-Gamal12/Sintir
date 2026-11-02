import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sintir/Core/utils/textStyles.dart';
import 'package:sintir/locale_keys.dart';

class TransactionDetailRow extends StatelessWidget {
  const TransactionDetailRow({
    super.key,
    required this.icon,
    required this.label,
    required this.value,
    this.copy = false,
    this.ltr = false,
    this.valueColor,
  });

  final IconData icon;
  final String label;
  final String value;
  final bool copy;
  final bool ltr;
  final Color? valueColor;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 3),
      padding: const EdgeInsetsDirectional.fromSTEB(10, 10, 8, 10),
      decoration: BoxDecoration(
        color: theme.cardColor,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        children: [
          Icon(icon, size: 18, color: theme.colorScheme.onSurfaceVariant),
          const SizedBox(width: 8),
          Expanded(
            flex: 4,
            child: Text(
              label,
              style: AppTextStyles(
                context,
              ).regular11.copyWith(color: theme.colorScheme.onSurfaceVariant),
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            flex: 6,
            child: Directionality(
              textDirection: ltr
                  ? TextDirection.ltr
                  : Directionality.of(context),
              child: Text(
                value,
                textAlign: TextAlign.end,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: AppTextStyles(context).regular12.copyWith(
                  color: valueColor ?? theme.colorScheme.onSurface,
                ),
              ),
            ),
          ),
          if (copy)
            IconButton(
              tooltip: LocaleKeys.transactionsCopy,
              visualDensity: VisualDensity.compact,
              onPressed: () => _copy(context),
              icon: const Icon(Icons.copy_outlined, size: 16),
            ),
        ],
      ),
    );
  }

  Future<void> _copy(BuildContext context) async {
    await Clipboard.setData(ClipboardData(text: value));
    await HapticFeedback.selectionClick();
    if (context.mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(LocaleKeys.transactionsCopied),
          duration: const Duration(seconds: 2),
        ),
      );
    }
  }
}
