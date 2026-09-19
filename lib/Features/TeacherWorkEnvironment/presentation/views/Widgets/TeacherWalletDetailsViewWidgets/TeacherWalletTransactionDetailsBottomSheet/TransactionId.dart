import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/Widgets/TeacherWalletDetailsViewWidgets/TeacherWalletTransactionDetailsBottomSheet/TransactionDetailRow.dart';
import 'package:sintir/locale_keys.dart';

class TransactionId extends StatefulWidget {
  const TransactionId({super.key, required this.transactionId});

  final String transactionId;

  @override
  State<TransactionId> createState() => _TransactionIdState();
}

class _TransactionIdState extends State<TransactionId> {
  bool transIdCopied = false;
  Timer? _resetTimer;

  void _handleCopy() {
    Clipboard.setData(ClipboardData(text: widget.transactionId));
    _resetTimer?.cancel();
    setState(() => transIdCopied = true);
    _resetTimer = Timer(const Duration(seconds: 2), () {
      if (mounted) setState(() => transIdCopied = false);
    });
  }

  @override
  void dispose() {
    _resetTimer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return TransactionDetailRow(
      label: LocaleKeys.transactionIdLabel,
      value: _formatTruncatedId(widget.transactionId),
      leading: SizedBox(
        height: 16,
        width: 16,
        child: AnimatedSwitcher(
          duration: const Duration(milliseconds: 250),
          switchInCurve: Curves.easeOutBack,
          switchOutCurve: Curves.easeIn,
          transitionBuilder: (child, animation) {
            return ScaleTransition(
              scale: animation,
              child: FadeTransition(opacity: animation, child: child),
            );
          },
          child: IconButton(
            padding: EdgeInsets.zero,
            constraints: const BoxConstraints(),
            tooltip: transIdCopied
                ? LocaleKeys.transactionIdCopiedTooltip
                : LocaleKeys.copyTransactionIdTooltip,
            onPressed: _handleCopy,
            icon: FittedBox(
              child: Icon(
                transIdCopied ? Icons.check : Icons.copy,
                key: ValueKey(transIdCopied),
                size: 16,
                color: transIdCopied
                    ? Colors.green.shade600
                    : theme.colorScheme.primary,
              ),
            ),
          ),
        ),
      ),
      showDivider: false,
    );
  }

  String _formatTruncatedId(String? id) {
    if (id == null || id.isEmpty) return '';
    if (id.length <= 8) return id;
    final start = id.substring(0, 4);
    final end = id.substring(id.length - 4);
    return '$start......$end';
  }
}
