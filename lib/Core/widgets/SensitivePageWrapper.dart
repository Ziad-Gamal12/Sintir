import 'package:flutter/material.dart';
import 'package:secure_content/secure_content.dart';

class SensitivePageWrapper extends StatelessWidget {
  final Widget child;
  const SensitivePageWrapper({required this.child, super.key});

  @override
  Widget build(BuildContext context) {
    return SecureContentScope(
      enabled: true,
      protectInAppSwitcher: true,
      policy: const SecureContentPolicy(
        requireBiometricOnResume: true,
        inactivityTimeout: Duration(seconds: 30),
        enableIntegrityChecks: true,
        hardBlockOnIntegrityRisk: false,
        enableRiskWatermark: true,
        watermarkText: 'Sintir - Sensitive Content',
      ),
      child: child,
    );
  }
}
