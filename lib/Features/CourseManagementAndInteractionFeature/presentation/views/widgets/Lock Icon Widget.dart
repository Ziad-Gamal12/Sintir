import 'package:flutter/material.dart';

class LockIcon extends StatelessWidget {
  const LockIcon({super.key});

  @override
  Widget build(BuildContext context) {
    return Icon(
      Icons.lock,
      color: Colors.red.shade700,
      size: 30,
    );
  }
}
