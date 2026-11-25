import 'package:flutter/material.dart';

class Customsolutionstatecheckboxwidget extends StatelessWidget {
  const Customsolutionstatecheckboxwidget({super.key, required this.isCorrect});
  final bool isCorrect;

  static const double size = 28;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: size,
      width: size,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: isCorrect ? Colors.green : Colors.red,
      ),
      child: Icon(
        isCorrect ? Icons.check : Icons.close,
        color: Colors.white,
        size: 20,
      ),
    );
  }
}
