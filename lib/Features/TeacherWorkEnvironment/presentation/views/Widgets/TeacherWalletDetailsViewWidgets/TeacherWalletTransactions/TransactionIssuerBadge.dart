import 'package:flutter/material.dart';
import 'package:svg_flutter/svg_flutter.dart';

class TransactionIssuerBadge extends StatelessWidget {
  const TransactionIssuerBadge({
    super.key,
    required this.issuerSVG,
    required this.issuerColor,
  });

  final String issuerSVG;
  final Color issuerColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: issuerColor.withAlpha(30),
        borderRadius: BorderRadius.circular(12),
      ),
      child: SvgPicture.asset(
        issuerSVG,
        width: 22,
        height: 22,
      ),
    );
  }
}
