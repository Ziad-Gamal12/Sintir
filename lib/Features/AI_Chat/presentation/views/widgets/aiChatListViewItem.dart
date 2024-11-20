import 'package:flutter/material.dart';
import 'package:sintir/Core/utils/textStyles.dart';

class Aichatlistviewitem extends StatelessWidget {
  const Aichatlistviewitem(
      {super.key, required this.message, required this.isUserMessage});
  final String message;
  final bool isUserMessage;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: isUserMessage == false
            ? Colors.transparent
            : const Color(0xfff3f3f3),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Text(
        message,
        style: AppTextStyles.regular14.copyWith(color: Colors.black),
      ),
    );
  }
}
