import 'package:flutter/material.dart';

class ContentContainer extends StatelessWidget {
  const ContentContainer({super.key, required this.child});
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.grey.shade100,
            blurRadius: 7,
            spreadRadius: 1,
          ),
        ],
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Colors.black, width: .5),
        color: Colors.grey.shade100,
      ),
      child: child,
    );
  }
}
