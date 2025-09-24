import 'package:flutter/material.dart';

class CustomCard extends StatelessWidget {
  const CustomCard({super.key, required this.child});
  final Widget child;
  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.shade200,
              blurRadius: 50,
              spreadRadius: 1,
              offset: const Offset(5, 15),
            )
          ],
          borderRadius: BorderRadius.circular(20),
        ),
        child: child);
  }
}
