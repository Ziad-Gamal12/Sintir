import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sintir/Core/utils/textStyles.dart';
import 'package:sintir/Core/widgets/CustomCopyToClipboard.dart';
import 'package:sintir/Core/widgets/results/results_tokens.dart';
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
    final tokens = ResultsTokens.of(theme);
    return Material(
      color: tokens.inner,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(14),
          side: BorderSide(color: tokens.border, width: 1)),
      child: InkWell(
        onTap: subscriberID.isEmpty ? null : () => _copy(context),
        borderRadius: BorderRadius.circular(14),
        child: Padding(
          padding: const EdgeInsetsDirectional.fromSTEB(12, 4, 4, 4),
          child: Row(children: [
            Text(LocaleKeys.studentCode,
                style: AppTextStyles(context)
                    .medium12
                    .copyWith(color: theme.colorScheme.onSurface)),
            const SizedBox(width: 6),
            Expanded(
                child: Directionality(
              textDirection: TextDirection.ltr,
              child: Text(_displayId(subscriberID),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: AppTextStyles(context).regular12.copyWith(
                      color: theme.colorScheme.onSurfaceVariant,
                      fontFeatures: const [FontFeature.tabularFigures()])),
            )),
            CustomCopyToClipboard(value: subscriberID)
          ]),
        ),
      ),
    );
  }
}
