import 'package:flutter/material.dart';
import 'package:sintir/Core/utils/textStyles.dart';

class TestStatsInfo extends StatelessWidget {
  const TestStatsInfo({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildStatColumn("عدد الطلاب الكلى:", "100"),
            verticalDivider(),
            _buildStatColumn("عدد الطلاب الحاضرين:", "80"),
          ],
        ),
        horizontalDivider(),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildStatColumn("عدد الطلاب النجاح:", "60", color: Colors.green),
            verticalDivider(),
            _buildStatColumn("عدد الطلاب الرسوب:", "40", color: Colors.red),
          ],
        ),
      ],
    );
  }

  Widget _buildStatColumn(String label, String value,
      {Color color = Colors.black}) {
    return Column(
      children: [
        Text(label,
            style: AppTextStyles.semiBold14.copyWith(color: Colors.black)),
        const SizedBox(height: 10),
        Text(value, style: AppTextStyles.regular14.copyWith(color: color)),
      ],
    );
  }

  Widget verticalDivider() => Container(
        margin: const EdgeInsets.symmetric(horizontal: 10),
        height: 50,
        width: 1,
        color: Colors.black,
      );

  Widget horizontalDivider() => Container(
        margin: const EdgeInsets.symmetric(vertical: 10),
        height: 1,
        color: Colors.black,
      );
}
