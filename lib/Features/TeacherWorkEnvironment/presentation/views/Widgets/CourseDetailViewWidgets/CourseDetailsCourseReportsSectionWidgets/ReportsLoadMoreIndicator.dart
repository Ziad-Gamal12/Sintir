import 'package:flutter/material.dart';

class ReportsLoadMoreIndicator extends StatelessWidget {
  const ReportsLoadMoreIndicator({super.key});
  @override
  Widget build(BuildContext context) => const Padding(
      padding: EdgeInsets.all(18),
      child: Center(
          child: SizedBox(
              width: 24,
              height: 24,
              child: CircularProgressIndicator(strokeWidth: 2))));
}
