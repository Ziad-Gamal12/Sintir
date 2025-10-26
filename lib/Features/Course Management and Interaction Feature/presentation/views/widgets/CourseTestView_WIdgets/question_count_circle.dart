import 'package:flutter/material.dart';
import 'package:sintir/Core/utils/textStyles.dart';

class QuestionCountCircle extends StatelessWidget {
  const QuestionCountCircle({
    super.key,
    required this.count,
    required this.borderColor,
    this.tooltip,
  });

  final int count;
  final Color borderColor;

  final String? tooltip;

  @override
  Widget build(BuildContext context) {
    final circle = Container(
      padding: const EdgeInsets.all(20),
      margin: const EdgeInsets.symmetric(vertical: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        shape: BoxShape.circle,
        border: Border.all(color: borderColor, width: 1.6),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Text(
        count.toString(),
        style: AppTextStyles(context).bold14,
      ),
    );

    return tooltip != null ? Tooltip(message: tooltip!, child: circle) : circle;
  }
}
