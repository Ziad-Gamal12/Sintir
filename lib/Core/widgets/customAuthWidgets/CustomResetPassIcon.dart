import 'package:flutter/material.dart';
import 'package:sintir/constant.dart';

class CustomResetPassIcon extends StatelessWidget {
  const CustomResetPassIcon({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.white,
        border: Border.all(
          color: Colors.blue.withOpacity(.25),
          width: 1.2,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.blueAccent.withOpacity(.1),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: const Icon(
        Icons.lock_reset_rounded,
        size: 55,
        color: KMainColor,
      ),
    );
  }
}
