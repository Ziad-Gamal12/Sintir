import 'package:flutter/material.dart';
import 'package:sintir/Core/utils/textStyles.dart';

class CustomPersonalDetailsRowItem extends StatelessWidget {
  const CustomPersonalDetailsRowItem(
      {super.key, required this.text, required this.icon});
  final String text;
  final IconData icon;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: 10,
      ),
      child: Container(
        padding: const EdgeInsets.all(15),
        decoration: BoxDecoration(
            color: Colors.grey.shade50,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: Colors.grey)),
        child: Row(children: [
          Icon(icon, color: Colors.black, size: 20),
          const SizedBox(width: 10),
          Text(text,
              style: AppTextStyles.regular16.copyWith(color: Colors.black))
        ]),
      ),
    );
  }
}
