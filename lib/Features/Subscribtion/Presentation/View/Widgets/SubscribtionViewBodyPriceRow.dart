import 'package:flutter/material.dart';
import 'package:sintir/Core/utils/textStyles.dart';

class SubscribtionViewBodyPriceRow extends StatelessWidget {
  const SubscribtionViewBodyPriceRow({
    super.key,
    required this.icon,
    required this.label,
    required this.value,
  });

  final IconData icon;
  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, color: Colors.grey, size: 20),
        const SizedBox(width: 10),
        Text.rich(
          TextSpan(
            children: [
              TextSpan(
                text: label,
                style: AppTextStyles.semiBold20.copyWith(color: Colors.grey),
              ),
              TextSpan(
                text: value,
                style: AppTextStyles.semiBold20
                    .copyWith(color: Colors.red.shade700),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
