import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:secure_content/secure_content.dart';
import 'package:sintir/Core/helper/BiometricAvailability.dart';

class SensitivePageWrapper extends StatelessWidget {
  const SensitivePageWrapper({
    required this.child,
    this.requireBiometric = false,
    this.inactivityTimeout,
    this.hardBlockOnRisk = false,
    this.showRiskWatermark = false,
    this.watermarkText,
    this.onSecurityEvent,
    super.key,
  });

  final Widget child;
  final bool requireBiometric;
  final Duration? inactivityTimeout;
  final bool hardBlockOnRisk;
  final bool showRiskWatermark;
  final String? watermarkText;
  final void Function(String eventName)? onSecurityEvent;

  @override
  Widget build(BuildContext context) {
    final useAuth = requireBiometric && BiometricAvailability.isAvailable;

    return SecureContentScope(
      enabled: true,
      protectInAppSwitcher: true,
      appSwitcherColor: Colors.black,
      policy: SecureContentPolicy(
        requireBiometricOnResume: useAuth,
        inactivityTimeout: useAuth ? inactivityTimeout : null,
        enableIntegrityChecks: !kDebugMode,
        hardBlockOnIntegrityRisk: hardBlockOnRisk,
        enableRiskWatermark: showRiskWatermark,
        watermarkText: watermarkText ?? 'SINTIR',
      ),
      onEvent: (event) => onSecurityEvent?.call(event.type.name),
      child: child,
    );
  }
}
