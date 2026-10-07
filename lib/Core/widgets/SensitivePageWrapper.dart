import 'package:flutter/material.dart';
import 'package:secure_content/secure_content.dart';

class SensitivePageWrapper extends StatelessWidget {
  final Widget child;
  final String watermarkText;

  const SensitivePageWrapper({
    required this.child,
    this.watermarkText = 'Sintir - Sensitive Content',
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SecureContentScope(
      enabled: true,
      protectInAppSwitcher: true,
      policy: SecureContentPolicy(
        enableIntegrityChecks: true,
        hardBlockOnIntegrityRisk: false,
        enableRiskWatermark: true,
        watermarkText: watermarkText,
      ),
      child: child,
    );
  }
}
