import 'package:flutter/material.dart';

class CustominactiveitemBottomnavigationbar extends StatelessWidget {
  const CustominactiveitemBottomnavigationbar({super.key, required this.icon});
  final IconData icon;
  @override
  Widget build(BuildContext context) {
    return Icon(
      icon,
      color: Colors.black,
      size: 20,
    );
  }
}
