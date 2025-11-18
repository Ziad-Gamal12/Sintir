import 'package:flutter/material.dart';
import 'package:sintir/Core/utils/textStyles.dart';

class CustomReviewExamInfoRow extends StatelessWidget {
  const CustomReviewExamInfoRow({
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
    return Card(
      elevation: 5,
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(value,
                textAlign: TextAlign.center,
                overflow: TextOverflow.ellipsis,
                style: AppTextStyles(context).regular14),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(icon, color: Colors.black, size: 25),
                const SizedBox(width: 5),
                Text(label, style: AppTextStyles(context).bold16),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
