import 'package:flutter/material.dart';

import '../../../../../Core/utils/textStyles.dart';

class StudentTextRich extends StatelessWidget {
  final String? text1, text2;
  const StudentTextRich({super.key, this.text1, this.text2});

  @override
  Widget build(BuildContext context) {
    return Text.rich(
      TextSpan(
        children: [
          TextSpan(
            text: text1,
            style: TextStyle(
                fontWeight: AppTextStyles.bold13.fontWeight,
                color: const Color(0xff949D9E)),
          ),
          TextSpan(
            text: text2,
            style: TextStyle(
                fontWeight: AppTextStyles.bold13.fontWeight,
                color: const Color(0xff4169E2)),
          ),
        ],
      ),
    );
  }
}
