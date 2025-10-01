import 'package:flutter/material.dart';
import 'package:sintir/Core/utils/textStyles.dart';
import 'package:sintir/constant.dart';

class AverageScoreCard extends StatelessWidget {
  const AverageScoreCard({super.key});

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
          Text(
            "6.0",
            style: AppTextStyles(context).bold24.copyWith(color: KMainColor),
          ),
          const SizedBox(height: 10),
          Text(
            "معدل النتائج",
            style: AppTextStyles(context).bold16,
          ),
        ],
      ),
    );
  }
}
