import 'package:flutter/material.dart';

class ReportReasonCardBadge extends StatelessWidget {
  const ReportReasonCardBadge(
      {super.key,
      required this.icon,
      required this.color,
      this.isShapeCircle = true});
  final IconData icon;
  final Color color;
  final bool? isShapeCircle;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 40,
      height: 40,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1),
        shape: isShapeCircle == true ? BoxShape.circle : BoxShape.rectangle,
        borderRadius: isShapeCircle == true ? null : BorderRadius.circular(8),
      ),
      child: Icon(
        icon,
        size: 16,
        color: color,
      ),
    );
  }
}
