import 'package:flutter/material.dart';
import 'package:sintir/Core/helper/confirm_delete_dialog.dart';
import 'package:sintir/locale_keys.dart';

enum _MenuAction { delete }

class DeleteMenuButton extends StatelessWidget {
  const DeleteMenuButton({
    super.key,
    required this.confirmTitle,
    required this.itemName,
    required this.onConfirmed,
    this.isLoading = false,
  });
  final String confirmTitle, itemName;
  final VoidCallback onConfirmed;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;

    if (isLoading) {
      return const SizedBox.square(
        dimension: 48,
        child: Center(
          child: SizedBox.square(
            dimension: 20,
            child: CircularProgressIndicator(strokeWidth: 2),
          ),
        ),
      );
    }

    return PopupMenuButton<_MenuAction>(
      icon: Icon(
        Icons.more_vert_rounded,
        color: scheme.onSurface.withValues(alpha: 0.6),
      ),
      onSelected: (_) async {
        final confirmed = await showConfirmDeleteDialog(
          context,
          title: confirmTitle,
          itemName: itemName,
          message: LocaleKeys.cannotBeUndone,
          confirmLabel: LocaleKeys.delete,
          cancelLabel: LocaleKeys.cancel,
        );
        if (confirmed && context.mounted) onConfirmed();
      },
      itemBuilder: (_) => [
        PopupMenuItem(
          value: _MenuAction.delete,
          child: Row(
            children: [
              Icon(Icons.delete_outline_rounded, size: 20, color: scheme.error),
              const SizedBox(width: 12),
              Text(LocaleKeys.delete, style: TextStyle(color: scheme.error)),
            ],
          ),
        ),
      ],
    );
  }
}
