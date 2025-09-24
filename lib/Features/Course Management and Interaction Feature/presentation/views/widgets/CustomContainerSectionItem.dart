import 'package:flutter/material.dart';

class Customcontainersectionitem extends StatelessWidget {
  const Customcontainersectionitem({super.key, required this.child});
  final Widget child;
  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        alignment: AlignmentDirectional.center,
        width: double.infinity,
        decoration: BoxDecoration(
            color: Colors.grey.shade100,
            borderRadius: BorderRadius.circular(8)),
        child: child);
  }
}
