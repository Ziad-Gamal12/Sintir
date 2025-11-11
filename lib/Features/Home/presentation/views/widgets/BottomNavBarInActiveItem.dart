import 'package:flutter/material.dart';
import 'package:sintir/Features/Home/Domain/Entities/BottomNavBarEntity.dart';
import 'package:svg_flutter/svg.dart';

class BottomNavBarInActiveItem extends StatelessWidget {
  const BottomNavBarInActiveItem({super.key, required this.bottomNavBarEntity});
  final BottomNavBarEntity bottomNavBarEntity;

  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset(
      bottomNavBarEntity.inactiveIcon,
      color: Colors.black,
    );
  }
}
