import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sintir/locale_keys.dart';

class TransactionDetailCopyButton extends StatelessWidget {
  const TransactionDetailCopyButton({super.key, required this.value});
  final String value;

  @override
  Widget build(BuildContext context) => IconButton(
    tooltip: LocaleKeys.transactionsCopy,
    visualDensity: VisualDensity.compact,
    constraints: const BoxConstraints(minWidth: 40, minHeight: 40),
    onPressed: () => _copy(context),
    icon: const Icon(Icons.copy_outlined, size: 16),
  );

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
