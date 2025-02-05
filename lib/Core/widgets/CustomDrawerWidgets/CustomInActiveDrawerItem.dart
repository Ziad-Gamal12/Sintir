// ignore_for_file: must_be_immutable, file_names

import 'package:flutter/material.dart';
import 'package:sintir/Core/entities/Drawer_Entity.dart';
import 'package:sintir/Core/utils/textStyles.dart';

class Custominactivedraweritem extends StatelessWidget {
  Custominactivedraweritem(
      {super.key, required this.drawerEntity, this.iconColor});
  final DrawerEntity drawerEntity;
  Color? iconColor;
  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(
        drawerEntity.title,
        style: AppTextStyles.regular16.copyWith(color: Colors.black),
      ),
      leading: Image.asset(
        drawerEntity.inActiveIcon,
        color: iconColor ?? Colors.black,
        height: 24,
        width: 24,
      ),
    );
  }
}
