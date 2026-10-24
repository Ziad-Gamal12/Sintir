import 'package:flutter/material.dart';
import 'package:sintir/locale_keys.dart';
import 'package:url_launcher/url_launcher.dart';

class SubscriberCallButton extends StatelessWidget {
  const SubscriberCallButton({super.key, required this.phoneNumber});

  final String phoneNumber;

  Future<void> _call(BuildContext context) async {
    final phone = phoneNumber.trim();
    if (phone.isEmpty) return;
    var launched = false;
    try {
      launched = await launchUrl(
        Uri(scheme: 'tel', path: phone),
        mode: LaunchMode.externalApplication,
      );
    } catch (_) {
      launched = false;
    }
    if (!context.mounted) return;
    if (!launched) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(LocaleKeys.subscriberPhoneFallback)),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final enabled = phoneNumber.trim().isNotEmpty;
    return IconButton(
      tooltip: LocaleKeys.phoneNumber,
      onPressed: enabled ? () => _call(context) : null,
      constraints: const BoxConstraints(minWidth: 48, minHeight: 48),
      style: IconButton.styleFrom(
        backgroundColor: theme.colorScheme.primary,
        foregroundColor: theme.colorScheme.onPrimary,
        disabledBackgroundColor: theme.colorScheme.surfaceContainerHighest,
        disabledForegroundColor: theme.colorScheme.onSurfaceVariant,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
      icon: const Icon(Icons.phone_rounded, size: 20),
    );
  }
}
