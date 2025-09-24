import 'package:flutter/material.dart';
import 'package:sintir/Core/utils/textStyles.dart';

class ScoreStatCard extends StatelessWidget {
  const ScoreStatCard({
    super.key,
    required this.label,
    required this.value,
    required this.total,
    required this.color,
  });

  final String label;
  final String value;
  final String total;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        children: [
          Row(
            children: [
              Text("$total/", style: AppTextStyles.semiBold16),
              Text(
                value,
                style: AppTextStyles.semiBold16.copyWith(color: color),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Text(
            label,
            style: AppTextStyles.bold16Auto,
          ),
        ],
      ),
    );
  }
}
