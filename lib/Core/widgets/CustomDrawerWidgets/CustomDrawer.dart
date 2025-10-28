import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:sintir/Core/entities/Drawer_Entity.dart';
import 'package:sintir/Core/helper/GetUserData.dart';
import 'package:sintir/Core/utils/Variables.dart';
import 'package:sintir/Core/widgets/CustomDrawerWidgets/CustomDrawerSettingsWidget.dart';
import 'package:sintir/Core/widgets/CustomDrawerWidgets/CustomDrawerSignOutWidget.dart';
import 'package:sintir/Core/widgets/CustomDrawerWidgets/CustomdrawerUserListTile.dart';
import 'package:sintir/Core/widgets/CustomDrawerWidgets/Draweritem.dart';
import 'package:sintir/Features/Auth/Domain/Entities/UserEntity.dart';

class Customdrawer extends StatefulWidget {
  const Customdrawer({super.key});

  @override
  State<Customdrawer> createState() => _CustomdrawerState();
}

class _CustomdrawerState extends State<Customdrawer> {
  UserEntity user = getUserData();
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
                  child: CustomdrawerUserListTile(user: user),
                ),
              ),
              const SliverToBoxAdapter(
                child: SizedBox(
                  height: 8,
                ),
              ),
              SliverToBoxAdapter(
                  child: Column(
                children: DrawerEntity.toList().asMap().entries.map((e) {
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
              const SliverFillRemaining(
                hasScrollBody: false,
                child: Column(
                  children: [
                    Spacer(),
                    CustomDrawerSettingsWidget(),
                    SizedBox(
                      height: 20,
                    ),
                    CustomDrawerSignOutWidget(),
                    SizedBox(
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
