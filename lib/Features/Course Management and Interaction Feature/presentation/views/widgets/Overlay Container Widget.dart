import 'package:flutter/material.dart';
import 'package:sintir/Features/Course%20Management%20and%20Interaction%20Feature/presentation/views/widgets/Lock%20Message%20Widget.dart';

class OverlayContainer extends StatelessWidget {
  const OverlayContainer({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.black.withOpacity(0.28),
        borderRadius: BorderRadius.circular(8),
      ),
      alignment: Alignment.center,
      child: const LockMessage(),
    );
  }
}
