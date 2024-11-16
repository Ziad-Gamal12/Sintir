// ignore_for_file: camel_case_types

import 'package:flutter/material.dart';
import 'package:sintir/Core/entities/BottomNavigationBar_Entity.dart';
import 'package:sintir/Features/Home/presentation/views/widgets/CustomActiveItem_BottomNavigationBar.dart';
import 'package:sintir/Features/Home/presentation/views/widgets/CustomINActiveItem_BottomNavigationBar.dart';

class CustomItem_bottomnavigationbar extends StatelessWidget {
  const CustomItem_bottomnavigationbar(
      {super.key, required this.isSelected, required this.item});
  final bool isSelected;
  final BottomnavigationbarEntity item;

  @override
  Widget build(BuildContext context) {
    return isSelected == true
        ? CustomactiveitemBottomnavigationbar(
            icon: item.icon, title: item.title)
        : CustominactiveitemBottomnavigationbar(icon: item.icon);
  }
}
