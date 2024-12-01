import 'package:flutter/widgets.dart';
import 'package:sintir/Core/entities/Drawer_Entity.dart';
import 'package:sintir/Core/widgets/CustomDrawerWidgets/CustomInActiveDrawerItem.dart';
import 'package:sintir/Core/widgets/CustomDrawerWidgets/customActiveDrawerItem.dart';

class Draweritem extends StatelessWidget {
  const Draweritem(
      {super.key, required this.drawerEntity, required this.isSelected});
  final DrawerEntity drawerEntity;
  final bool isSelected;
  @override
  Widget build(BuildContext context) {
    return isSelected == true
        ? Customactivedraweritem(
            drawerEntity: drawerEntity,
          )
        : Custominactivedraweritem(
            drawerEntity: drawerEntity,
          );
  }
}
