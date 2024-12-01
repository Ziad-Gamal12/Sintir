import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:sintir/Core/entities/Drawer_Entity.dart';
import 'package:sintir/Core/models/DrawerModel.dart';
import 'package:sintir/Core/utils/Variables.dart';
import 'package:sintir/Core/utils/imageAssets.dart';
import 'package:sintir/Core/widgets/CustomDrawerWidgets/CustomInActiveDrawerItem.dart';
import 'package:sintir/Core/widgets/CustomDrawerWidgets/Draweritem.dart';
import 'package:sintir/Core/widgets/customListTileWidget.dart';
import 'package:sintir/Features/ChoosingState/Presentation/views/ChoosingStateView.dart';

class Customdrawer extends StatefulWidget {
  const Customdrawer({super.key});

  @override
  State<Customdrawer> createState() => _CustomdrawerState();
}

class _CustomdrawerState extends State<Customdrawer> {
  int currentdraweritemIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Colors.white,
      child: SafeArea(
        child: Container(
          color: Colors.white,
          child: CustomScrollView(
            slivers: [
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: Customlisttilewidget(
                      title: "Lekan Okeowo",
                      subtitle: "demo@gmail.com",
                      image: Assets.assetsImagesUserAvatar),
                ),
              ),
              const SliverToBoxAdapter(
                child: SizedBox(
                  height: 8,
                ),
              ),
              SliverToBoxAdapter(
                  child: Column(
                children: DrawerModel.toList().asMap().entries.map((e) {
                  return InkWell(
                      onTap: () {
                        if (currentdraweritemIndex != e.key) {
                          setState(() {
                            currentdraweritemIndex = e.key;
                          });
                          GoRouter.of(context).push(e.value.routeName);
                          Variables.HomeViewScaffoldKey.currentState!
                              .closeEndDrawer();
                        }
                      },
                      child: Draweritem(
                          isSelected:
                              currentdraweritemIndex == e.key ? true : false,
                          drawerEntity: e.value));
                }).toList(),
              )),
              SliverFillRemaining(
                hasScrollBody: false,
                child: Column(
                  children: [
                    const Spacer(),
                    Custominactivedraweritem(
                      drawerEntity: DrawerEntity(
                        title: "اعدادات النظام",
                        activeIcon: Assets.assetsImagesSetting,
                        inActiveIcon: Assets.assetsImagesSetting,
                        routeName: "",
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Custominactivedraweritem(
                      drawerEntity: DrawerEntity(
                          title: "تسجيل الخروج",
                          inActiveIcon: Assets.assetsImagesLogout,
                          activeIcon: Assets.assetsImagesLogout,
                          routeName: Choosingstateview.routeName),
                      iconColor: Colors.red,
                    ),
                    const SizedBox(
                      height: 48,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
