import 'package:flutter/material.dart';
import 'package:sintir/Core/utils/textStyles.dart';

class PriceCard extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;
  final bool highlight;
  final bool isOriginal;
  final bool showStrike;

  const PriceCard({
    super.key,
    required this.icon,
    required this.label,
    required this.value,
    this.highlight = false,
    this.isOriginal = false,
    this.showStrike = false,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        AnimatedContainer(
          duration: const Duration(milliseconds: 400),
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            color: highlight
                ? Colors.green.withOpacity(0.12)
                : Colors.blueGrey.withOpacity(0.07),
            border: Border.all(
              color: highlight
                  ? Colors.greenAccent
                  : Colors.blueGrey.withOpacity(0.2),
              width: highlight ? 1.5 : 1,
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(.05),
                blurRadius: 10,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Row(
            children: [
              Icon(icon,
                  size: 20,
                  color: highlight ? Colors.green.shade600 : Colors.grey),
              const SizedBox(width: 12),

              // PRICE TEXT
              Expanded(
                child: Text(
                  label,
                  style: AppTextStyles(context).semiBold14.copyWith(
                      color: highlight
                          ? Colors.green.shade600
                          : Colors.black87), // TextStyle(
                ),
              ),

              AnimatedOpacity(
                opacity: 1,
                duration: const Duration(milliseconds: 300),
                child: Text(
                  value,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    decoration:
                        (showStrike ? TextDecoration.lineThrough : null),
                    decorationColor: Colors.red,
                    decorationThickness: 2,
                    color: highlight ? Colors.green.shade600 : Colors.black87,
                  ),
                ),
              ),
            ],
          ),
        ),

        // ANIMATED LINE FOR ORIGINAL PRICE
        if (showStrike)
          Positioned.fill(
            child: Align(
              alignment: Alignment.center,
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 600),
                height: 2,
                width: double.infinity,
                margin: const EdgeInsets.symmetric(horizontal: 12),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Colors.red.withOpacity(.0),
                      Colors.red.withOpacity(.8),
                      Colors.red.withOpacity(.0),
                    ],
                  ),
                ),
              ),
            ),
          ),
      ],
    );
  }
}
