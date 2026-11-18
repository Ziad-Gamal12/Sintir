// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:sintir/locale_keys.dart';

enum ReviewAction { reply, editReply, deleteReply, report }

class ReviewActionsMenu extends StatelessWidget {
  const ReviewActionsMenu({
    super.key,
    required this.hasReply,
    this.onReply,
    this.onDeleteReply,
    this.onReport,
  });

  final bool hasReply;
  final VoidCallback? onReply;
  final VoidCallback? onDeleteReply;
  final VoidCallback? onReport;

  static const Color danger = Color(0xFFC62828);

  @override
  Widget build(BuildContext context) {
    final items = <PopupMenuEntry<ReviewAction>>[
      if (onReply != null)
        _item(
          hasReply ? ReviewAction.editReply : ReviewAction.reply,
          hasReply ? Icons.edit_outlined : Icons.reply_rounded,
          hasReply ? LocaleKeys.reviewReplyEdit : LocaleKeys.reviewReplyAction,
        ),
      if (hasReply && onDeleteReply != null)
        _item(
          ReviewAction.deleteReply,
          Icons.delete_outline_rounded,
          LocaleKeys.reviewReplyDelete,
          color: danger,
        ),
      if (onReport != null)
        _item(
          ReviewAction.report,
          Icons.flag_outlined,
          LocaleKeys.reviewReportAction,
          color: danger,
        ),
    ];
    if (items.isEmpty) return const SizedBox.shrink();
    return PopupMenuButton<ReviewAction>(
      key: const ValueKey('review-actions-menu'),
      tooltip: LocaleKeys.reviewActions,
      icon: Icon(
        Icons.more_vert_rounded,
        color: Theme.of(context).textTheme.bodySmall?.color,
      ),
      position: PopupMenuPosition.under,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      onSelected: (action) {
        switch (action) {
          case ReviewAction.reply:
          case ReviewAction.editReply:
            onReply?.call();
          case ReviewAction.deleteReply:
            onDeleteReply?.call();
          case ReviewAction.report:
            onReport?.call();
        }
      },
      itemBuilder: (_) => items,
    );
  }

  PopupMenuItem<ReviewAction> _item(
    ReviewAction value,
    IconData icon,
    String label, {
    Color? color,
  }) {
    return PopupMenuItem<ReviewAction>(
      key: ValueKey('review-action-${value.name}'),
      value: value,
      child: Row(
        children: [
          Icon(icon, size: 18, color: color),
          const SizedBox(width: 10),
          Text(label, style: TextStyle(color: color)),
        ],
      ),
    );
  }
}
