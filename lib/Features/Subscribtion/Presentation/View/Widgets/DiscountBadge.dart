import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:sintir/Core/utils/textStyles.dart';

class DiscountBadge extends StatelessWidget {
  final double percent;

  const DiscountBadge({super.key, required this.percent});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(14),
        gradient: const LinearGradient(
          colors: [
            Color(0xffFF4D4D),
            Color(0xffFF6A88),
          ],
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(FontAwesomeIcons.percent, color: Colors.white, size: 14),
          const SizedBox(width: 6),
          Text(
            "خصم ${percent.toStringAsFixed(0)}%",
            style: AppTextStyles(context).bold14.copyWith(color: Colors.white),
          ),
        ],
      ),
    );
  }
}
