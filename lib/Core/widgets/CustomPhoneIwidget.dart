import 'package:flutter/material.dart';
import 'package:sintir/locale_keys.dart';
import 'package:url_launcher/url_launcher.dart';

class CustomPhoneIwidget extends StatelessWidget {
  const CustomPhoneIwidget({
    super.key,
    required this.phoneNumber,
  });

  final String phoneNumber;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return IconButton(
      tooltip: LocaleKeys.phoneNumber,
      onPressed: phoneNumber.trim().isEmpty
          ? null
          : () async {
              final uri = Uri(scheme: 'tel', path: phoneNumber.trim());
              try {
                await launchUrl(uri, mode: LaunchMode.externalApplication);
              } catch (_) {}
            },
      icon: Icon(Icons.phone, color: theme.colorScheme.primary, size: 21),
      style: IconButton.styleFrom(
        backgroundColor: theme.colorScheme.primary.withValues(alpha: .08),
        side:
            BorderSide(color: theme.colorScheme.primary.withValues(alpha: .35)),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
      ),
    );
  }
}
