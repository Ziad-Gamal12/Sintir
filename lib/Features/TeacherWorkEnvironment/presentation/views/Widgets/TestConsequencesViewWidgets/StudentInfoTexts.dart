import 'package:flutter/material.dart';
import 'package:sintir/Core/utils/textStyles.dart';

class StudentInfoTexts extends StatelessWidget {
  const StudentInfoTexts({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Text("محمد علي", style: AppTextStyles.semiBold20),
        const SizedBox(height: 2),
        Text(
          "142635671231",
          style: AppTextStyles.regular14.copyWith(color: Colors.grey),
        ),
        const SizedBox(height: 4),
        Text(
          "12/4/2023",
          style: AppTextStyles.regular14.copyWith(color: Colors.grey),
        ),
      ],
    );
  }
}
