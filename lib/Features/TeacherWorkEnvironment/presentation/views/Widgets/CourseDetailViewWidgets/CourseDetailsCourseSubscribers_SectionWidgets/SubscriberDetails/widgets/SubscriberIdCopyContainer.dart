import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sintir/Core/utils/textStyles.dart';
import 'package:sintir/locale_keys.dart';

class SubscriberIdCopyContainer extends StatelessWidget {
  const SubscriberIdCopyContainer({super.key, required this.subscriberID});

  final String subscriberID;

  String _displayId(String id) => id.length <= 20
      ? id
      : '${id.substring(0, 8)}...${id.substring(id.length - 6)}';

  Future<void> _copy(BuildContext context) async {
    var copied = false;
    try {
      await Clipboard.setData(ClipboardData(text: subscriberID));
      copied = true;
    } catch (_) {
      copied = false;
    }
    if (!context.mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content:
          Text(copied ? LocaleKeys.subscriberIdCopied : LocaleKeys.copyFailed),
    ));
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final styles = AppTextStyles(context);
    return Container(
      padding: const EdgeInsetsDirectional.fromSTEB(12, 4, 4, 4),
      decoration: BoxDecoration(
        color: theme.colorScheme.surfaceContainerHighest.withValues(alpha: .55),
        border: Border.all(color: theme.dividerColor.withValues(alpha: .5)),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Text('${LocaleKeys.studentCode} ', style: styles.medium12),
          Expanded(
            child: Directionality(
              textDirection: TextDirection.ltr,
              child: Text(
                _displayId(subscriberID),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: styles.regular12.copyWith(
                  color: theme.colorScheme.onSurfaceVariant,
                ),
              ),
            ),
          ),
          IconButton(
            tooltip: LocaleKeys.copy,
            onPressed: subscriberID.isEmpty ? null : () => _copy(context),
            icon: const Icon(Icons.copy_rounded, size: 17),
            constraints: const BoxConstraints(minWidth: 40, minHeight: 40),
          ),
        ],
      ),
    );
  }
}
