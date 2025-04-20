import 'package:flutter/material.dart';
import 'package:sintir/Core/utils/textStyles.dart';

class Testresultdetailsrow extends StatelessWidget {
  const Testresultdetailsrow(
      {super.key, required this.headline, required this.value});
  final String headline, value;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      color: Colors.white70,
      child: Row(
        children: [
          Text(
            headline,
            style: AppTextStyles.semiBold16.copyWith(color: Colors.black),
          ),
          const Spacer(),
          Text(
            value,
            style: AppTextStyles.semiBold16.copyWith(color: Colors.black),
          ),
        ],
      ),
    );
  }
}
