import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:sintir/Core/entities/Drawer_Entity.dart';
import 'package:sintir/Core/services/FirebaseAuth_Service.dart';
import 'package:sintir/Core/utils/imageAssets.dart';
import 'package:sintir/Core/widgets/CustomDrawerWidgets/CustomInActiveDrawerItem.dart';
import 'package:sintir/Features/ChoosingUserKind/Presentation/views/ChoosingUserKindView.dart';

class CustomDrawerSignOutWidget extends StatelessWidget {
  const CustomDrawerSignOutWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () async {
        await firebaseAuthService().signout();
        if (context.mounted) {
          GoRouter.of(context).pushReplacement(ChoosingUserKindView.routeName);
        }
      },
      child: Custominactivedraweritem(
        drawerEntity: DrawerEntity(
            title: "تسجيل الخروج",
            inActiveIcon: Assets.assetsIconsLogout,
            activeIcon: Assets.assetsIconsLogout,
            routeName: ChoosingUserKindView.routeName),
        iconColor: Colors.red,
      ),
    );
  }
}
