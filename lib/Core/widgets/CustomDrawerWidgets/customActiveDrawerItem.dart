import 'package:flutter/material.dart';
import 'package:sintir/Core/entities/Drawer_Entity.dart';
import 'package:sintir/Core/utils/textStyles.dart';
import 'package:sintir/constant.dart';

class Customactivedraweritem extends StatelessWidget {
  const Customactivedraweritem({super.key, required this.drawerEntity});
  final DrawerEntity drawerEntity;
  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(
        drawerEntity.title,
        style: AppTextStyles(context).bold16.copyWith(color: KMainColor),
      ),
      leading: Image.asset(
        drawerEntity.activeIcon,
        color: KMainColor,
        height: 24,
        width: 24,
      ),
      trailing: Container(
        height: double.infinity,
        width: 3.27,
        color: KMainColor,
      ),
    );
  }
}
