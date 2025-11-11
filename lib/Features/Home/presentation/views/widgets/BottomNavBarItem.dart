import 'package:flutter/material.dart';
import 'package:sintir/Features/Home/Domain/Entities/BottomNavBarEntity.dart';
import 'package:sintir/Features/Home/presentation/views/widgets/BottomNavBarActiveItem.dart';
import 'package:sintir/Features/Home/presentation/views/widgets/BottomNavBarInActiveItem.dart';

class BottomNavBarItem extends StatelessWidget {
  const BottomNavBarItem(
      {super.key, required this.bottomNavBarEntity, required this.isSelected});
  final BottomNavBarEntity bottomNavBarEntity;
  final bool isSelected;
  @override
  Widget build(BuildContext context) {
    if (isSelected) {
      return BottomNavBarActiveItem(
        bottomNavBarEntity: bottomNavBarEntity,
      );
    }
    return BottomNavBarInActiveItem(
      bottomNavBarEntity: bottomNavBarEntity,
    );
  }
}
