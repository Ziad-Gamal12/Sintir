import 'package:flutter/material.dart';

class ReportStatCardCornerTab extends StatelessWidget {
  const ReportStatCardCornerTab({super.key, required this.color});
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 16,
      height: 16,
      decoration: BoxDecoration(
        color: color,
        borderRadius:
            const BorderRadiusDirectional.only(bottomEnd: Radius.circular(12)),
      ),
    );
  }
}
