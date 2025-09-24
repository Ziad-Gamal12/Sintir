import 'package:flutter/material.dart';
import 'package:sintir/Core/entities/Drawer_Entity.dart';
import 'package:sintir/Core/utils/imageAssets.dart';
import 'package:sintir/Core/widgets/CustomDrawerWidgets/CustomInActiveDrawerItem.dart';

class CustomDrawerSettingsWidget extends StatelessWidget {
  const CustomDrawerSettingsWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Custominactivedraweritem(
        drawerEntity: DrawerEntity(
          title: "اعدادات النظام",
          activeIcon: Assets.assetsImagesSetting,
          inActiveIcon: Assets.assetsImagesSetting,
          routeName: "",
        ),
      ),
    );
  }
}
